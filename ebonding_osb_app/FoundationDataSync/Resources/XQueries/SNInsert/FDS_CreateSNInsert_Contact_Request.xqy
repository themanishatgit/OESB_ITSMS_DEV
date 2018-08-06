xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_users";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_contact_uuid>
        <u_c_supervisor_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='supervisor_contact_uuid']/AttrValue/text())}</u_c_supervisor_contact_uuid>
        <u_last_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='last_name']/AttrValue/text())}</u_last_name>
         <u_first_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='first_name']/AttrValue/text())}</u_first_name>
          <u_middle_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='middle_name']/AttrValue/text())}</u_middle_name>
          <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
        <u_userid>{fn:data($Response/Attributes/Attribute[AttrName/text()='userid']/AttrValue/text())}</u_userid>
        <u_pri_phone_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='phone_number']/AttrValue/text())}</u_pri_phone_number>
        <u_alt_phone_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='alt_phone']/AttrValue/text())}</u_alt_phone_number>
        <u_contact_type>{fn:data($Response/Attributes/Attribute[AttrName/text()='type.sym']/AttrValue/text())}</u_contact_type>
        <u_location_name_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='location']/AttrValue/text())}</u_location_name_uuid>
        <u_department>{fn:data($Response/Attributes/Attribute[AttrName/text()='dept.name']/AttrValue/text())}</u_department>
        <u_admin_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='organization']/AttrValue/text())}</u_admin_org_uuid>
        <u_email_address>{fn:data($Response/Attributes/Attribute[AttrName/text()='email_address']/AttrValue/text())}</u_email_address>
        <u_contact_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='contact_num']/AttrValue/text())}</u_contact_id>
        <u_access_type>{fn:data($Response/Attributes/Attribute[AttrName/text()='access_type.sym']/AttrValue/text())}</u_access_type>
        <u_notif_method>{fn:data($Response/Attributes/Attribute[AttrName/text()='notify_method1.sym']/AttrValue/text())}</u_notif_method>
        <u_visible>{fn:data($Response/Attributes/Attribute[AttrName/text()='zvisible']/AttrValue/text())}</u_visible>
        <u_cnt_desc>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcnt_description']/AttrValue/text())}</u_cnt_desc>
                 
</insert>	
};

local:func($Response)