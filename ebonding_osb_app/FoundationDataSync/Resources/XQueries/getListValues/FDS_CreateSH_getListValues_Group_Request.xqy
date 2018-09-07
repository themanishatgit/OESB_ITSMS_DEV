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
            <string>last_name</string>		
			<string>delete_flag</string>	
			<string>phone_number</string>
			<string>alt_phone</string>			
			<string>type</string>
			<string>location</string>
			<string>dept</string>
			<string>organization</string>			
			<string>email_address</string>		
			<string>notify_method2.sym</string>	
			<string>zinterface_link</string>			
			<string>zvisible</string>		
			<string>zcnt_description</string>
			<string>znot_footer</string>
			<string>zsd_group</string>
		</attributeNames>
      </ser:getListValues>
};

local:func($SessionId, $ListHandle, $StartIndex, $EndIndex)