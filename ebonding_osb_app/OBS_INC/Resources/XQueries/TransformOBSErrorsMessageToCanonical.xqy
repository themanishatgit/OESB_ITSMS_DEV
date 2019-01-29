xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://localhost/PH_B2B_EPH_TRILLIUM/TroubleTicket/source/services/handleTT";
(:: import schema at "../WSDL/PH_B2B_EPH_TRILLIUM_TroubleTicket_source_services.wsdl" ::)
declare namespace ns2="http://www.sita.aero/schema/IncidentEbondingMessageV1";

(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)
declare namespace n1="http://eai/Sav/Trillium/Types";
declare variable $Request as element() (:: element(*, ns1:TransactionTrillium) ::) external;
declare variable $Req as element(*) external;
declare function local:func($Req as element(*),$Request as element() (:: element(*, ns1:TransactionTrillium) ::)) as element() (:: schema-element(ns2:IncidentRequestMessage) ::) {
   <ns2:IncidentRequestMessage>
        <ns2:IncidentRequestHeader>
            <ns2:TransactionId>{fn-bea:uuid()}</ns2:TransactionId>
            <ns2:TransactionType>UPDATE</ns2:TransactionType>
            <ns2:RecType>INC</ns2:RecType>
            <ns2:SourceSystem>OBS</ns2:SourceSystem>
            <ns2:DestinationSystem>SN</ns2:DestinationSystem>
        </ns2:IncidentRequestHeader>
        <ns2:IncidentRequestBody>
           <ns2:IncidentDetails>
               
                    <ns2:TicketNumber>{$Request/SR_ID}</ns2:TicketNumber>

           
                        <ns2:Status>UPDATE</ns2:Status>
               
                <ns2:Customer>
                    <ns2:Name>OBS</ns2:Name>
                    {
                        if ($Request/EXTERNAL_ID)
                        then <ns2:RefNumber>{fn:data($Request/EXTERNAL_ID)}</ns2:RefNumber>
                        else ()
                    }
                </ns2:Customer>
                <ns2:Supplier>
                    <ns2:Name>OBS</ns2:Name>
                    {
                        if ($Request/EXTERNAL_ID)
                        then <ns2:RefNumber>{fn:data($Request/EXTERNAL_ID)}</ns2:RefNumber>
                        else ()
                    }
                </ns2:Supplier>
                <ns2:WorkNotes>{$Req/ERROR_DESCRIPTION}</ns2:WorkNotes>
              
            </ns2:IncidentDetails>
        </ns2:IncidentRequestBody>
       
    </ns2:IncidentRequestMessage>
};

local:func($Req, $Request)
