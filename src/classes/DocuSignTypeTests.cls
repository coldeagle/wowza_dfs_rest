@isTest
private class DocuSignTypeTests {
	/*private static List<String> g_zAcctNums = new List<String>{'1244648','2424464'};
	private static List<String> g_zSubNums = new List<String>{'S-123456','S-212345'};
	*/
	private static String g_ClassNm = 'DocuSignTypeTests';
	
    @testSetup static void createData() {
		//Map<String,List<SObject>> defaultDataMap = TestUtil.createDefaultDataSet(g_ClassNm,g_zAcctNums,g_zSubNums);
    }

	@isTest static void wrapperTypeTest() {
		Test.startTest();
		Id currUserID = UserInfo.getUserId();
		List<User> currUserList = Database.query('SELECT Id, FirstName, LastName, Email FROM User WHERE Id =:currUserID');
		User currentUser = currUserList[0];
		//Have to run through all of the default constructors (which are required for JSON deserialization)
		DocuSignType.Account dsAcct = new DocuSignType.Account();
		DocuSignType.BulkEnvelope dsBulkEnv = new DocuSignType.BulkEnvelope();
		DocuSignType.Documents dsDocs = new DocuSignType.Documents();
		DocuSignType.Document dsDoc = new DocuSignType.Document();
		//DocuSignType.MatchBoxes dsMatchBoxes = new DocuSignType.MatchBoxes();
		DocuSignType.MatchBox dsMatchBox = new DocuSignType.MatchBox();
		DocuSignType.EnvelopeRecipients envRecip = new DocuSignType.EnvelopeRecipients();
		DocuSignType.Recipients recipients = new DocuSignType.Recipients();
		DocuSignType.Agents agents = new DocuSignType.Agents();
		DocuSignType.Agent agent = new DocuSignType.Agent();
		DocuSignType.EmailNotification emailNotification = new DocuSignType.EmailNotification();
		DocuSignType.Signers signers = new DocuSignType.Signers();
		DocuSignType.Signer signer = new DocuSignType.Signer();
		DocuSignType.InPersonSigners inPersonSigners = new DocuSignType.InPersonSigners();
		DocuSignType.InPersonSigner inpersonSigner = new DocuSignType.InPersonSigner();
		DocuSignType.Intermediaries intermediaries = new DocuSignType.Intermediaries();
		DocuSignType.Intermediary intermediary = new DocuSignType.Intermediary();
		DocuSignType.Editors editors = new DocuSignType.Editors();
		DocuSignType.Editor editor = new DocuSignType.Editor();
		DocuSignType.CarbonCopies ccs = new DocuSignType.CarbonCopies();
		DocuSignType.CarbonCopy cc = new DocuSignType.CarbonCopy();
		DocuSignType.CertifiedDelivery certifiedDelivery = new DocuSignType.CertifiedDelivery();
		DocuSignType.CustomFields cfs = new DocuSignType.CustomFields();
		DocuSignType.TextCustomFields tcfs = new DocuSignType.TextCustomFields();
		
		//Testing the text custom field constructor with data passed
		tcfs = new DocuSignType.TextCustomFields(currentUser.Id);
		System.assertEquals('User', tcfs.name);
		System.assertEquals(currentUser.Id,tcfs.value);
		
		DocuSignType.ListCustomFields lcfs = new DocuSignType.ListCustomFields();
		DocuSignType.ErrorDetails eds = new DocuSignType.ErrorDetails();
		DocuSignType.TemplateRoles trs = new DocuSignType.TemplateRoles();
		trs = new DocuSignType.TemplateRoles(trs.templateRoles);
		DocuSignType.TemplateRole tr = new DocuSignType.TemplateRole();
		//Testing the role definitions to make sure that they're all setup correctly by the constructor
		String defaultRole = 'Wowza Requester';
		tr = new DocuSignType.TemplateRole(defaultRole,currentUser);
		System.assertEquals(defaultRole,tr.roleName);
		System.assertEquals(currentUser.Email, tr.email);
		System.assertEquals('false', tr.defaultRecipient);

		tr = new DocuSignType.TemplateRole(defaultRole,currentUser, true);
		System.assertEquals(defaultRole,tr.roleName);
		System.assertEquals(currentUser.Email, tr.email);
		System.assertEquals('true', tr.defaultRecipient);

		DocuSignType.RecipientEmailNotification ren = new DocuSignType.RecipientEmailNotification();
		DocuSignType.EnvelopeTabs envTabs = new DocuSignType.EnvelopeTabs();
		DocuSignType.Tab tab = new DocuSignType.Tab();
		DocuSignType.FormattedTab fTab = new DocuSignType.FormattedTab();
		DocuSignType.FormattedValidationTab fValTab = new DocuSignType.FormattedValidationTab();
		//DocuSignType.InitialHereTabs initHereTabs = new DocuSignType.InitialHereTabs();
		DocuSignType.InitialHereTab initHereTab = new DocuSignType.InitialHereTab();
		//DocuSignType.SignerAttachmentTabs signAttTabs = new DocuSignType.SignerAttachmentTabs();
		DocuSignType.SignerAttachmentTab signAttTab = new DocuSignType.SignerAttachmentTab();
		//DocuSignType.SignHereTabs signHereTabs = new DocuSignType.SignHereTabs();
		DocuSignType.SignHereTab signHereTab = new DocuSignType.SignHereTab();
		//DocuSignType.CheckboxTabs cbTabs = new DocuSignType.CheckboxTabs();
		DocuSignType.CheckboxTab cbTab = new DocuSignType.CheckboxTab();
		//DocuSignType.CompanyTabs compTabs = new DocuSignType.CompanyTabs();
		DocuSignType.CompanyTab compTab = new DocuSignType.CompanyTab();
		//DocuSignType.FullNameTabs fullNmTabs = new DocuSignType.FullNameTabs();
		DocuSignType.FullNameTab fullNmTab = new DocuSignType.FullNameTab();
		//DocuSignType.TitleTabs titleTabs = new DocuSignType.TitleTabs();
		DocuSignType.TitleTab titleTab = new DocuSignType.TitleTab();
		//DocuSignType.ApproveTabs approvalTabs = new DocuSignType.ApproveTabs();
		DocuSignType.ApproveTab approvalTab = new DocuSignType.ApproveTab();
		//DocuSignType.EnvelopeIdTabs envIdTabs = new DocuSignType.EnvelopeIdTabs();
		DocuSignType.EnvelopeIdTab envIdTab = new DocuSignType.EnvelopeIdTab();
		//DocuSignType.FirstNameTabs fnTabs = new DocuSignType.FirstNameTabs();
		DocuSignType.FirstNameTab fnTab = new DocuSignType.FirstNameTab();
		//DocuSignType.LastNameTabs lnTabs = new DocuSignType.LastNameTabs();
		DocuSignType.LastNameTab lnTab = new DocuSignType.LastNameTab();
		//DocuSignType.DateSignedTabs dtSignedTabs = new DocuSignType.DateSignedTabs();
		DocuSignType.DateSignedTab dtSignedTab = new DocuSignType.DateSignedTab();
		//DocuSignType.ListTabs listTabs = new DocuSignType.ListTabs();
		DocuSignType.ListTab listTab = new DocuSignType.ListTab();
		//DocuSignType.EmailAddressTabs eAddrTabs = new DocuSignType.EmailAddressTabs();
		DocuSignType.EmailAddressTab eAddrTab = new DocuSignType.EmailAddressTab();
		//DocuSignType.DeclineTabs declineTabs = new DocuSignType.DeclineTabs();
		DocuSignType.DeclineTab declineTab = new DocuSignType.DeclineTab();
		//DocuSignType.ZipTabs zipTabs = new DocuSignType.ZipTabs();
		DocuSignType.ZipTab zipTab = new DocuSignType.ZipTab();
		//DocuSignType.ListItems listItems = new DocuSignType.ListItems();
		DocuSignType.ListItem listItem = new DocuSignType.ListItem();
		//DocuSignType.EmailTabs emailTabs = new DocuSignType.EmailTabs();
		DocuSignType.EmailTab emailTab = new DocuSignType.EmailTab();
		//DocuSignType.FormulaTabs fmlTabs = new DocuSignType.FormulaTabs();
		DocuSignType.FormulaTab fmlTab = new DocuSignType.FormulaTab();
		//DocuSignType.TextTabs txtTabs = new DocuSignType.TextTabs();
		DocuSignType.TextTab txtTab = new DocuSignType.TextTab();
		//DocuSignType.NoteTabs ntTabs = new DocuSignType.NoteTabs();
		DocuSignType.NoteTab ntTab = new DocuSignType.NoteTab();
		//DocuSignType.NumberTabs numTabs = new DocuSignType.NumberTabs();
		DocuSignType.NumberTab numTab = new DocuSignType.NumberTab();
		//DocuSignType.DateTabs dtTabs = new DocuSignType.DateTabs();
		DocuSignType.DateTab dtTab = new DocuSignType.DateTab();
		//DocuSignType.SsnTabs ssnTabs = new DocuSignType.SsnTabs();
		DocuSignType.SsnTab ssnTab = new DocuSignType.SsnTab();
		//DocuSignType.RadioGroupTabs rGroupTabs = new DocuSignType.RadioGroupTabs();
		DocuSignType.RadioGroup rGroup = new DocuSignType.RadioGroup();
		//DocuSignType.Radios radios = new DocuSignType.Radios();
		DocuSignType.Radio radio = new DocuSignType.Radio();
		DocuSignType.MergeField mrgFld = new DocuSignType.MergeField();
		DocuSignType.Envelope env = new DocuSignType.Envelope();
		DocuSignType.EnvelopeDefinition envDef = new DocuSignType.EnvelopeDefinition();
		DocuSignType.CompositeTemplates compTemps = new DocuSignType.CompositeTemplates();
		DocuSignType.CompositeTemplate compTemp = new DocuSignType.CompositeTemplate();
		DocuSignType.InlineTemplates inlineTemplates = new DocuSignType.InlineTemplates();
		DocuSignType.InlineTemplate inlineTemplate = new DocuSignType.InlineTemplate();
		DocuSignType.SigningGroup signingGroup = new DocuSignType.SigningGroup();
		DocuSignType.EnvelopeTemplates envelopeTemplates = new DocuSignType.EnvelopeTemplates();
		DocuSignType.EnvelopeTemplate envTemplate = new DocuSignType.EnvelopeTemplate();
		DocuSignType.Notification notification = new DocuSignType.Notification();
		DocuSignType.Reminders reminders = new DocuSignType.Reminders();
		DocuSignType.Expirations exps = new DocuSignType.Expirations();
		DocuSignType.Templates temps = new DocuSignType.Templates();
		DocuSignType.Template temp = new DocuSignType.Template();
		DocuSignType.EnvelopeTemplateDefinition envTempDef = new DocuSignType.EnvelopeTemplateDefinition();
		DocuSignType.UserGroup usrGrp = new DocuSignType.UserGroup();
		DocuSignType.User usr = new DocuSignType.User();
		DocuSignType.Owner owner = new DocuSignType.Owner();
		DocuSignType.LastModifiedBy lmb = new DocuSignType.LastModifiedBy();

		Test.stopTest();
	}
}