xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_organisation";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
<insert> 
        <u_organization_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_organization_uuid>
        <u_organization_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='name']/AttrValue/text())}</u_organization_name>
        <u_ncc>{fn:data($Response/Attributes/Attribute[AttrName/text()='zncc']/AttrValue/text())}</u_ncc>
        <u_iata>{fn:data($Response/Attributes/Attribute[AttrName/text()='org_num']/AttrValue/text())}</u_iata>
        <u_icao>{fn:data($Response/Attributes/Attribute[AttrName/text()='zicao']/AttrValue/text())}</u_icao>
        <u_ald>{fn:data($Response/Attributes/Attribute[AttrName/text()='zald']/AttrValue/text())}</u_ald>
        <u_parent_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='zparent']/AttrValue/text())}</u_parent_org_uuid>
        <u_phone_num>{fn:data($Response/Attributes/Attribute[AttrName/text()='phone_number']/AttrValue/text())}</u_phone_num>
        <u_description>{fn:data($Response/Attributes/Attribute[AttrName/text()='description']/AttrValue/text())}</u_description>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
      
</insert>	
};

local:func($Response)