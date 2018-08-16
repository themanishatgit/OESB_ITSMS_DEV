xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://sita.ba.integration.axiossystems.com/";
(:: import schema at "../WSDLs/AssystSITAWebServices.wsdl" ::)
declare namespace ns2="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $CanonicalFormatInput as element() (:: schema-element(ns2:IncidentRequestMessage) ::) external;
declare variable $ResolvedValues as element(*) external;
declare variable $DefaultValues as element(*) external;

declare function local:func($CanonicalFormatInput as element(),
                            $ResolvedValues as element(*),
                            $DefaultValues as element(*)) 
                            as element() {
    <ns1:TRANSACTION>
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then
        (<ns1:TRANSACTION_TYPE>Open</ns1:TRANSACTION_TYPE>)
        else()}
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='UPDATE')
        then
        (<ns1:TRANSACTION_TYPE>Update</ns1:TRANSACTION_TYPE>)
        else()}
        
        
        <ns1:REC_TYPE>{if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:RecType)='INC')
        then('Inc')
        else(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:RecType))}</ns1:REC_TYPE>
        <ns1:TRANSACTION_ID>{fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionId)}</ns1:TRANSACTION_ID>
        <ns1:INTERFACE>British Airways-SITA</ns1:INTERFACE>
        <ns1:SR_ID>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:TicketNumber)}</ns1:SR_ID>
        {if(fn:not(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE'))
        then
        (<ns1:EXTERNAL_ID>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Customer/ns2:RefNumber)}</ns1:EXTERNAL_ID>)
        else()}
        <ns1:STATUS>{fn:data($ResolvedValues/Status)}</ns1:STATUS>
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then
        (<ns1:SUMMARY>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ShortDescription)}</ns1:SUMMARY>)
        else()}
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then
        (<ns1:DESCRIPTION>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Description)}</ns1:DESCRIPTION>)
        else()}
        <ns1:GROUP>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AssignmentGroup)}</ns1:GROUP>
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then
        (<ns1:PRIORITY>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority)}</ns1:PRIORITY>)
        else()}
        <ns1:ACT_LOG>
          <ns1:DESCRIPTION>{fn:data($CanonicalFormatInput/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AdditionalComments)}</ns1:DESCRIPTION>
        </ns1:ACT_LOG>
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then(
        <ns1:USER_INFO>
          <ns1:FIRST_NAME></ns1:FIRST_NAME>
          <ns1:LAST_NAME>{$DefaultValues/UserLastName/text()}</ns1:LAST_NAME>
          <ns1:EMAIL_ADDRESS></ns1:EMAIL_ADDRESS>
          <ns1:PHONE_NUMBER>{$DefaultValues/UserPhoneNumber/text()}</ns1:PHONE_NUMBER>
        </ns1:USER_INFO>
        )
        else()}
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then(
        <ns1:PRIMARY_CI>{$DefaultValues/PrimaryCI/text()}</ns1:PRIMARY_CI>
        )
        else()}
        {if(fn:data($CanonicalFormatInput/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')
        then(
        <ns1:CI>
		<ns1:ASSET_TAG>{$DefaultValues/SecondaryCI/text()}</ns1:ASSET_TAG>
	</ns1:CI>
        )
        else()}
     </ns1:TRANSACTION>
};

local:func($CanonicalFormatInput, $ResolvedValues, $DefaultValues)