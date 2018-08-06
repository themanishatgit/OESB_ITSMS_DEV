xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_special_handling";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_id>
        <u_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='sym']/AttrValue/text())}</u_name>
        <u_description>{fn:data($Response/Attributes/Attribute[AttrName/text()='description']/AttrValue/text())}</u_description>
         <u_alert_text>{fn:data($Response/Attributes/Attribute[AttrName/text()='alert_text']/AttrValue/text())}</u_alert_text>
         <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
        
             
</insert>
};

local:func($Response)