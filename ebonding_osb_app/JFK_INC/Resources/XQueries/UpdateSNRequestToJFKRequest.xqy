xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ibm.com/maximo";
(:: import schema at "../Schemas/JFK_Outbound.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($Request as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() (:: schema-element(ns2:UpdateSITA_WORKORDER) ::) {
    <ns2:UpdateSITA_WORKORDER>
        <ns2:SITA_WORKORDERSet>
            <ns2:WORKORDER action="Change">
                <ns2:MAXINTERRORMSG></ns2:MAXINTERRORMSG>
                <ns2:ACTFINISH></ns2:ACTFINISH>
                <ns2:ACTSTART>{fn:concat($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA, "Z")}</ns2:ACTSTART>
                <ns2:ASSETNUM>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</ns2:ASSETNUM>
                <ns2:DESCRIPTION>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</ns2:DESCRIPTION>
                <ns2:DESCRIPTION_LONGDESCRIPTION>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</ns2:DESCRIPTION_LONGDESCRIPTION>
                <ns2:EXTERNALREFID>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</ns2:EXTERNALREFID>
                <ns2:SITEID>T4</ns2:SITEID>
                <ns2:STATUS>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)}</ns2:STATUS>
                <ns2:TARGSTARTDATE>{fn:concat(fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA), "Z")}</ns2:TARGSTARTDATE>
                <ns2:WONUM>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)}</ns2:WONUM>
                <ns2:WOPRIORITY>{fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)}</ns2:WOPRIORITY>
                <ns2:WORKLOG>
                    {
                        if (fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)='Resolved') then
                            <ns2:DESCRIPTION>Resolved</ns2:DESCRIPTION>
                        else
                            <ns2:DESCRIPTION>SITA update</ns2:DESCRIPTION>
                    }
                    {
                        if (fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)='Resolved') then
                            <ns2:DESCRIPTION_LONGDESCRIPTION>{
                            fn:concat("Actual tech arrival time:",fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA), "GMT",
                            "Estimated tech arrival time: ",fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA), "GMT")
                            }</ns2:DESCRIPTION_LONGDESCRIPTION>
                        else
                            <ns2:DESCRIPTION_LONGDESCRIPTION>{fn:concat("Current group",fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AssignmentGroup),fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments),"Actual tech arrival time:",fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA), "GMT",
                            "Estimated tech arrival time: ",fn:data($Request/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA), "GMT")}</ns2:DESCRIPTION_LONGDESCRIPTION>
                    }
                </ns2:WORKLOG>
                <ns2:WORKTYPE>CM</ns2:WORKTYPE>
            </ns2:WORKORDER>
        </ns2:SITA_WORKORDERSet>
    </ns2:UpdateSITA_WORKORDER>
};

local:func($Request)