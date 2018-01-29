global class DocuSignConnection {
    private static String integrationKey;
    private static String userName;
    private static String password;
    private static String dsAcctId;
    private static String baseURL;
    private static String baseEndPoint;
    private static String authType;
    private static String auth;

    /**
     * Base constructor where the various pieces are provided 
     *
     * @param      integrationKey  The integration key
     * @param      userName        The user name
     * @param      password        The password
     * @param      accountId       The account identifier
     * @param      baseURL         The base URL
     *
     * @return     The DocuSignConnection object
     */
    global DocuSignConnection (String integrationKey, String userName, String password, String accountId, String baseURL) {
        createDocuSignConnection(integrationKey, userName,password,accountId,baseURL);
    }

    /**
     * Constructs a DocuSign connection object from a DocuSign for Salesforce Account configuration record
     *
     * @param      dfsAccountConfig  The DocuSign For Salesforce Account Configuration record
     *
     * @return     The DocuSignConnection object
     */
    global DocuSignConnection (SObject dfsAccountConfig) {
        createDocuSignConnection (
            dfsAccountConfig != null ? (String)dfsAccountConfig.get('IntegratorsKey__c') : 'integrationKey',
            dfsAccountConfig != null ? (String)dfsAccountConfig.get('dsfs__DSProSFUsername__c') : 'userName',
            dfsAccountConfig != null ? (String)dfsAccountConfig.get('dsfs__DSProSFPassword__c') : 'password',
            dfsAccountConfig != null ? (String)dfsAccountConfig.get('dsfs__AccountId__c') : 'dsAcctId',
            dfsAccountConfig != null ? (String)dfsAccountConfig.get('dsfs__DocuSignBaseURL__c') : 'baseURL'
        );
    }

    /**
     * Constructs the authentication object for the specified authentication type
     *
     * @param      authenticationType  The authentication type
     *
     * @return     The constructed DocuSign connection type
     */
    global DocuSignConnection (String authenticationType) {
         authType = String.isBlank(authenticationType) ? '' : authenticationType;
        if (authType.equalsIgnoreCase('DFS') || String.isBlank(authType)) {
            createWithDocusignForSalesforce();
        }
    }

    global DocuSignConnection () {
        createWithDocusignForSalesforce();
    }


    /**
     * Creates a DocuSign Connection object utilizing a DocuSign for Salesforce record.
     *
     * @return     The DocuSignConnection object
     */
    global DocuSignConnection createWithDocusignForSalesforce() {
        DocuSignConnection returnRecord;

        List<SObject> dfsAcctConfigs = new List<SObject>();

        try {
            dfsAcctConfigs = Database.query(dfsAcctConfigQueryBuilder());
        } catch (Exception e) {
            if (e.getMessage().contains('sObject type \'dsfs__DocuSignAccountConfiguration__c\' is not supported')){throw new dfsException('DocuSign For Salesforce is not installed! Please use another authentication method!');System.debug('DocuSign For Salesforce is not installed! Please use another authentication method!');}
        }
        SObject dsAcctConfig = !dfsAcctConfigs.isEmpty() ? dfsAcctConfigs[0] : null;
        returnRecord = new DocuSignConnection(dsAcctConfig);

        return returnRecord;

    }

    private class dfsException extends Exception {}

    /**
     * Gets all templates from DocuSign.
     *
     * @return     All templates response.
     */
    global HttpResponse getAllTemplates() {
        
        HttpRequest req = setupBaseRequest(null);
        req.setEndpoint(baseEndPoint+'/templates');
        req.setMethod('GET');

        HttpResponse res;
        if (Test.isRunningTest()) {
            res = new HttpResponse();
            res.setBody(DocuSignConnectionTests.envelopeTemplates);
            res.setStatusCode(200);
            res.setStatus('OK');
        }
        if (!Test.isRunningTest()) res = new Http().send(req);
        return res;
    }

    /**
     * Creates an envelope.
     *
     * @param      body  The request body 
     *
     * @return     The HTTP Response
     */
    global HttpResponse createEnvelope(String body) {
        HttpRequest req = setupBaseRequest(null);
        req.setEndpoint(baseEndPoint+'/envelopes');
        req.setMethod('POST');
        req.setBody(body);
        HttpResponse res;
        if (Test.isRunningTest()) {
            res = new HttpResponse();
            res.setBody(DocuSignConnectionTests.envelopeCreateReponse);
            res.setStatusCode(200);
            res.setStatus('OK');
        }
        if (!Test.isRunningTest()) res = new Http().send(req);
        return res;
    }

    /**
     * Gets a template via the DocuSign API.
     *
     * @param      templateId  The template id to retrieve
     *
     * @return     The template HTTP Response.
     */
    global HttpResponse getTemplate(String templateId) {
        HttpRequest req = setupBaseRequest(null);
        req.setEndpoint(baseEndPoint+'/templates/'+templateId);
        req.setMethod('GET');
        
        return new Http().send(req);
    }

    /**
     * Gets an envelope via the DocuSign API.
     *
     * @param      envelopeId  The envelope id to retrieve 
     *
     * @return     The envelope HTTP Response.
     */
    global HttpResponse getEnvelope(String envelopeId) {
        HttpRequest req = setupBaseRequest(null);
        req.setEndpoint(baseEndPoint+'/envelopes/'+envelopeId);
        req.setMethod('GET');
        
        HttpResponse res;
        if (Test.isRunningTest()) {
            res = new HttpResponse();
            res.setBody(DocuSignConnectionTests.envelopeTemplateDefinition);
            res.setStatusCode(200);
            res.setStatus('OK');
        }
        if (!Test.isRunningTest()) res = new Http().send(req);
        return res;
    }

    /**
     * Gets the envelope custom fields.
     *
     * @param      envelopeId  The envelope identifier
     *
     * @return     The envelope custom fields.
     */
    global HttpResponse getEnvelopeCustomFields(String envelopeId) {
        HttpRequest req = setupBaseRequest(null);
        req.setEndpoint(baseEndPoint+'/envelopes/'+envelopeId+'/custom_fields');
        req.setMethod('GET');
        
        HttpResponse res;
        if (Test.isRunningTest()) {
            res = new HttpResponse();
            res.setBody(DocuSignConnectionTests.envCustomFields);
            res.setStatusCode(200);
            res.setStatus('OK');
        }
        if (!Test.isRunningTest()) res = new Http().send(req);
        return res;
    }

    /**
     * Set's up the base authorization and content settings
     *
     * @param      req   The request
     *
     * @return     The setup updated request
     */
    private HttpRequest setupBaseRequest(HttpRequest req) {
        req = req == null ? new HttpRequest() : req;
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Accept', 'application/json');
        auth = String.isBlank(auth) ? createLegacyAuthString() : auth;
        //WIll need to update this at a later point to use multiple authentication types
        req.setHeader('X-DocuSign-Authentication', auth);

        return req;
    }

    /**
     * Sets up the object based on the string parameters passed
     *
     * @param      integrationKeyString  The integration key
     * @param      userNameString        The user name
     * @param      passwordString        The password
     * @param      accountIdString       The account identifier
     * @param      baseURLString         The base URL
     *
     * @return     The DocuSignConnection object
     */
    private static void createDocuSignConnection (String integrationKeyString, String userNameString, String passwordString, String accountIdString, String baseURLString) {
        integrationKey = integrationKeyString;
        userName = userNameString;
        password = passwordString;
        dsAcctId = accountIdString;
        baseURL = baseURLString;
        baseEndPoint = baseURL + 'restapi/v2/accounts/'+dsAcctId;
    }

    /**
     * Creates a legacy authorization string.
     *
     * @return     The authorization string
     */
    private String createLegacyAuthString() {
        return '<DocuSignCredentials>'
              +     '<Username>'+userName+'</Username>' 
              +     '<Password>'+password+'</Password>' 
              +     '<IntegratorKey>'+integrationKey+'</IntegratorKey>'
              +'</DocuSignCredentials>';
    }

    /**
     * Constructs a DocuSign For Salesforce query without passing an account id
     *
     * @return     The DocuSign For Salesforce Query
     */
    private String dfsAcctConfigQueryBuilder()  {
        return dfsAcctConfigQueryBuilder(null);
    }

    /**
     * Constructs a DocuSign For Salesforce query with an account id that will be used as a filter
     *
     * @param      accountId  The DocuSIgn account identifier
     *
     * @return     The DocuSign For Salesforce Query
     */
    private String dfsAcctConfigQueryBuilder(String accountId) {
        String query;
        query = 'SELECT '+Label.DocuSign_DFS_Base_Query+' ';
        query +='FROM dsfs__DocuSignAccountConfiguration__c ';
        query +=String.isBlank(accountId) ? ' ' : 'WHERE dsfs__AccountId__c = :accountId ';
        query +='ORDER BY CreatedDate';

        return query;
    }
}