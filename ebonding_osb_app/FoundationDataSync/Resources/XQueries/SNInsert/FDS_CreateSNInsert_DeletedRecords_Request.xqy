xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_deletion";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
<u:insert xmlns:u="http://www.service-now.com/u_sync_deletion">
    <u_object_name>{
        if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='USP_LREL_CENV_CNTREF')
        then('u_user_ci_relationship')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='GRPMEM')
        then('sys_user_grmember')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='USP_CONTACT_HANDLING')
        then('u_user_special_handlings')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='BUSMGT')
        then('cmdb_rel_ci')
        else()
        }</u_object_name>
    <!--Optional:-->
    <u_state>Pending</u_state>
    <!--Optional:-->
    <u_uuid>{fn:data($Response/Attributes/Attribute[AttrName/text()='id_del']/AttrValue/text())}</u_uuid>
</u:insert>
};

local:func($Response)