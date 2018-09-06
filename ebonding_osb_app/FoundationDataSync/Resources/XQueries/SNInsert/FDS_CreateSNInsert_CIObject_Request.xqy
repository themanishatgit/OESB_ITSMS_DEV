xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_asset";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_ci_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_ci_uuid>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
        <u_family>{fn:data($Response/Attributes/Attribute[AttrName/text()='family']/AttrValue/text())}</u_family>
            <u_class>{fn:data($Response/Attributes/Attribute[AttrName/text()='class']/AttrValue/text())}</u_class>
        <u_asset_tag>{fn:data($Response/Attributes/Attribute[AttrName/text()='name']/AttrValue/text())}</u_asset_tag>
        <u_node_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='asset_num']/AttrValue/text())}</u_node_name>
             <u_host_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='system_name']/AttrValue/text())}</u_host_name>
        <u_mac_address>{fn:data($Response/Attributes/Attribute[AttrName/text()='mac_address']/AttrValue/text())}</u_mac_address>
        <u_dns_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='dns_name']/AttrValue/text())}</u_dns_name>
              <u_ip_address>{fn:data($Response/Attributes/Attribute[AttrName/text()='alarm_id']/AttrValue/text())}</u_ip_address>
        <u_svc_status>{fn:data($Response/Attributes/Attribute[AttrName/text()='status.sym']/AttrValue/text())}</u_svc_status>
        <u_supply_vendor>{fn:data($Response/Attributes/Attribute[AttrName/text()='supplier']/AttrValue/text())}</u_supply_vendor>
              <u_maintenance_vendor>{fn:data($Response/Attributes/Attribute[AttrName/text()='vendor_repair']/AttrValue/text())}</u_maintenance_vendor>
        <u_model_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='model']/AttrValue/text())}</u_model_uuid>
        <u_product_version>{fn:data($Response/Attributes/Attribute[AttrName/text()='product_version']/AttrValue/text())}</u_product_version>
              <u_serial_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='serial_number']/AttrValue/text())}</u_serial_number>
        <u_primary_cnt_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='resource_contact']/AttrValue/text())}</u_primary_cnt_uuid>
        <u_maintenance_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='repair_org']/AttrValue/text())}</u_maintenance_org_uuid>
              <u_location_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='location']/AttrValue/text())}</u_location_uuid>
        <u_floor_location>{fn:data($Response/Attributes/Attribute[AttrName/text()='loc_floor']/AttrValue/text())}</u_floor_location>
        <u_room_location>{fn:data($Response/Attributes/Attribute[AttrName/text()='loc_room']/AttrValue/text())}</u_room_location>
              <u_cabinet_location>{fn:data($Response/Attributes/Attribute[AttrName/text()='loc_cabinet']/AttrValue/text())}</u_cabinet_location>
        <u_shelf_location>{fn:data($Response/Attributes/Attribute[AttrName/text()='loc_shelf']/AttrValue/text())}</u_shelf_location>
        <u_slot_location>{fn:data($Response/Attributes/Attribute[AttrName/text()='loc_slot']/AttrValue/text())}</u_slot_location>
        
              <u_installation_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='install_date']/AttrValue/text())}</u_installation_date>
        <u_acquire_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='acquire_date']/AttrValue/text())}</u_acquire_date>
        <u_notes>{fn:data($Response/Attributes/Attribute[AttrName/text()='description']/AttrValue/text())}</u_notes>
              <u_owner_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='org_bought_for_uuid']/AttrValue/text())}</u_owner_org_uuid>
        <u_warranty_start_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='warranty_start']/AttrValue/text())}</u_warranty_start_date>
        <u_warranty_end_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='warranty_end']/AttrValue/text())}</u_warranty_end_date>
              <u_expiration_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='expiration_date']/AttrValue/text())}</u_expiration_date>
        <u_financial_ref>{fn:data($Response/Attributes/Attribute[AttrName/text()='financial_num']/AttrValue/text())}</u_financial_ref>
        <u_responsible_vendor>{fn:data($Response/Attributes/Attribute[AttrName/text()='vendor_restore']/AttrValue/text())}</u_responsible_vendor>
              <u_pm_required>{fn:data($Response/Attributes/Attribute[AttrName/text()='zpm_required']/AttrValue/text())}</u_pm_required>
        <u_pm_duration>{fn:data($Response/Attributes/Attribute[AttrName/text()='zpm_duration']/AttrValue/text())}</u_pm_duration>
        <u_next_pm_date>{fn:data($Response/Attributes/Attribute[AttrName/text()='zpm_next_maint']/AttrValue/text())}</u_next_pm_date>
              <u_warranty_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='zwarranty_org']/AttrValue/text())}</u_warranty_org_uuid>
        <u_customer_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcustomer_org']/AttrValue/text())}</u_customer_org_uuid>
        <u_po>{fn:data($Response/Attributes/Attribute[AttrName/text()='zPO']/AttrValue/text())}</u_po>
              <u_po_line>{fn:data($Response/Attributes/Attribute[AttrName/text()='zPO_line']/AttrValue/text())}</u_po_line>
        <u_contract_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcontract_id']/AttrValue/text())}</u_contract_id>
        <u_sita_legal_entity>{fn:data($Response/Attributes/Attribute[AttrName/text()='zlegal_entity']/AttrValue/text())}</u_sita_legal_entity>
        
               <u_child_ncc>{fn:data($Response/Attributes/Attribute[AttrName/text()='zchild_ncc']/AttrValue/text())}</u_child_ncc>
        <u_mcs_ci>{fn:data($Response/Attributes/Attribute[AttrName/text()='zmcs_ci']/AttrValue/text())}</u_mcs_ci>
        <u_parent_svc_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='zparent_svc']/AttrValue/text())}</u_parent_svc_uuid>
              <u_sd_owner_group_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='zsd_owner_group']/AttrValue/text())}</u_sd_owner_group_uuid>
        <u_pci>{fn:data($Response/Attributes/Attribute[AttrName/text()='zpci_compliant']/AttrValue/text())}</u_pci>
        <u_environment>{fn:data($Response/Attributes/Attribute[AttrName/text()='zenvironment']/AttrValue/text())}</u_environment>
              <u_mcs_resiliency_type>{fn:data($Response/Attributes/Attribute[AttrName/text()='zmcs_resilience_type']/AttrValue/text())}</u_mcs_resiliency_type>
        <u_support_model>{fn:data($Response/Attributes/Attribute[AttrName/text()='zsupport_model']/AttrValue/text())}</u_support_model>
      
                                                                                     
</insert>	
};

local:func($Response)