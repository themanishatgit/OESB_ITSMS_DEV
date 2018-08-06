xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_group_members";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_id>
        <u_group_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='group']/AttrValue/text())}</u_group_uuid>
        <u_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='member']/AttrValue/text())}</u_contact_uuid>
             
</insert>	
};

local:func($Response)