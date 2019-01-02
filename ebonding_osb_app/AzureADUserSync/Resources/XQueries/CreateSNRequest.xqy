xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_azure_integration";
(:: import schema at "../WSDLs/SNUserPublishBS.wsdl" ::)
declare namespace ns2="http://www.sita.aero/getdelta";
declare namespace ns3="http://www.sita.aero/getmanager";
(:: import schema at "../Schemas/GetManagerResponse.xsd" ::)

declare variable $DeltaUser as element(*) external;
declare variable $Manager as element() (:: schema-element(ns3:Manager) ::) external;

declare function local:func($DeltaUser as element(*), 
                            $Manager as element() (:: schema-element(ns3:Manager) ::)) 
                            as element() (:: schema-element(ns1:insert) ::) {
    <ns1:insert>
        <u_active>{$DeltaUser/*:accountEnabled/text()}</u_active>
        <u_business_phone>{$DeltaUser/*:businessPhones/text()}</u_business_phone>
        <u_company>{$DeltaUser/*:companyName/text()}</u_company>
        <u_contact_type>EMPLOYEE</u_contact_type>
        <u_department>{$DeltaUser/*:onPremisesExtensionAttributes/*:extensionAttribute7/text()}</u_department>
        <u_email>{$DeltaUser/*:mail/text()}</u_email>
        <u_employee_number>{$DeltaUser/*:onPremisesExtensionAttributes/*:extensionAttribute3/text()}</u_employee_number>
        <u_first_name>{$DeltaUser/*:givenName/text()}</u_first_name>
        <u_last_name>{$DeltaUser/*:surname/text()}</u_last_name>
        <u_manager_email>{$Manager/*:mail/text()}</u_manager_email>
        <u_middle_name></u_middle_name>
        <u_mobile_phone>{$DeltaUser/*:mobilePhone/text()}</u_mobile_phone>
        <u_notification>Enable</u_notification>
        <u_office_location>{$DeltaUser/*:officeLocation/text()}</u_office_location>
        <u_source>Azure</u_source>
        <u_user_account_id>{$DeltaUser/*:id/text()}</u_user_account_id>
    </ns1:insert>
};

local:func($DeltaUser, $Manager)