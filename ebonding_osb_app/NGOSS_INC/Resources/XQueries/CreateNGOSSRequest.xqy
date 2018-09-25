xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../Schemas/NGOSSOutboundMessage.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $IncidentRequestMessage as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($IncidentRequestMessage as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() (:: schema-element(IncidentXML) ::) {
    <IncidentXML>
        <IncidentID>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</IncidentID>
        <EventID>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)}</EventID>
        <Type>{fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionType)}</Type>
        <IncidentStatus>{
        if(fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionType)='ACK')
        then('Open')
        else(fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status))
        }</IncidentStatus>
        <Description>{
        if(fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionType)='ACK')
        then('ACK')
        else(fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:WorkNotes))
        }</Description>
    </IncidentXML>
};

local:func($IncidentRequestMessage)