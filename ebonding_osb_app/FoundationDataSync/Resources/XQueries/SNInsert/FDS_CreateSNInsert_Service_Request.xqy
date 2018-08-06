xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_services";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_service_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_service_uuid>
        <u_service_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_service_uuid>
        <u_class>{fn:data($Response/Attributes/Attribute[AttrName/text()='class']/AttrValue/text())}</u_class>
         <u_service_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='name']/AttrValue/text())}</u_service_name>
          <u_svc_status>{fn:data($Response/Attributes/Attribute[AttrName/text()='status']/AttrValue/text())}</u_svc_status>
          <u_manufacturer_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='manufacturer']/AttrValue/text())}</u_manufacturer_uuid>
        <u_model_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='model']/AttrValue/text())}</u_model_uuid>
        <u_serial_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='serial_number']/AttrValue/text())}</u_serial_number>
        <u_primary_cnt_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='resource_contact']/AttrValue/text())}</u_primary_cnt_uuid>
        <u_maintenance_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='repair_org']/AttrValue/text())}</u_maintenance_org_uuid>
        <u_location_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='location']/AttrValue/text())}</u_location_uuid>
        <u_description>{fn:data($Response/Attributes/Attribute[AttrName/text()='description']/AttrValue/text())}</u_description>
        <u_owner_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='org_bought_for_uuid']/AttrValue/text())}</u_owner_org_uuid>
        <u_sd_owner_group>{fn:data($Response/Attributes/Attribute[AttrName/text()='zsd_owner_group']/AttrValue/text())}</u_sd_owner_group>
        <u_support_model>{fn:data($Response/Attributes/Attribute[AttrName/text()='zsupport_model']/AttrValue/text())}</u_support_model>
           <u_contract_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcontract_id']/AttrValue/text())}</u_contract_id>
              <u_customer_org>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcustomer_org']/AttrValue/text())}</u_customer_org>

     
             
</insert>	
};

local:func($Response)