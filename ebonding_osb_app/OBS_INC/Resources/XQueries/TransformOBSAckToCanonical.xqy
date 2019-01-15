xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://eai/Sav/Trillium/Types";
(:: import schema at "../WSDL/PH_B2B_EPH_TRILLIUM_TroubleTicket_source_services.wsdl" ::)
declare namespace ns2="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $AckTransaction as element() (:: schema-element(ns1:TRANSACTION) ::) external;

declare function local:func($AckTransaction as element() (:: schema-element(ns1:TRANSACTION) ::)) as element() (:: schema-element(ns2:IncidentRequestMessage) ::) {
    <ns2:IncidentRequestMessage>
        <ns2:IncidentRequestHeader>
            <ns2:TransactionId>{fn-bea:uuid()}</ns2:TransactionId>
            <ns2:TransactionType>UPDATE</ns2:TransactionType>
            <ns2:SourceSystem>SN</ns2:SourceSystem>
            <ns2:DestinationSystem>OBS</ns2:DestinationSystem>
        </ns2:IncidentRequestHeader>
        <ns2:IncidentRequestBody>
            <ns2:IncidentDetails>
                {
                    if ($AckTransaction/SR_ID)
                    then <ns2:TicketNumber>{fn:data($AckTransaction/SR_ID)}</ns2:TicketNumber>
                    else ()
                }
                <ns2:Status>Acknowledged</ns2:Status>
                <ns2:Customer>
                    <ns2:Name>OBS</ns2:Name>
                    {
                        if ($AckTransaction/EXTERNAL_ID)
                        then <ns2:RefNumber>{fn:data($AckTransaction/EXTERNAL_ID)}</ns2:RefNumber>
                        else ()
                    }
                </ns2:Customer>
                <ns2:Supplier>
                    <ns2:Name>OBS</ns2:Name>
                    {
                        if ($AckTransaction/EXTERNAL_ID)
                        then <ns2:RefNumber>{fn:data($AckTransaction/EXTERNAL_ID)}</ns2:RefNumber>
                        else ()
                    }
                </ns2:Supplier>
            </ns2:IncidentDetails>
        </ns2:IncidentRequestBody>
    </ns2:IncidentRequestMessage>
};

local:func($AckTransaction)