xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as text() {
    text {"Reply-to: escalations.spl@sita.aero
The following request has been opened:
Incident #:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber/text(),"- Initial
External #:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Supplier/ns1:RefNumber/text(),"- Initial
Email address: Servicedesk@sita.aero

Priority:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text(),"
Open Time:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate/text(),"


Service:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService/text(),"
CI/Asset Tag:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI/text(),"
Node ID:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:SecondaryCINodeName/text(),"
Organization:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Company/text(),"
End User Name:",fn:concat($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName,' ',$SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:MiddleName,' ',$SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName),"

End User Email:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:EmailAddress/text(),"

Summary:",$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription/text(),"
Description:",
            if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')then
           $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description/text()
            else
            $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments/text()
            ,"
Adresslines:

Location:",fn:concat(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location),' ',fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)),"


Don't Share Update?:on
    "}
};

local:func($SNRequest)