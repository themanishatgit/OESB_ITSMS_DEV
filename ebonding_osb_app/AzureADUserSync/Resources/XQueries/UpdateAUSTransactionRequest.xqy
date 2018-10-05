xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/top/UpdateAUSTransaction";
(:: import schema at "../DBAdapters/UpdateAUSTransaction/UpdateAUSTransaction_table.xsd" ::)

declare variable $BatchId as xs:string external;
declare variable $TranId as xs:string external;
declare variable $NextLink as xs:string external;
declare variable $DeltaLink as xs:string external;
declare variable $Payload as xs:string external;
declare variable $UserCount as xs:string external;
declare variable $Status as xs:string external;
declare variable $ErrCode as xs:string external;
declare variable $ErrMsg as xs:string external;

declare function local:func($BatchId as xs:string, 
                            $TranId as xs:string,
                            $NextLink as xs:string,
                            $DeltaLink as xs:string,
                            $Payload as xs:string,
                            $UserCount as xs:string,
                            $Status as xs:string,
                            $ErrCode as xs:string,
                            $ErrMsg as xs:string
                            ) 
                            as element() (:: schema-element(ns1:AusTransactionsCollection) ::) {
    <ns1:AusTransactionsCollection>
        <ns1:AusTransactions>
            {if($NextLink) then <ns1:nextlink>{$NextLink}</ns1:nextlink> else ()}
            {if($DeltaLink) then <ns1:deltalink>{$DeltaLink}</ns1:deltalink> else ()}
            {if($Payload) then <ns1:payload>{$Payload}</ns1:payload> else ()}
            <ns1:creationTime>{fn:current-dateTime()}</ns1:creationTime>
            {if($UserCount) then <ns1:userCount>{$UserCount}</ns1:userCount> else ()}
            {if($BatchId) then <ns1:batchId>{$BatchId}</ns1:batchId> else ()}
            {if($TranId) then <ns1:transactionId>{$TranId}</ns1:transactionId> else ()}
            {if($Status) then <ns1:status>{$Status}</ns1:status> else ()}
            {if($ErrCode) then <ns1:errCode>{$ErrCode}</ns1:errCode> else ()}
            {if($ErrMsg) then <ns1:errMsg>{$ErrMsg}</ns1:errMsg> else ()}
            <ns1:machineName>{fn-bea:getHostname()}</ns1:machineName>
        </ns1:AusTransactions>
    </ns1:AusTransactionsCollection>
};

local:func($BatchId, $TranId,$NextLink,$DeltaLink,$Payload,$UserCount,$Status,$ErrCode,$ErrMsg)
