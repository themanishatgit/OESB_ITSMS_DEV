xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_models";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_model_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_model_uuid>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
        <u_model_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='sym']/AttrValue/text())}</u_model_name>
         <u_manufacturer_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='manufacturer']/AttrValue/text())}</u_manufacturer_uuid>
          <u_class>{fn:data($Response/Attributes/Attribute[AttrName/text()='resource_class.type']/AttrValue/text())}</u_class>
          <u_family>{fn:data($Response/Attributes/Attribute[AttrName/text()='resource_family.sym']/AttrValue/text())}</u_family>
             
</insert>	
};

local:func($Response)