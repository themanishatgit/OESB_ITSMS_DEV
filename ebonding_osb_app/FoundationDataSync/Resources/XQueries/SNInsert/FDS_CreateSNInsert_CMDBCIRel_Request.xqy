xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.service-now.com/u_sync_cmdb_relationship";

declare variable $Response as element()  external;

declare function local:func($Response as element() )as element()  {
   <insert> 
        <u_id>{fn:data($Response/Attributes/Attribute[AttrName/text()='id']/AttrValue/text())}</u_id>
        <u_hier_parent>{fn:data($Response/Attributes/Attribute[AttrName/text()='parent']/AttrValue/text())}</u_hier_parent>
        <u_hier_child>{fn:data($Response/Attributes/Attribute[AttrName/text()='child']/AttrValue/text())}</u_hier_child>
         <u_ci_rel_type>{fn:data($Response/Attributes/Attribute[AttrName/text()='ci_rel_type']/AttrValue/text())}</u_ci_rel_type>
        
             
</insert>
};

local:func($Response)