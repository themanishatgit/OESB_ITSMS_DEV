xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/UpdateFDSTransaction";
(:: import schema at "../DBAdapters/UpdateFDSTransaction/UpdateFDSTransaction_table.xsd" ::)

declare variable $BatchId as xs:string external;
declare variable $ObjectName as xs:string external;
declare variable $Status as xs:string external;
declare variable $Payload as xs:string external;
declare variable $errCode as xs:string external;
declare variable $errMsg as xs:string external;
declare variable $executionTime as xs:string external;
declare variable $TransactionId as xs:string external;
declare variable $RecordCount as xs:string external;
declare variable $listHandle as xs:string external;
declare variable $splitCount as xs:string external;

declare function local:func($BatchId as xs:string,
                            $ObjectName as xs:string,
                            $Status as xs:string,
                            $Payload as xs:string,
                            $errCode as xs:string,
                            $errMsg as xs:string,
                            $executionTime as xs:string,
                            $TransactionId as xs:string,
                            $RecordCount as xs:string,
                            $listHandle as xs:string,
                            $splitCount as xs:string) as element() (:: element(*, ns1:FdsTransactionsCollection) ::) {
<ns1:FdsTransactionsCollection>
    <ns1:FdsTransactions>
        <ns1:transactionId>{$TransactionId}</ns1:transactionId>
        <ns1:batchId>{$BatchId}</ns1:batchId>
        <ns1:objectName>{$ObjectName}</ns1:objectName>
        <ns1:status>{$Status}</ns1:status>
        {
        if($Payload)
        then(<ns1:payload>{$Payload}</ns1:payload>)
        else()
        }
        <ns1:machineName>{fn-bea:getHostname()}</ns1:machineName>
        {if($errCode)
        then(<ns1:errCode>{$errCode}</ns1:errCode>)
        else()
        }
        {
        if($errMsg)
        then(<ns1:errMsg>{$errMsg}</ns1:errMsg>)
        else()
        }
        <ns1:timestamp>{fn:current-dateTime()}</ns1:timestamp>
        {
        if($executionTime)
        then(<ns1:executionTime>{$executionTime}</ns1:executionTime>)
        else()
        }
        {
        if($RecordCount)
        then(<ns1:recordCount>{xs:integer($RecordCount)}</ns1:recordCount>)
        else()
        }
        {
        if($listHandle)
        then(<ns1:listHandle>{$listHandle}</ns1:listHandle>)
        else()
        }
        {
        if($splitCount)
        then(<ns1:splitCount>{$splitCount}</ns1:splitCount>)
        else()
        }
    </ns1:FdsTransactions>
</ns1:FdsTransactionsCollection>
};

local:func($BatchId, $ObjectName, $Status, $Payload, $errCode, $errMsg, $executionTime, $TransactionId, $RecordCount, $listHandle, $splitCount)