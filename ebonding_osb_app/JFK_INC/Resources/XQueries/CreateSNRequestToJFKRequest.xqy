xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ibm.com/maximo";
(:: import schema at "../Schemas/JFK_Outbound.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() (:: schema-element(ns2:CreateSITA_WORKORDER) ::) {
    <ns2:CreateSITA_WORKORDER>
        <ns2:SITA_WORKORDERSet>
            <ns2:WORKORDER action="AddChange">
                {
                    if (fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)) then
                        <ns2:ASSETNUM>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</ns2:ASSETNUM>
                    else
                        <ns2:ASSETNUM>JFK4 UNKNOWN CI</ns2:ASSETNUM>
                }
                <ns2:DESCRIPTION>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</ns2:DESCRIPTION>
                <ns2:DESCRIPTION_LONGDESCRIPTION>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</ns2:DESCRIPTION_LONGDESCRIPTION>
                <ns2:EXTERNALREFID>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</ns2:EXTERNALREFID>
                <ns2:OWNERGROUP>TSSC</ns2:OWNERGROUP>
                <ns2:STATUS>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)}</ns2:STATUS>
                <ns2:SITEID>T4</ns2:SITEID>
                <ns2:WOPRIORITY>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)}</ns2:WOPRIORITY>
                <ns2:WORKTYPE>CM</ns2:WORKTYPE>
            </ns2:WORKORDER>
        </ns2:SITA_WORKORDERSet>
    </ns2:CreateSITA_WORKORDER>
};

local:func($Request)