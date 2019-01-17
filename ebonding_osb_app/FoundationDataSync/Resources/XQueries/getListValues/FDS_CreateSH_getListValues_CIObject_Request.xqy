xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $SessionId as xs:string external;
declare variable $ListHandle as xs:string external;
declare variable $StartIndex as xs:string external;
declare variable $EndIndex as xs:string external;

declare function local:func($SessionId as xs:string,
                            $ListHandle as xs:string,
                            $StartIndex as xs:string,
                            $EndIndex as xs:string
                            ) {
    <ser:getListValues xmlns:ser="http://www.ca.com/UnicenterServicePlus/ServiceDesk">
         <sid>{$SessionId}</sid>
         <listHandle>{$ListHandle}</listHandle>
         <startIndex>{$StartIndex}</startIndex>
         <endIndex>{$EndIndex}</endIndex>
         <attributeNames>
            <!--1 or more repetitions:-->
            <string>id</string>           
			<string>delete_flag</string>
			<string>family</string>
			<string>class.type</string>
			<string>name</string>
			<string>asset_num</string>
			<string>system_name</string>
			<string>mac_address</string>
			<string>dns_name</string>
			<string>alarm_id</string>
			<string>license_number</string>
			<string>status.sym</string>
			<string>supplier</string>
			<string>vendor_repair</string>
			<string>model</string>
			<string>product_version</string>
			<string>serial_number</string>
			<string>resource_contact</string>			
			<string>repair_org</string>
			<string>location</string>
			<string>loc_floor</string>
			<string>loc_room</string>
			<string>loc_cabinet</string>
			<string>loc_shelf</string>
			<string>loc_slot</string>
			<string>install_date</string>
			<string>acquire_date</string>
			<string>description</string>
			<string>ufam</string>
			<string>org_bought_for_uuid</string>		
			<string>billing_contact_uuid</string>
			<string>support_contact1_uuid</string>
			<string>support_contact2_uuid</string>
			<string>support_contact3_uuid</string>
			<string>disaster_recovery_contact_uuid</string>
			<string>backup_services_contact_uuid</string>
			<string>network_contact_uuid</string>
			<string>is_asset</string>
			<string>is_ci</string>
			<string>warranty_start</string>
			<string>warranty_end</string>
			<string>expiration_date</string>
			<string>financial_num</string>
			<string>vendor_restore</string>
			<string>zpm_required</string>
			<string>zpm_duration</string>
			<string>zpm_next_maint</string>
			<string>zwarranty_org</string>
			<string>zcustomer_org</string>
			<string>zPO</string>
			<string>zPO_line</string>
			<string>zcontract_id</string>
			<string>zproject_code</string>
			<string>zlegal_entity</string>
			<string>zchild_ncc</string>
			<string>zinterface_link</string>
			<string>zmcs_ci</string>
			<string>zparent_svc</string>
			<string>zsd_owner_group</string>
			<string>zpci_compliant</string>
			<string>zenvironment.sym</string>
			<string>zmcs_resilience_type.sym</string>
			<string>zsupport_model.sym</string>
		</attributeNames>
      </ser:getListValues>
};

local:func($SessionId, $ListHandle, $StartIndex, $EndIndex)