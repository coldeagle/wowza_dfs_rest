global abstract class DocuSignType {
    global class Account {
        global String accountId;

        global Account() {}
    }

    global class BulkEnvelope {
        global BulkEnvelope() {}
    }

    global virtual class CustomField {
        global ErrorDetails errorDetails;
        global String configurationType;
        global String fieldId;
        global String name;
        global String required;
        global String show;
        global String value;

        global CustomField() {}
    }

    global virtual class CustomFields {
        global List<ListCustomFields> listCustomFields;
        global List<TextCustomFields> textCustomFields;
        global CustomFields() {
            this.textCustomFields = new List<TextCustomFields>();
            this.listCustomFields = new List<ListCustomFields>();
        }
    }

    global class ListCustomFields extends CustomField {
        global List<String> listItems;

        global ListCustomFields() {}
    }

    global class TextCustomFields extends CustomField {
        global ErrorDetails errorDetails;
        global String configurationType;
        global String fieldId;
        global String name;
        global String required;
        global String show;
        global String value;

        global TextCustomFields() {}

        global TextCustomFields(Id sfdcId) {
            this.name = String.ValueOf(sfdcId.getSobjectType());
            this.value = String.valueOf(sfdcId);
            this.required = 'false';
            this.show = 'true';
            this.configurationType = 'salesforce';
        }
    }

    global virtual class Envelope {
        global Documents documents;
        global String allowMarkup;
        global String allowReassign;
        global String attachmentsUri;
        global String autoNavigation;
        global String certificateUri;
        global String createdDateTime;
        global String customFieldsUri;
        global String documentsCombinedUri;
        global String documentsUri;
        global String emailSubject;
        global String enableWetSign;
        global String envelopeId;
        global String envelopeIdStamping;
        global String envelopeUri;
        global String initialSentDateTime;
        global String is21CFRPart11;
        global String isSignatureProviderEnvelope;
        global String lastModifiedDateTime;
        global String notificationUri;
        global String purgeState;
        global String recipientsLock;
        global String recipientsUri;
        global String sentDateTime;
        global String signerCanSignOnMobile;
        global String status;
        global String statusChangedDateTime;
        global String templatesUri;
        global String uri;

        global Envelope () {}
    }

    global class EnvelopeDefinition extends Envelope {
        global CustomFields customFields;
        global List<TemplateRole> templateRoles;
        global String brandLock;
        global String completedDateTime;
        global String templateId;

        global EnvelopeDefinition() {}
        
    }

    global class EnvelopeTabs {
        global List<ApproveTab> approveTabs;
        global List<CheckboxTab> checkboxTabs;
        global List<CompanyTab> companyTabs;
        global List<DateSignedTab> dateSignedTabs;
        global List<DateTab> dateTabs;
        global List<DeclineTab> declineTabs;
        global List<EmailAddressTab> emailAddressTabs;
        global List<EnvelopeIdTab> envelopeIdTabs;
        global List<FirstNameTab> firstNameTabs;
        global List<FormulaTab> formulaTabs;
        global List<FullNameTab> fullNameTabs;
        global List<InitialHereTab> initialHereTabs;
        global List<LastNameTab> lastNameTabs;
        global List<ListTab> listTabs;
        global List<NoteTab> noteTabs;
        global List<NumberTab> numberTabs;
        global List<RadioGroup> radioGroupTabs;
        global List<SignerAttachmentTab> signerAttachmentTabs;
        global List<SignHereTab> signHereTabs;
        global List<SsnTab> ssnTabs;
        global List<TextTab> textTabs;
        global List<TitleTab> titleTabs;
        global List<ZipTab> zipTabs;

        global EnvelopeTabs(){}
    }

    global class ErrorDetails {
        global String errorCode;
        global String message;

        global ErrorDetails() {}
    }

    global class Documents {
        global List<Document> documents;

        global Documents() {}
    }

    global virtual class Document {
        global Integer order;
        global Integer pages;
        global List<CustomField> documentFields;
        global List<MatchBox> matchBoxes;
        global String applyAnchorTabs;
        global String display;
        global String documentGroup;
        global String documentId;
        global String encryptedWithKeyManager;
        global String fileExtension;
        global String includeInDownload;
        global String name;
        global String password;
        global String remoteUrl;
        global String signerMustAcknowledge;
        global String templateLocked;
        global String templateRequired;
        global String transformPdfFields;
        global String uri;

        global Document() {}
    }
    
    global class EmailNotification {
        global String emailBody;
        global String emailSubject;
        global String supportedLanguage;

        global EmailNotification() {}
    }

    global virtual class Recipient {
        global EmailNotification emailNotification;
        global Integer routingOrder;
        global List<String> customFields;
        global List<String> excludedDocuments;
        global String accessCode;
        global String addAccessCodeToEmail;
        global String canEditRecipientEmails;
        global String canEditRecipientNames;
        global String clientUserId;
        global String deliveryMethod;
        global String email;
        global String embeddedRecipientStartURL;
        global String idCheckConfigurationName;
        global String inheritEmailNotificationConfiguration;
        global String name;
        global String note;
        global String recipientId;
        global String requireIdLookup;
        global String roleName;
        global String signingGroupId;
        global String templateAccessCodeRequired;
        global String templateLocked;
        global String templateRequired;

        global Recipient(){}

        //To be implemented
        //global IdCheckInformationInput idCheckInformationInput
        //global RecipientPhoneAuthentication phoneAuthentication
        //global senderProvidedNumbers smsAuthentication
        //global String socialAuthentications
    }

    global virtual class Recipients {
        global Integer recipientCount;
        global List<Agent> agents;
        global List<CarbonCopy> carbonCopies;
        global List<CertifiedDelivery> certifiedDeliveries; 
        global List<Editor> editors;
        global List<InPersonSigner> inPersonSigners;
        global List<Intermediary> intermediaries;
        global List<Signer> signers;
        
        global Recipients() {}
    }
    global class Agent extends Recipient {
        global Agent() {}
    }

    global class Agents {
        global List<Agent> agents;
        global Agents() {}
    }

    global class CarbonCopies {
        global List<CarbonCopy> carbonCopies;

        global CarbonCopies () {}
    }

    global class CarbonCopy extends Recipient {
        global CarbonCopy() {}
    }

    global class CertifiedDelivery extends Recipient {
        global CertifiedDelivery() {}
    }

    global class Editor extends Recipient {
        global Editor() {}
    }

    global class Editors {
        global List<Editor> editors;

        global Editors() {}
    }

    global class EnvelopeRecipients extends Recipient {
        global CarbonCopies carbonCopies;
        global ErrorDetails errorDetails;
        global Integer currentRoutingOrder;
        global Integer recipientCount;

        global EnvelopeRecipients(){}
    }

    global class InPersonSigner extends Recipient {
        global String autoNavigation;
        global String defaultRecipient;
        global String hostEmail;
        global String hostName;
        global String requireSignerCertificate;
        global String requireSignOnPaper;
        global String rountingOrder;
        global String signerEmail;
        global String signerName;
        global String signInEachLocation;

        global InPersonSigner() {}
    }

    global class InPersonSigners {
        global InPersonSigners () {}
    }

    global class Intermediary extends Recipient {
        global String rountingOrder;

        global Intermediary() {}
    }

    global class Intermediaries {
        global List<Intermediary> intermediaries;

        global Intermediaries() {}
    }

    global class Signers {
        global Signers() {}
    }

    global class Signer extends Recipient {
        global DateTime deliveredDateTime;
        global EnvelopeTabs tabs;
        global String autoNavigation;
        global String bulkRecipientsUri;
        global String defaultRecipient;
        global String isBulkRecipient;
        global String requireSignerCertificate;
        global String requireSignOnPaper;
        global String signInEachLocation;
        global Signer()  {}
        //To be implemented 
        //global Object recipientSignatureProviders
    }

    global class RecipientEmailNotification {
        global String emailBody;
        global String emailSubject;
        global String supportedLanguage;

        global RecipientEmailNotification() {}
    }

    global class TemplateRoles {
        global List<TemplateRole> templateRoles;

        global TemplateRoles(){
            this.templateRoles = new List<TemplateRole>();
        }

        global TemplateRoles(List<TemplateRole> roles) {
            this.templateRoles = roles;
        }
    }

    global class TemplateRole {
        global EnvelopeTabs envelopeTabs;
        global Integer routingOrder;
        global RecipientEmailNotification recipientEmailNotification;
        global String accessCode;
        global String clientUserId;
        global String defaultRecipient;
        global String email;
        global String embeddedRecipientStartURL;
        global String inPersonSignerName;
        global String name;
        global String roleName;
        global String signingGroupId;

        global TemplateRole(){}

        global TemplateRole(String roleName, SObject usr){
            this.roleName = roleName;
            this.name = (String)usr.get('FirstName') + ' ' + (String) usr.get('LastName');
            this.email = (String) usr.get('Email');
            this.defaultRecipient = 'false';
        }

        global TemplateRole(String roleName, SObject usr, Boolean defaultRecipient) {
            this.RoleName = roleName;
            this.name = (String)usr.get('FirstName') + ' ' + (String) usr.get('LastName');
            this.email = (String) usr.get('Email');
            this.defaultRecipient = String.valueOf(defaultRecipient);
        }

    }

    global class MatchBox {
        global Integer height;
        global Integer pageNumber;
        global Integer width;
        global Integer xPosition;
        global Integer yPosition;

        global MatchBox() {}
    }

    global virtual class Tab {
        global ErrorDetails errorDetails;
        global Integer anchorXOffset;
        global Integer anchorYOffset;
        global Integer pageNumber;
        global Integer xPosition;
        global Integer yPosition;
        global MergeField mergeField;
        global String anchorCaseSensitive;
        global String anchorHorizontalAlignment;
        global String anchorIgnoreIfNotPresent;
        global String anchorMatchWholeWord;
        global String anchorString;
        global String anchorUnits;
        global String conditionalParentLabel;
        global String conditionalParentValue;
        global String customTabId;
        global String documentId;
        global String name;
        global String optional;
        global String recipientId;
        global String status;
        global String tabId;
        global String tabLabel;
        global String templateLocked;
        global String templateRequired;

        global Tab () {}

    }

    global virtual class FormattedTab extends Tab {
        global Integer maxLength;
        global Integer width;
        global String bold;
        global String concealValueOnDocument;
        global String disableAutoSize;
        global String font;
        global String fontColor;
        global String fontSize;
        global String italic;
        global String locked;
        global String originalValue;
        global String required;
        global String underline;

        global FormattedTab() {}
    }

    global virtual class FormattedValidationTab extends FormattedTab {
        global String requireAll;
        global String requireInitialOnSharedChange;
        global String senderRequired;
        global String shared;
        global String validationMessage;
        global String validationPattern;

        global FormattedValidationTab() {}
    }

    global class InitialHereTab extends Tab {
        global InitialHereTab() {}
    }


    global class SignerAttachmentTab extends Tab {
        global SignerAttachmentTab() {}
    }

    global class SignHereTab extends Tab {
        global String concealValueOnDocument;

        global SignHereTab() {}
    }

    global class CheckboxTab extends Tab {
        global String selected;

        global CheckboxTab() {}
    }

    global class CompanyTab extends FormattedTab {
        global String concealValueOnDocument;

        global CompanyTab() {}
    }

    global class FullNameTab extends FormattedTab {
        global FullNameTab(){}
    }

    global class TitleTab extends FormattedTab {
        global String concealValueOnDocument;

        global TitleTab() {}
        
    }

    global class ApproveTab extends FormattedTab {
        global Integer height;

        global ApproveTab() {}
    }

    global class EnvelopeIdTab extends FormattedTab {
        global EnvelopeIdTab() {}
    }

    global class FirstNameTab extends FormattedTab {
        global FirstNameTab() {}
    }

    global class LastNameTab extends FormattedTab {
        global LastNameTab() {}
    }

    global class DateSignedTab extends FormattedTab {
        global DateSignedTab() {}
    }

    global class ListTab extends FormattedTab {
        global List<ListItem> listItems;

        global ListTab() {}
    }


    global class EmailAddressTab extends FormattedTab {
        global EmailAddressTab() {}
    }

    global class DeclineTab extends FormattedTab {
        global String declineReason;

        global DeclineTab() {}
    }

    global class ZipTab extends FormattedTab {
        global String useDash4;

        global ZipTab() {}
    }

    global class ListItem {
        global String selected;
        global String text;
        global String value;

        global ListItem() {}
    }

    global class EmailTab extends FormattedValidationTab {
        global String concealValueOnDocument;

        global EmailTab() {}
    }

    global class FormulaTab extends FormattedValidationTab {
        global String concealValueOnDocument;
        global String formula;
        global String isPaymentAmount;

        global FormulaTab() {}
    }

    global class TextTab extends FormattedValidationTab {
        global Integer height;
        global String concealValueOnDocument;
        global String isPaymentAmount;

        global TextTab(){}
    }

    global class NoteTab extends FormattedValidationTab {
        global Integer height;

        global NoteTab(){}
    }

    global class NumberTab extends FormattedValidationTab {
        global Integer height;

        global NumberTab(){}
    }

    global class DateTab extends FormattedValidationTab {
        global DateTab(){}
    }

    global class SsnTab extends FormattedValidationTab {
        global SsnTab(){}
    }

    global virtual class RadioGroup {
        global List<Radio> radios;
        global String conditionalParentLabel;
        global String conditionalParentValue;
        global String documentId;
        global String groupName;
        global String recipientId;
        global String requireAll;
        global String requireInitialOnSharedChange;
        global String shared;

        global RadioGroup(){}

    }

    global virtual class Radio {
        global ErrorDetails errorDetails;
        global String anchorCaseSensitive;
        global String anchorHorizontalAlignment;
        global String anchorMatchWholeWord;
        global String anchorString;
        global String anchorUnits;
        global Integer anchorXOffset;
        global Integer anchorYOffset;
        global String locked;
        global Integer pageNumber;
        global String required;
        global String selected;
        global String tabId;
        global String value;
        global Integer xPosition;
        global Integer yPosition;

        global Radio() {}
    }

    global class MergeField {
        global Integer row;
        global String allowSenderToEdit;
        global String configurationType;
        global String path;
        global String writeBack;

        global MergeField () {}
    }

    global class CompositeTemplates {
        global List<CompositeTemplate> compositeTemplates;

        global CompositeTemplates() {}
    }

    global class CompositeTemplate {
        global Document document;
        global String compositeTemplateId;

        global CompositeTemplate() {}
    }

    global class InlineTemplates {
        global List<InlineTemplate> inlineTemplates;

        global InlineTemplates() {}
    }

    global class InlineTemplate {
        global InlineTemplate inlineTemplate;

        global InlineTemplate() {}
    }


    global class SigningGroup {
        global SigningGroup() {}
    }

    global class Notification {
        global Expirations expirations;
        global Reminders reminders;

        global Notification() {}
    }

    global class Reminders {
        global Integer reminderDelay;
        global Integer reminderFrequency;
        global String reminderEnabled;

        global Reminders() {}
    }

    global class Expirations {
        global Integer expireAfter;
        global Integer expireWarn;
        global String expireEnabled;

        global Expirations() {}
    }

    global virtual class Templates {
        global Template[] templates;

        global Templates() {}
    }

    global class EnvelopeTemplateDefinition {
        global Template envelopeTemplateDefinition;

        global EnvelopeTemplateDefinition () {}
    }

    global virtual class Template {
        global CustomFields customFields;
        global DateTime lastModified;
        global DocuSignType.LastModifiedBy lastModifiedBy;
        global DocuSignType.Owner owner;
        global Integer pageCount;
        global List<Document> documents;
        global Notification notification;
        global Recipients recipients;
        global String allowMarkup;
        global String allowReassign;
        global String authoritativeCopy;
        global String autoNavigation;
        global String description;
        global String emailBlurb;
        global String emailSubject;
        global String enableWetSign;
        global String enforceSignerVisibility;
        global String envelopeIdStamping;
        global String folderId;
        global String folderName;
        global String folderUri;
        global String name;        
        global String password;
        global String shared;
        global String signingLocation;
        global String templateId;
        global String uri;

        global Template() {}
        //To be implemented
        //global EmailSettings emailSettings;
        //global LockInformation lockInformation;
        
    }

    global class EnvelopeTemplates {
        global List<Template> envelopeTemplates;

        global EnvelopeTemplates() {}

    }

    global class EnvelopeTemplate extends Template {
        global EnvelopeTemplate() {}
    }


    global class UserGroup {
        global UserGroup() {}
    }

    global virtual class User {
        global String email;
        global String uri;
        global String userId;
        global String userName;

        global User() {}
    }


    global class Owner extends User {
        global Owner() {}
    }

    global class LastModifiedBy extends User {
        global LastModifiedBy() {}
    }

    /*
    //To be implemented
    global class Authentication {}

    global class Billing {}

    global class CloudStorage {}
    
    global class Connect {}

    global class CustomTab {}

    global class Diagnostic {}

    global class DocumentFields {
        global List<CustomField> documentFields;
        global DocumentFields() {}
    }

    global class EmailSettings {}

    global class LockInformation {}

    global class Folder {}
    
    global class IdCheckInformationInput {}
    global class RecipientPhoneAuthentication {}
    global class senderProvidedNumbers {}
    */
}