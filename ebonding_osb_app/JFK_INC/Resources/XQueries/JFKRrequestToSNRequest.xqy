xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../WSDLs/JFKInbound.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $Request as element() (:: schema-element(CALL) ::) external;
declare variable $TransactionType as xs:string  external;
declare variable $MsgTranId as xs:string  external;
declare variable $status as xs:string external;
declare function local:func($MsgTranId as xs:string,$TransactionType as xs:string,$status as xs:string,$Request as element() (:: schema-element(CALL) ::)) as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
        <ns1:IncidentRequestHeader>
            <ns1:TransactionId>{$MsgTranId}</ns1:TransactionId>
            <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
            <ns1:RecType>INC</ns1:RecType>
            <ns1:SourceSystem>JFK</ns1:SourceSystem>
            <ns1:DestinationSystem>SN</ns1:DestinationSystem>
            
        </ns1:IncidentRequestHeader>
        <ns1:IncidentRequestBody>
            <ns1:IncidentDetails>
                <ns1:TicketNumber>{fn:data($Request/Calls.SPCallID)}</ns1:TicketNumber>
                <ns1:Status>{$status}</ns1:Status>
                <ns1:AssignmentGroup>{fn:data($Request/Calls.CHDLastName)}</ns1:AssignmentGroup>
                <ns1:SDOwnerGroup></ns1:SDOwnerGroup>
                <ns1:Description>{fn:data($Request/Calls.Description)}</ns1:Description>
                <ns1:ShortDescription>{fn:data($Request/Calls.ShortDescription)}</ns1:ShortDescription>
                <ns1:Priority></ns1:Priority>
                <ns1:Category>{fn:data($Request/Calls.CallerTel)}</ns1:Category>
                <ns1:Customer>
                    <ns1:Name>JFK</ns1:Name>
                    <ns1:RefNumber>{fn:data($Request/Calls.CustCallID)}</ns1:RefNumber>
                </ns1:Customer>
                <ns1:AdditionalComments></ns1:AdditionalComments>
                <ns1:SupplierComments></ns1:SupplierComments>
                <ns1:WorkNotes></ns1:WorkNotes>
                <ns1:TimeSpent>{fn:data($Request/Calls.CallAcknowledgeTime)}</ns1:TimeSpent>
                <ns1:ReportMethod>{fn:data($Request/Calls.Diagnosis)}</ns1:ReportMethod>
            </ns1:IncidentDetails>
            <ns1:IncidentContact>
                <ns1:EmailAddress>{fn:data($Request/Calls.CallerEMail)}</ns1:EmailAddress>
                </ns1:IncidentContact>
            <ns1:IncidentAsset>
                <ns1:BusinessService>{fn:data($Request/Calls.MainCompName)}</ns1:BusinessService>
               </ns1:IncidentAsset>
            
        </ns1:IncidentRequestBody>
    </ns1:IncidentRequestMessage>
};

local:func($MsgTranId,$TransactionType,$status,$Request)