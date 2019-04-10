xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)
declare namespace ns2="urn:microsoft-dynamics-schemas/codeunit/EBoundingWebservices";
(:: import schema at "../WSDL/IEROutbound.wsdl" ::)

declare variable $Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;
declare variable $Priorities as element(*) external;
declare variable $ReopenFlag as xs:string external;
declare variable $ResolvedValues as element(*) external;
declare function local:func( $Priorities as element(*),$ReopenFlag as xs:string ,$ResolvedValues as element(*),
$Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() 
(:: schema-element(ns2:UpdateServiceRequest) ::) {

    if($ReopenFlag="Y")then
    (
    let $InitialCreateRequest := fn-bea:inlinedXML(fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('PAYLOAD'),'SELECT PAYLOAD FROM EBONDINGS_TRANSACTIONS where TICKET_NUM=? and IS_FIRST_REFNUM=?',fn:string($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber/text()),'Y')//text())
    return
        <ns2:CreateServiceRequest>
        <ns2:language>US</ns2:language>
        <ns2:user>WS_SITA</ns2:user>
        <ns2:password></ns2:password>
        <ns2:supervisionAgent></ns2:supervisionAgent>
        <ns2:customerCode></ns2:customerCode>
        <ns2:sRNumber></ns2:sRNumber>
        <ns2:serialNumber></ns2:serialNumber>
        <ns2:externalReference></ns2:externalReference>
        <ns2:systemNumber></ns2:systemNumber>
        <ns2:sRType>{fn:substring(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Category),0,50)}
        </ns2:sRType>
        <ns2:externalReference>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</ns2:externalReference>
        <ns2:systemNumber></ns2:systemNumber>
      
       <ns2:status>{fn:data($ResolvedValues/Status)}</ns2:status>
        <ns2:siteCode>{fn:substring(fn:concat(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location),
             fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)),0,50)}</ns2:siteCode>
        <ns2:contractCode></ns2:contractCode>
        <ns2:urgency></ns2:urgency>
        {
         if (fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)) then
         <ns2:gravity>{fn:data($Priorities/Outbound/Priority[SN/text()=fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)]/IER/text())}</ns2:gravity>
         else
        <ns2:gravity>{fn:data($Priorities/Outbound/Priority[SN/text()='Default']/IER/text())}</ns2:gravity>
         }
        <ns2:summary>{fn:substring(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription),0,255)}</ns2:summary>
        <ns2:incidentDate>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate)}</ns2:incidentDate>
        <ns2:reportedDate>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate)}</ns2:reportedDate>
        <ns2:problemDescription></ns2:problemDescription>
        <ns2:errorCode></ns2:errorCode>
        <ns2:respondBy></ns2:respondBy>
        <ns2:resolveBy></ns2:resolveBy>
        <ns2:customerTicketNumber>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</ns2:customerTicketNumber>
        <ns2:pONumber></ns2:pONumber>
        <ns2:address1></ns2:address1>
        <ns2:address2></ns2:address2>
        <ns2:address3></ns2:address3>
        <ns2:address4></ns2:address4>
        <ns2:postalCode></ns2:postalCode>
        <ns2:city></ns2:city>
        <ns2:department></ns2:department>
        <ns2:country></ns2:country>
        <ns2:contactName></ns2:contactName>
        <ns2:contactFirstName></ns2:contactFirstName>
        <ns2:taskDetails>{fn:concat(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService),'/',fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI),'/Error Message:',fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description))}</ns2:taskDetails>
        <ns2:note></ns2:note>
        <ns2:customField01>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AssignmentGroup)}</ns2:customField01>
  </ns2:CreateServiceRequest>)
   
   else
   (
    <ns2:UpdateServiceRequest>
        <ns2:externalReference>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</ns2:externalReference>
      
        <ns2:siteCode>{fn:concat(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location), $Request/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)}</ns2:siteCode>
        <ns2:gravity>{fn:data($Priorities/Outbound/Priority[SN/text()=fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)]/IER/text())}</ns2:gravity>
        <ns2:summary>{fn:substring(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription),0,255)}</ns2:summary>       
        <ns2:taskDetails>{fn:concat($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService, $Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI, fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description))}</ns2:taskDetails>
        <ns2:customerTicketNumber>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</ns2:customerTicketNumber>
        <ns2:note>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)}</ns2:note>
         <ns2:status>{fn:data($ResolvedValues/Status)}</ns2:status>
    </ns2:UpdateServiceRequest>)
};

local:func($Priorities,$ReopenFlag,$ResolvedValues, $Request)