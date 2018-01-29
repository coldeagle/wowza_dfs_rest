public without sharing class CodeSamples implements Database.AllowsCallouts {
    
    /**
     * Gets the DocuSign templates.
     *
     * @param      res      The http response
     * @param      rtNames  The record type names
     *
     * @return     The DocuSign templates.
     */
    private static Map<String,DocuSignType.Template> getDocusignTemplates(HttpResponse res, List<String> rtNames) {
        //Getting the DocuSign templates
        DocuSignType.EnvelopeTemplates templates = (DocuSignType.EnvelopeTemplates) JSON.deserialize(res.getBody(), DocuSignType.EnvelopeTemplates.class);
        String sfdcPrefix = 'SFDC-';//Label.DocuSign_Template_SFDC_Prefix;
        Map<String,DocuSignType.Template> templateName2TemplateMap = new Map<String,DocuSignType.Template>();
        Integer i=0;
        //Finding Salesforce related templates
        for (DocuSignType.Template temp : templates.EnvelopeTemplates) {
            //Setting up some logic here to handle mock responses so we have templates to match on in the code
            String templateName = (Test.isRunningTest() && rtNames != null && i<rtNames.size()) ? sfdcPrefix + rtNames[i++] : temp.Name;
            if(templateName.startsWith(sfdcPrefix)) templateName2TemplateMap.put(templateName.replace(sfdcPrefix, ''),temp);
        }

        return templateName2TemplateMap;
    }

    /**
     * Sets up the DocuSign envelope 
     *
     * @param      contr       The contract
     * @param      template    The template
     * @param      contactMap  The contact map
     * @param      userMap     The user map
     *
     * @return     The defined envelope 
     */
    private static DocuSignType.EnvelopeDefinition setupEnvelope(Contract contr, DocuSignType.Template template, Map<Id,Contact> contactMap, Map<Id,User> userMap) {
        DocuSignType.EnvelopeDefinition dsEnv = new DocuSignType.EnvelopeDefinition();
        dsEnv.TemplateId = template.templateId;
        dsEnv.allowReassign = 'false';
        dsEnv.recipientsLock = 'true';
        dsEnv.status = 'sent';
        dsEnv.templateRoles = new List<DocuSignType.TemplateRole> ();
        Id signingContactId;
        //Looking for the contract role that matches the signer role on the contract, once found we will add them as a signer
        for (ContractContactRole ccr : contr.ContractContactRoles) {
            if (ccr.Role == contr.CustomerSigningRole__c) {
                signingContactId = ccr.ContactId;
                dsEnv.TemplateRoles.add(new DocuSignType.TemplateRole(ccr.Role,contactMap.get(signingContactId), true));
                break;
            }
        }
        signingContactId = signingContactId == null ? contr.CustomerSignedId : signingContactId;
        String salesRoleName = 'RoleName';//Label.DocuSign_Sales_Role_Name;
        //Adding the template role for the owner
        dsEnv.templateRoles.add(new DocuSignType.TemplateRole(salesRoleName,userMap.get(contr.OwnerId)));
        //Setting up the custom fields
        DocuSignType.CustomFields cfs = new DocuSignType.CustomFields();
        cfs.textCustomFields = new List<DocuSignType.TextCustomFields>();
        cfs.textCustomFields.add(new DocuSignType.TextCustomFields(contr.Id));
        cfs.textCustomFields.add(new DocuSignType.TextCustomFields(contr.AccountId));
        if (signingContactId != null ) cfs.textCustomFields.add(new DocuSignType.TextCustomFields(signingContactId));
        //Adding the custom fields to the envelope
        dsEnv.CustomFields = cfs;

        return dsEnv;
    }

    /**
     * Function will update the contract based on the http response from DocuSign 
     *
     * @param      contr  The contract
     * @param      dsEnv  The DocuSign envelope
     * @param      res    The http response 
     *
     * @return     The updated contract
     */
    private static Contract updateContractAfterEnvelopeSend(Contract contr, DocuSignType.EnvelopeDefinition dsEnv, HttpResponse res) {
        Contract returnContract;
        if (res.getStatusCode()>=200 && res.getStatusCode()<=202) {
            //Processing the result 
            DocuSignType.Envelope env = (DocuSignType.Envelope) JSON.deserialize(res.getBody(),DocuSignType.Envelope.class);
            contr.DocuSignEnvelopeId__c = env.envelopeId;
            contr.DocuSignStatus__c = dsEnv.status;
            contr.Status = 'Waiting for customer signature';//Label.Contract_Waiting_For_Customer_Signature;
            returnContract = contr;
        }

        return returnContract;
    }