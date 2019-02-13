xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/Insert_ESB_Audit";
(:: import schema at "../DBAdapters/Insert_ESB_Audit_table.xsd" ::)

declare variable $Message_TranId as xs:string external;
declare variable $Payload as element(*) external;
declare variable $Source as xs:string external;
declare variable $Destination as xs:string external;
declare variable $ProxyService as xs:string external;
declare variable $RecType as xs:string external;
declare variable $TranType as xs:string external;
declare variable $TicketNumber as xs:string external;
declare variable $ExtRefNumber as xs:string external;
declare variable $Event as xs:string external;
declare variable $ErrCode as xs:string external;
declare variable $ErrMessage as xs:string external;

declare function local:func($Message_TranId as xs:string, 
                            $Payload as element(*), 
                            $Source as xs:string,
                            $Destination as xs:string,
                            $ProxyService as xs:string,
                            $RecType as xs:string,
                            $TranType as xs:string,
                            $TicketNumber as xs:string,
                            $ExtRefNumber as xs:string,
                            $Event as xs:string,
                            $ErrCode as xs:string,
                            $ErrMessage as xs:string) 
                            as element() (:: element(*, ns1:EsbAuditCollection) ::) {
    <ns1:EsbAuditCollection>
      <ns1:EsbAudit>
        <ns1:esbTranId>{fn-bea:execute-sql('jdbc/ESBDevDB',  
xs:QName('TRANID'),
'select to_char(ESB_AUDIT_TRAN_ID_SEQ.nextval) from dual')//text()}</ns1:esbTranId>
        <ns1:messageTranId>{
        if($Message_TranId)
        then($Message_TranId)
        else('DUMMY')
        }</ns1:messageTranId>
	<ns1:machineName>{fn-bea:getHostname()}</ns1:machineName>
	<ns1:payload>{$Payload}</ns1:payload>
	<ns1:source>{
        if($Source)
        then($Source)
        else('DUMMY')
        }</ns1:source>
	<ns1:destination>{
        if($Destination)
        then($Destination)
        else('DUMMY')
        }</ns1:destination>
	<ns1:proxyService>{$ProxyService}</ns1:proxyService>
	<ns1:recType>{
        if($RecType)
        then($RecType)
        else('DUMMY')
        }</ns1:recType>
	<ns1:tranType>{
        if($TranType)
        then($TranType)
        else('DUMMY')
        }</ns1:tranType>
	<ns1:ticketNum>{
        if($TicketNumber)
        then($TicketNumber)
        else('')
        }</ns1:ticketNum>
	<ns1:externalRefnum>{
        if($ExtRefNumber)
        then($ExtRefNumber)
        else('')
        }</ns1:externalRefnum>
	<ns1:event>{$Event}</ns1:event>
	<ns1:errCode>{$ErrCode}</ns1:errCode>
	<ns1:errMsg>{$ErrMessage}</ns1:errMsg>
	<ns1:creationTime>{fn:current-dateTime()}</ns1:creationTime>
      </ns1:EsbAudit>
    </ns1:EsbAuditCollection>
};

local:func($Message_TranId, $Payload, $Source, $Destination, $ProxyService, $RecType, $TranType, $TicketNumber, $ExtRefNumber, $Event, $ErrCode, $ErrMessage)