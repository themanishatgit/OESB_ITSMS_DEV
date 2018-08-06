xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_contact_ci_relationship";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_id>
        <u_ci_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='nr']/AttrValue/text())}</u_ci_uuid>
        <u_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='cnt']/AttrValue/text())}</u_contact_uuid>
    </insert>
};
local:func($Response)