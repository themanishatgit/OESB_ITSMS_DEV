xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_group";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_contact_uuid>
        <u_last_name>{fn:data($Response/Attributes/Attribute[AttrName/text()='last_name']/AttrValue/text())}</u_last_name>
        <u_inactive>{fn:data($Response/Attributes/Attribute[AttrName/text()='delete_flag']/AttrValue/text())}</u_inactive>
         <u_pri_phone_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='phone_number']/AttrValue/text())}</u_pri_phone_number>
          <u_alt_phone_number>{fn:data($Response/Attributes/Attribute[AttrName/text()='alt_phone']/AttrValue/text())}</u_alt_phone_number>
          <u_location_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='location']/AttrValue/text())}</u_location_uuid>
        <u_admin_org_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='organization']/AttrValue/text())}</u_admin_org_uuid>
        <u_email_address>{
      if(fn:substring-before(fn:data($Response/Attributes/Attribute[AttrName/text()='email_address']/AttrValue/text()),','))
then(fn:substring-before(fn:data($Response/Attributes/Attribute[AttrName/text()='email_address']/AttrValue/text()),','))
else($Response/Attributes/Attribute[AttrName/text()='email_address']/AttrValue/text())
      }</u_email_address>
       <u_secondary_email_address>{fn:substring-after(fn:data($Response/Attributes/Attribute[AttrName/text()='email_address']/AttrValue/text()),',')}</u_secondary_email_address>
        <u_notif_method>{fn:data($Response/Attributes/Attribute[AttrName/text()='notify_method2.sym']/AttrValue/text())}</u_notif_method>
        <u_visible>{fn:data($Response/Attributes/Attribute[AttrName/text()='zvisible']/AttrValue/text())}</u_visible>
        <u_cnt_desc>{fn:data($Response/Attributes/Attribute[AttrName/text()='zcnt_description']/AttrValue/text())}</u_cnt_desc>
        <u_notif_footer>{fn:data($Response/Attributes/Attribute[AttrName/text()='znot_footer']/AttrValue/text())}</u_notif_footer>
        <u_sd_owner_group>{fn:data($Response/Attributes/Attribute[AttrName/text()='zsd_group']/AttrValue/text())}</u_sd_owner_group>
   <u_c_supervisor_contact_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='supervisor_contact_uuid']/AttrValue/text())}</u_c_supervisor_contact_uuid>      
             
</insert>	
};

local:func($Response)