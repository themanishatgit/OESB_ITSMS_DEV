xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/SITA_DeleteSyncData";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
<execute>
 <shub_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</shub_id>
        <object_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())}</object_name>
    </execute>
};

local:func($Response)