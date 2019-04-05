xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.service-now.com/u_integration_webservices_catalogtask";
(:: import schema at "../Schemas/IBM_Outbound.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;
declare variable $status as xs:string external;

declare function local:func($status as xs:string,$SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() (:: schema-element(ns2:insert) ::) {
    <ns2:insert>
       {
         
         
            if (fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)='Resolved') then
                if (true()) then
                    <ns2:u_comments>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)}</ns2:u_comments>
                else
                    <ns2:u_comments></ns2:u_comments>
            else
                <ns2:u_comments>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments)}</ns2:u_comments>
        }
        
        
        <ns2:u_servicenownumber>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)}</ns2:u_servicenownumber>
        <ns2:u_vendor>SITA</ns2:u_vendor>
        <ns2:u_vendornumber>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</ns2:u_vendornumber>
        <ns2:u_state>{$status}</ns2:u_state>
        {
            if (fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)='Resolved' or fn:string-length(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments))>0  ) then
                <ns2:u_vendorclosed>X</ns2:u_vendorclosed>
            else
                <ns2:u_vendorclosed></ns2:u_vendorclosed>
        }
        {
            if (fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA)) then
                <ns2:u_vendorworkstart>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA)}</ns2:u_vendorworkstart>
            else
                <ns2:u_vendorworkstart></ns2:u_vendorworkstart>
        }
        <ns2:u_category>application</ns2:u_category>
    </ns2:insert>
};

local:func($status,$SNRequest)