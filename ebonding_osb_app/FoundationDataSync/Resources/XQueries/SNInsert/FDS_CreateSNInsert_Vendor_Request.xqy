xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_vendor";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
     <insert> 
        <u_vendor_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_vendor_uuid>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
        <u_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='sym']/AttrValue/text())}</u_name>
              
</insert>
};

local:func($Response)