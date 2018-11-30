xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.service-now.com/Sita_inbound";
(:: import schema at "../WSDLs/Provider/SNPartner.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)


declare variable $IncidentRequestMessage as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;
declare variable $Impact as xs:string external;
declare variable $Urgency as xs:string external;

declare function local:func($IncidentRequestMessage as element() (:: schema-element(ns1:IncidentRequestMessage) ::),
         $Impact as xs:string,$Urgency as xs:string)
          as element() (:: schema-element(ns2:execute) ::) {
    <ns2:execute>
        <source_interface>{fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:SourceSystem)}</source_interface>
        <transaction_id>{fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionId)}</transaction_id>
        <rec_type>{
        if(fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:RecType)='INC')
        then('incident')
        else('')
        }</rec_type>
        <customer_interface>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:Name)}</customer_interface>
        <supplier_interface>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Supplier/ns1:Name)}</supplier_interface>
        <ticket_number>{
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)
            then(fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber))
            else()
        }</ticket_number>
        <status>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Status)}</status>
        <assignment_group>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AssignmentGroup)}</assignment_group>
        <description>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</description>
        <short_description>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</short_description>
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)
            then <priority>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)}</priority>
            else ()
        }
        <category>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Category)}</category>
        <subcategory>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SubCategory)}</subcategory>
        <impact>{$Impact}</impact>
        <urgency>{$Urgency}</urgency>
        <cemail_address>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:EmailAddress)}</cemail_address>
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName)
            then <cfirst_name>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName)}</cfirst_name>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName)
            then <clast_name>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName)}</clast_name>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:PhoneNumber)
            then <cphone_number>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:PhoneNumber)}</cphone_number>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)
            then <cust_ref_num>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)}</cust_ref_num>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Supplier/ns1:RefNumber)
            then <sup_ref_num>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Supplier/ns1:RefNumber)}</sup_ref_num>
            else ()
        }
       
        {
			if (fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionType)='ERROR')
			then(
            if (fn:substring-before($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments/text(), ':')!='200')
            then <sup_comments>{fn:substring-after($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments/text(), ':')}</sup_comments>
            else ()
			)
			else(
			if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)
            then (
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionSummary)
            then(<sup_comments>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments), '. 
ResolutionSummary: ',$IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionSummary/text()}</sup_comments>)
            else(<sup_comments>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)}</sup_comments>)
            )
            else ()
			)
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA)
            then <estimated_time>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA)}</estimated_time>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AFT)
            then <actual_fix_time>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AFT)}</actual_fix_time>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA)
            then <actual_tech_arrival>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA)}</actual_tech_arrival>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments)
            then (
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionSummary)
            then(<additional_comments>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments), '. 
Resolution Summary: ', $IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionSummary/text()}</additional_comments>)
            else(<additional_comments>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments)}</additional_comments>)
            )
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:WorkNotes)
            then <work_notes>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:WorkNotes)}</work_notes>
            else ()
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TimeSpent)
            then <time_spent>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TimeSpent)}</time_spent>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TravelTime)
            then <travel_time>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TravelTime)}</travel_time>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionCode)
            then <close_code>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionCode)}</close_code>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate)
            then <open_date>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate)}</open_date>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolvedAt)
            then <resolved_at>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolvedAt)}</resolved_at>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)
            then <cmdb_ci>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</cmdb_ci>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)
            then <business_service>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)}</business_service>
            else ()
        }
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location)
            then <location>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location)}</location>
            else ()
        }
        {
            if (fn:substring-before($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments/text(), ':')='200')
            then <automation_reroute>Y</automation_reroute>
            else ()
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SDOwnerGroup)
            then <sd_owner_group>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SDOwnerGroup)}</sd_owner_group>
            else ()
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ReportMethod)
            then <report_method>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ReportMethod)}</report_method>
            else ()
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Issue)
            then <issue>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Issue)}</issue>
            else ()
        }
        
        {
            if ($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:EventId_CI)
            then <element_ci_id>{fn:data($IncidentRequestMessage/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:EventId_CI)}</element_ci_id>
            else ()
        }
        <transaction_type>{fn:data($IncidentRequestMessage/ns1:IncidentRequestHeader/ns1:TransactionType)}</transaction_type>
    </ns2:execute>
};

local:func($IncidentRequestMessage,$Impact,$Urgency)