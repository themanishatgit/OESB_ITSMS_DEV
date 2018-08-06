xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $SessionId as xs:string external;
declare variable $ListHandle as xs:string external;
declare variable $StartIndex as xs:string external;
declare variable $EndIndex as xs:string external;

declare function local:func($SessionId as xs:string,
                            $ListHandle as xs:string,
                            $StartIndex as xs:string,
                            $EndIndex as xs:string) {
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
			<string>class</string>
			<string>name</string>
			<string>status</string>
			<string>manufacturer</string>
			<string>model</string>
			<string>serial_number</string>
			<string>resource_contact</string>
			<string>service_org</string>
			<string>repair_org</string>
			<string>location</string>
			<string>description</string>
			<string>org_bought_for_uuid</string>
			<string>resource_owner_uuid</string>
			<string>billing_contact_uuid</string>
			<string>support_contact1_uuid</string>
			<string>support_contact2_uuid</string>
			<string>support_contact3_uuid</string>
			<string>disaster_recovery_contact_uuid</string>
			<string>backup_services_contact_uuid</string>
			<string>network_contact_uuid</string>
			<string>zinterface_link</string>
			<string>zsd_owner_group</string>
			<string>zsupport_model</string>
		</attributeNames>
      </ser:getListValues>
};

local:func($SessionId, $ListHandle, $StartIndex, $EndIndex)