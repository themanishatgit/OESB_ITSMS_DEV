xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://eai/Sav/Trillium/Types";
(:: import schema at "../WSDL/PH_B2B_EPH_TRILLIUM_TroubleTicket_source_services.wsdl" ::)
declare namespace ns2="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:TRANSACTION) ::) external;
declare variable $Req as xs:string external;
declare function local:func($Req as xs:string,$Request as element() (:: schema-element(ns1:TRANSACTION) ::)) as element() (:: schema-element(ns2:IncidentRequestMessage) ::) {
    <ns2:IncidentRequestMessage>
<ns2:IncidentRequestHeader>
    <ns2:TransactionId>{fn:data($Request/TRANSACTION_ID)}</ns2:TransactionId>
            <ns2:TransactionType>ERROR</ns2:TransactionType>
            <ns2:RecType>INC</ns2:RecType>
            <ns2:SourceSystem>OBS</ns2:SourceSystem>
            <ns2:DestinationSystem>SN</ns2:DestinationSystem>
        </ns2:IncidentRequestHeader>
        <ns2:IncidentRequestBody>
            <ns2:IncidentDetails>
                {
                    if ($Request/SR_ID)
                    then <ns2:TicketNumber>{fn:data($Request/SR_ID)}</ns2:TicketNumber>
                    else ()
                }
                <ns2:Customer>
                    <ns2:Name>OBS</ns2:Name>
                    {
                        if ($Request/EXTERNAL_ID)
                        then <ns2:RefNumber>{fn:data($Request/EXTERNAL_ID)}</ns2:RefNumber>
                        else ()
                    }
                </ns2:Customer>
                <ns2:AdditionalComments>{$Req}</ns2:AdditionalComments>
              
            </ns2:IncidentDetails>
        </ns2:IncidentRequestBody>
    </ns2:IncidentRequestMessage>
};

local:func($Req,$Request)
