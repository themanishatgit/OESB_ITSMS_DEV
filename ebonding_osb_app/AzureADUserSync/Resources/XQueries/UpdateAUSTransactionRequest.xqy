xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/UpdateAUSTransaction";
(:: import schema at "../DBAdapters/UpdateAUSTransaction/UpdateAUSTransaction_table.xsd" ::)

declare variable $TransactionId as xs:string external;
declare variable $BatchId as xs:string external;
declare variable $RecordType as xs:string external;
declare variable $Status as xs:string external;
declare variable $Payload as xs:string external;
declare variable $NextLink as xs:string external;
declare variable $Deltalink as xs:string external;
declare variable $RecordCount as xs:string external;
declare variable $errCode as xs:string external;
declare variable $errMsg as xs:string external;

declare function local:func($TransactionId as xs:string,
                            $BatchId as xs:string,
                            $RecordType as xs:string,
                            $Status as xs:string,
                            $Payload as xs:string,
                            $NextLink as xs:string,
                            $Deltalink as xs:string,
                            $RecordCount as xs:string,
                            $errCode as xs:string,
                            $errMsg as xs:string) as element() (:: schema-element(ns1:AusTransactionsCollection) ::) {
    <ns1:AusTransactionsCollection>
        <ns1:AusTransactions>
            <ns1:transactionId>{$TransactionId}</ns1:transactionId>
            {
            if($BatchId)
            then(<ns1:batchId>{$BatchId}</ns1:batchId>)
            else()
            }
            {
            if($RecordType)
            then(
            <ns1:recordType>{$RecordType}</ns1:recordType>
            )
            else()
            }
            {if($Status)
            then(
            <ns1:status>{$Status}</ns1:status>
            )
            else()
            }
            {
        if($Payload)
        then(<ns1:payload>{$Payload}</ns1:payload>)
        else()
        }
            <ns1:machineName>{fn-bea:getHostname()}</ns1:machineName>
            {
        if($NextLink)
        then(<ns1:nextlink>{$NextLink}</ns1:nextlink>)
        else()
        }
         {
        if($Deltalink)
        then(<ns1:deltalink>{$Deltalink}</ns1:deltalink>)
        else()
        }
            <ns1:timestamp>{fn:current-dateTime()}</ns1:timestamp>
         {
        if($RecordCount)
        then(<ns1:recordCount>{xs:integer($RecordCount)}</ns1:recordCount>)
        else()
        }
        {
         if($errCode)
        then(<ns1:errCode>{$errCode}</ns1:errCode>)
        else()
        }
        {
        if($errMsg)
        then(<ns1:errMsg>{$errMsg}</ns1:errMsg>)
        else()
        }
        </ns1:AusTransactions>
    </ns1:AusTransactionsCollection>
};

local:func($TransactionId, $BatchId, $RecordType, $Status, $Payload, $NextLink, $Deltalink, $RecordCount, $errCode, $errMsg)