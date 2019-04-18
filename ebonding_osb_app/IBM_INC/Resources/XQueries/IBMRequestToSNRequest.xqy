xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

(:: import schema at "../Schemas/IBM_Inbound.xsd" ::)
declare variable $MsgTranId as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $Ticket_Num as xs:string  external;
declare variable $IBMRequest as element() external;
declare variable $status as xs:string external;
declare variable $SourceSystem as xs:string external;
declare variable $category as xs:string external;
declare function local:func($category as xs:string,$MsgTranId as xs:string,$SourceSystem as xs:string,$status as xs:string,$TransactionType as xs:string,$IBMRequest as element(),$Ticket_Num as xs:string) as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
        <ns1:IncidentRequestHeader>
            <ns1:TransactionId>{$MsgTranId}</ns1:TransactionId>
            <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
            {
                if ($IBMRequest/sita/recordtype='incident') then
                    <ns1:RecType>INC</ns1:RecType>
                else()
                    
            }
            <ns1:SourceSystem>IBM</ns1:SourceSystem>
            <ns1:DestinationSystem>SN</ns1:DestinationSystem>
          
        </ns1:IncidentRequestHeader>
        
           {
        if($IBMRequest/sita/servicenowstate/text()='Update' or $IBMRequest/sita/servicenowstate/text()='Closed Complete') then
         <ns1:IncidentRequestBody>
		 <ns1:IncidentDetails>
		 <ns1:TicketNumber>{$Ticket_Num}</ns1:TicketNumber>
		               {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
			<ns1:Customer>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{fn:data($IBMRequest/sita/servicenownumber)}</ns1:RefNumber>
			</ns1:Customer>
                      else()
                      }
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                        then
			<ns1:Supplier>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{fn:data($IBMRequest/sita/servicenownumber)}</ns1:RefNumber>
			</ns1:Supplier>
                        else()
                      }
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
			<ns1:AdditionalComments>{fn:concat('IBM CI: ',$IBMRequest/sita/ci,'

',fn:data($IBMRequest/sita/servicenowdetails))}</ns1:AdditionalComments>
                        else()
                      }

		 </ns1:IncidentDetails>
       </ns1:IncidentRequestBody>
	   else
        <ns1:IncidentRequestBody>
        <ns1:IncidentDetails>
     
        <ns1:TicketNumber>{$Ticket_Num}</ns1:TicketNumber>
            {
                if ($status) then
                    <ns1:Status>{$status}</ns1:Status>
                else
                    <ns1:Status></ns1:Status>
            }
            <ns1:AssignmentGroup>SSD-SJO</ns1:AssignmentGroup>
            <ns1:Description>{fn:concat('IBM CI: ',$IBMRequest/sita/ci,'

ServiceType: 
ServiceAuthorization: 
ServicePoNumber:',' 
',fn:data($IBMRequest/sita/servicenowdetails))}</ns1:Description>
        <ns1:ShortDescription>{fn:data($IBMRequest/sita/shortdescription)}</ns1:ShortDescription>
        {
        if(fn:data($IBMRequest/sita/severity)) then
        <ns1:Priority>{fn:data($IBMRequest/sita/severity)}</ns1:Priority>
         else
          <ns1:Priority></ns1:Priority>
          }
          {
          if($category) then
        <ns1:Category>{$category}</ns1:Category>            
                else
                    <ns1:Category></ns1:Category>  
                    }
        <ns1:Customer>
        <ns1:Name>IBM</ns1:Name>
        <ns1:RefNumber>{fn:data($IBMRequest/sita/servicenownumber)}</ns1:RefNumber>
        </ns1:Customer>
        <ns1:AdditionalComments>{fn:concat('IBM CI: ',$IBMRequest/sita/ci,'

',fn:data($IBMRequest/sita/servicenowdetails))}</ns1:AdditionalComments>
        {
            if ($IBMRequest/sita/Closurecodes/text()) then
                <ns1:ResolutionCode>{$IBMRequest/sita/Closurecodes/text()}</ns1:ResolutionCode>
            else if($status='Cancelled') then 
                <ns1:ResolutionCode>Cancelled</ns1:ResolutionCode>
                else 
                
                <ns1:ResolutionCode></ns1:ResolutionCode>
        }
        <ns1:ReportMethod>Automated</ns1:ReportMethod>
        </ns1:IncidentDetails>
        <ns1:IncidentContact>
            <ns1:EmailAddress>{fn:concat('AC9:',fn:substring($IBMRequest/sita/ibmLocationid,1,3))}</ns1:EmailAddress>
           </ns1:IncidentContact>
        <ns1:IncidentAsset>
                           <ns1:CI>{fn:substring-before($IBMRequest/sita/ci,'-')}</ns1:CI>
                           <ns1:BusinessService>DESKTOP SERVICES</ns1:BusinessService>
                           </ns1:IncidentAsset>
                           
        </ns1:IncidentRequestBody>
		}
    </ns1:IncidentRequestMessage>
};

local:func($category ,$MsgTranId,$SourceSystem,$status,$TransactionType,$IBMRequest,$Ticket_Num)