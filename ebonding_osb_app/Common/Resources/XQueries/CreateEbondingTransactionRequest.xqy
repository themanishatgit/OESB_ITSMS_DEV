xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/Merge_EbondingTransaction";
(:: import schema at "../DBAdapters/Merge_EbondingTransaction_table.xsd" ::)

declare variable $Message_TranId as xs:string external;
declare variable $TicketNumber as xs:string external;
declare variable $ExtRefNumber as xs:string external;
declare variable $CurrentStatus as xs:string external;
declare variable $IsFirstRefNum as xs:string external;
declare variable $Source as xs:string external;
declare variable $Destination as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $Payload as element(*) external;

declare function local:func($Message_TranId as xs:string,
$TicketNumber as xs:string,
$ExtRefNumber as xs:string,
$CurrentStatus as xs:string,
$IsFirstRefNum as xs:string,
$Source as xs:string,
$Destination as xs:string,
$TransactionType as xs:string,$Payload as element(*)
) as element() (:: schema-element(ns1:EbondingsTransactionsCollection) ::) {
    <ns1:EbondingsTransactionsCollection>
    {
    if($TransactionType='CREATE' or $TransactionType='REOPEN')then
    <ns1:EbondingsTransactions>
            <ns1:tranId>{fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('TRAN_ID'),'select to_char(ESB_TRANSACTIONS_TRAN_ID_SEQ.nextval) from dual')//text()}</ns1:tranId>
            <ns1:ticketNum>{$TicketNumber}</ns1:ticketNum>
            <ns1:externalRefnum>{$ExtRefNumber}</ns1:externalRefnum>
            {
            if($TransactionType='CREATE')then
            <ns1:isFirstRefnum>Y</ns1:isFirstRefnum>
            else
            <ns1:isFirstRefnum>N</ns1:isFirstRefnum>
            }
            <ns1:currentStatus>{$CurrentStatus}</ns1:currentStatus>
            <ns1:source>{$Source}</ns1:source>
            <ns1:destination>{$Destination}</ns1:destination>
            <ns1:creationTime>{fn:current-dateTime()}</ns1:creationTime>
            <ns1:updateTime>{fn:current-dateTime()}</ns1:updateTime>
            <ns1:payload>{$Payload}</ns1:payload>
            <ns1:messageTransId>{$Message_TranId}</ns1:messageTransId>
            <ns1:custom1></ns1:custom1>
            <ns1:custom2></ns1:custom2>
            <ns1:custom3></ns1:custom3>
        </ns1:EbondingsTransactions>
    
    else
    
        <ns1:EbondingsTransactions>
            <ns1:tranId>{fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('TRAN_ID'),'SELECT TRAN_ID FROM EBONDINGS_TRANSACTIONS where TICKET_NUM=? ORDER BY UPDATE_TIME DESC OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY',$TicketNumber)//text()}</ns1:tranId>
            <ns1:currentStatus>{$CurrentStatus}</ns1:currentStatus>
            <ns1:updateTime>{fn:current-dateTime()}</ns1:updateTime>
        </ns1:EbondingsTransactions>
        }
    </ns1:EbondingsTransactionsCollection>
};

local:func($Message_TranId,
$TicketNumber,
$ExtRefNumber,
$CurrentStatus,
$IsFirstRefNum,
$Source,
$Destination,
$TransactionType,
$Payload)