xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $SessionId as xs:string external;
declare variable $ObjectName as xs:string external;
declare variable $LastModifiedTime as xs:string external;
declare variable $CurrentEpochTime as xs:string external;
declare variable $AdditionalFilter as xs:string external;

declare function local:func($SessionId as xs:string,
                            $ObjectName as xs:string,
                            $LastModifiedTime as xs:string,
                            $CurrentEpochTime as xs:string,
                            $AdditionalFilter as xs:string) {
    <ser:doQuery xmlns:ser="http://www.ca.com/UnicenterServicePlus/ServiceDesk">
         <sid>{$SessionId}</sid>
         <objectType>{$ObjectName}</objectType>
         <whereClause>{
         if($AdditionalFilter)
         then
         (
           if($ObjectName='nr')
           then(fn:concat('last_mod&gt;',$LastModifiedTime,' and last_mod&lt;',$CurrentEpochTime,' and ',$AdditionalFilter))
           else if($ObjectName='contact_handling')
           then(fn:concat('last_mod_date&gt;',$LastModifiedTime,' and last_mod_date&lt;',$CurrentEpochTime,' and ',$AdditionalFilter))
           else(fn:concat('last_mod_dt&gt;',$LastModifiedTime,' and last_mod_dt&lt;',$CurrentEpochTime,' and ',$AdditionalFilter))
         )
         else
         (
           if($ObjectName='nr')
           then(fn:concat('last_mod&gt;',$LastModifiedTime,' and last_mod&lt;',$CurrentEpochTime))
           else if($ObjectName='contact_handling')
           then(fn:concat('last_mod_date&gt;',$LastModifiedTime,' and last_mod_date&lt;',$CurrentEpochTime))
           else(fn:concat('last_mod_dt&gt;',$LastModifiedTime,' and last_mod_dt&lt;',$CurrentEpochTime))
         )
         }</whereClause>
      </ser:doQuery>

};

local:func($SessionId, $ObjectName, $LastModifiedTime, $CurrentEpochTime, $AdditionalFilter)