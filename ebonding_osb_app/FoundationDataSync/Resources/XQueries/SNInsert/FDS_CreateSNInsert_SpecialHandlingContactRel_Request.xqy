xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_user_special_handlings";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_id>
        <u_contact>{fn:data($Response/Attributes/Attribute[AttrName/text()='contact']/AttrValue/text())}</u_contact>
        <u_spec_handling>{fn:data($Response/Attributes/Attribute[AttrName/text()='special_handling.sym']/AttrValue/text())}</u_spec_handling>
                   
</insert>	
};

local:func($Response)