xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/SITA_DeleteSyncData";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
<execute>
 <shub_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id_del']/AttrValue/text())}</shub_id>
        <object_name>{
        if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='USP_LREL_CENV_CNTREF')
        then('u_user_ci_relationship')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='GRPMEM')
        then('sys_user_grmember')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='USP_CONTACT_HANDLING')
        then('u_user_special_handlings')
        else if(fn:data($Response/Attributes/Attribute[AttrName/text()='table_name']/AttrValue/text())='BUSMGT')
        then('cmdb_rel_ci')
        else()
        }</object_name>
    </execute>
};

local:func($Response)