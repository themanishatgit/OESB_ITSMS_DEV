xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.sita.aero/schema/AuditPSMessageV1";
(:: import schema at "../Schemas/AuditPSMessage.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/top/Insert_ESB_Audit";
(:: import schema at "../DBAdapters/Insert_ESB_Audit_table.xsd" ::)

declare variable $AuditPSRequestMessage as element() (:: schema-element(ns1:AuditPSRequestMessage) ::) external;
declare variable $ESBTranId as xs:string external;

declare function local:func($AuditPSRequestMessage as element() (:: schema-element(ns1:AuditPSRequestMessage) ::), 
                            $ESBTranId as xs:string) 
                            as element() (:: element(*, ns2:EsbAudit) ::) {
    <ns2:EsbAudit>
        <ns2:esbTranId>{$ESBTranId}</ns2:esbTranId>
        <ns2:messageTranId>{
        if(data($AuditPSRequestMessage/ns1:Message_TranId))
        then(data($AuditPSRequestMessage/ns1:Message_TranId))
        else('DUMMY')
        }</ns2:messageTranId>
        <ns2:machineName>HOST</ns2:machineName>
        <ns2:payload>{$AuditPSRequestMessage/ns1:Payload/*}</ns2:payload>
        <ns2:source>{
        if(data($AuditPSRequestMessage/ns1:Source))
        then(data($AuditPSRequestMessage/ns1:Source))
        else('DUMMY')
        }</ns2:source>
        <ns2:destination>{
        if(data($AuditPSRequestMessage/ns1:Destination))
        then(data($AuditPSRequestMessage/ns1:Destination))
        else('DUMMY')
        }</ns2:destination>
        <ns2:proxyService>{fn:data($AuditPSRequestMessage/ns1:ProxyService)}</ns2:proxyService>
        <ns2:recType>{
        if(data($AuditPSRequestMessage/ns1:RecType))
        then(data($AuditPSRequestMessage/ns1:RecType))
        else('DUMMY')
        }</ns2:recType>
        <ns2:tranType>{
        if(data($AuditPSRequestMessage/ns1:TranType))
        then(data($AuditPSRequestMessage/ns1:TranType))
        else('DUMMY')
        }</ns2:tranType>
        <ns2:ticketNum>{
        if(data($AuditPSRequestMessage/ns1:Message_TranId))
        then(data($AuditPSRequestMessage/ns1:Message_TranId))
        else if($AuditPSRequestMessage/ns1:Message_TranId)
        then('DUMMY')
        else('')
        }</ns2:ticketNum>
        <ns2:externalRefnum>{
        if(data($AuditPSRequestMessage/ns1:ExtRefNumber))
        then(data($AuditPSRequestMessage/ns1:ExtRefNumber))
        else if($AuditPSRequestMessage/ns1:ExtRefNumber)
        then('DUMMY')
        else('')
        }</ns2:externalRefnum>
        <ns2:event>{fn:data($AuditPSRequestMessage/ns1:Event)}</ns2:event>
        <ns2:errCode>{fn:data($AuditPSRequestMessage/ns1:ErrCode)}</ns2:errCode>
        <ns2:errMsg>{fn:data($AuditPSRequestMessage/ns1:ErrMessage)}</ns2:errMsg>
        <ns2:creationTime>{fn:current-dateTime()}</ns2:creationTime>
    </ns2:EsbAudit>
};

local:func($AuditPSRequestMessage, $ESBTranId)