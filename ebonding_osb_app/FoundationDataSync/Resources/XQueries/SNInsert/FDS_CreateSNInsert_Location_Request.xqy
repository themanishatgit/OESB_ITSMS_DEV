xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_location";

declare variable $Response as element()  external;


declare function local:func($Response as element() )as element()  {
   <insert>     
 
       <u_location_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_location_uuid>
        <u_location_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='name']/AttrValue/text())}</u_location_name>
        <u_site_category>{fn:data($Response/Attributes/Attribute[AttrName/text()='site.name']/AttrValue/text())}</u_site_category>
        <u_address_1>{fn:data($Response/Attributes/Attribute[AttrName/text()='address1']/AttrValue/text())}</u_address_1>
        <u_address_2>{fn:data($Response/Attributes/Attribute[AttrName/text()='address2']/AttrValue/text())}</u_address_2>
        <u_address_3>{fn:data($Response/Attributes/Attribute[AttrName/text()='address3']/AttrValue/text())}</u_address_3>
        <u_address_4>{fn:data($Response/Attributes/Attribute[AttrName/text()='address4']/AttrValue/text())}</u_address_4>
        <u_address_5>{fn:data($Response/Attributes/Attribute[AttrName/text()='address5']/AttrValue/text())}</u_address_5>
        <u_cust_code>{fn:data($Response/Attributes/Attribute[AttrName/text()='address6']/AttrValue/text())}</u_cust_code>
        <u_comments>{fn:data($Response/Attributes/Attribute[AttrName/text()='description']/AttrValue/text())}</u_comments>
        <u_city>{fn:data($Response/Attributes/Attribute[AttrName/text()='city']/AttrValue/text())}</u_city>
        <u_state>{fn:data($Response/Attributes/Attribute[AttrName/text()='state.sym']/AttrValue/text())}</u_state>
        <u_zip>{fn:data($Response/Attributes/Attribute[AttrName/text()='zip']/AttrValue/text())}</u_zip>
        <u_country_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='country.name']/AttrValue/text())}</u_country_name>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>         
    </insert>
  
};

local:func($Response)