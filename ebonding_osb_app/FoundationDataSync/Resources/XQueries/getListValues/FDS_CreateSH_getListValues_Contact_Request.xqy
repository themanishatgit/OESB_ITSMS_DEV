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
                         <string>supervisor_contact_uuid</string>
                        <string>last_name</string>
			<string>first_name</string>
			<string>middle_name</string>
			<string>delete_flag</string>			
			<string>userid</string>
			<string>phone_number</string>
			<string>alt_phone</string>			
			<string>type</string>
			<string>location</string>
			<string>dept</string>
			<string>organization</string>			
			<string>email_address</string>			
			<string>contact_num</string>			
			<string>access_type</string>			
			<string>notify_method2</string>			
			<string>zvisible</string>		
			<string>zmcs_customer</string>
			<string>zcnt_description</string>	
         </attributeNames>
      </ser:getListValues>
};

local:func($SessionId, $ListHandle, $StartIndex, $EndIndex)