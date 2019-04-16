xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://net4.essintial.com/SitaTicket_1.xsd";
(:: import schema at "../WSDLs/EssintialInboundIncSync.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SourceSystem as xs:string external;
declare variable $ExtRefNumber as xs:string external;
declare variable $MsgTranId as xs:string external;
declare variable $StatusDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $ESSINTIALRequest as element() (:: schema-element(ns2:ServiceTicket) ::) external;

declare function local:func($MsgTranId as xs:string,
                            $SourceSystem as xs:string,
                            $ExtRefNumber as xs:string,
                            $TransactionType as xs:string,
                            $StatusDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string,
                            $ESSINTIALRequest as element() (:: schema-element(ns2:ServiceTicket) ::)) 
                            as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
<ns1:IncidentRequestMessage>
	<ns1:IncidentRequestHeader>
		<ns1:TransactionId>{$MsgTranId}</ns1:TransactionId>
                <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
		<ns1:RecType>INC</ns1:RecType>
		<ns1:SourceSystem>{$SourceSystem}</ns1:SourceSystem>
		<ns1:DestinationSystem>SN</ns1:DestinationSystem>
	</ns1:IncidentRequestHeader>
        {
            if($ESSINTIALRequest/ns2:StatusCode/text()='Update' or $ESSINTIALRequest/ns2:StatusCode/text()='Partner and Customer' or $ESSINTIALRequest/ns2:StatusCode/text()='CustomerOK')then
	<ns1:IncidentRequestBody>
		<ns1:IncidentDetails>
			<ns1:TicketNumber>{fn:data($ESSINTIALRequest/ns2:CustomerReference3)}</ns1:TicketNumber>
			<ns1:Supplier>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{$ExtRefNumber}</ns1:RefNumber>
			</ns1:Supplier>
                      {
                        
                        let $nl := "&#10;"
                        return
			
                   if(fn:data($ESSINTIALRequest/ns2:Notes/text()) !='')then
                    (if($ESSINTIALRequest/ns2:TotalLaborTime/text() !='')then
                      <ns1:SupplierComments>{ fn:concat($ESSINTIALRequest/ns2:Notes/text(),'. ',$nl,'TIME SPENT: ',$ESSINTIALRequest/ns2:TotalLaborTime/text()) }</ns1:SupplierComments>	
                      else
                      <ns1:SupplierComments>{ fn:data($ESSINTIALRequest/ns2:Notes/text()) }</ns1:SupplierComments>
                      )
                      else
                    <ns1:SupplierComments>{ fn:data($ESSINTIALRequest/ns2:Notes) }</ns1:SupplierComments>
                    }
                      
		</ns1:IncidentDetails>
	</ns1:IncidentRequestBody>
            
        else
            
          <ns1:IncidentRequestBody>
		<ns1:IncidentDetails>

			<ns1:TicketNumber>{fn:data($ESSINTIALRequest/ns2:CustomerReference3)}</ns1:TicketNumber>
			{
                        if($StatusDestinationValue)then
                        <ns1:Status>{$StatusDestinationValue}</ns1:Status>
                        else()
                        }{
                        if(fn:data($ESSINTIALRequest/ns2:Comments))then
                        <ns1:ShortDescription>{fn:data($ESSINTIALRequest/ns2:Comments)}</ns1:ShortDescription>
                        else()
                        }{
                        if(fn:data($ESSINTIALRequest/ns2:Priority))then
                        <ns1:Priority>{fn:data($ESSINTIALRequest/ns2:Priority)}</ns1:Priority>
                        else()}
			
			

			<ns1:Supplier>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{$ExtRefNumber}</ns1:RefNumber>
			</ns1:Supplier>

                      {
                      if($ESSINTIALRequest/ns2:ScheduledDS/text() != '0001-01-01T00:00:00')then
                      <ns1:ETA>{fn:data($ESSINTIALRequest/ns2:ScheduledDS)}</ns1:ETA>
                      else ()
                      }{
                      if($ESSINTIALRequest/ns2:TechOnSite/text() != '0001-01-01T00:00:00')then
                      <ns1:ATA>{fn:data($ESSINTIALRequest/ns2:TechOnSite)}</ns1:ATA>
                      else ()
                      }{
                      if($ESSINTIALRequest/ns2:TechCheckedOut/text() != '0001-01-01T00:00:00')then
                      <ns1:AFT>{fn:data($ESSINTIALRequest/ns2:TechCheckedOut)}</ns1:AFT>
                      else ()
                      }
                   {
                        
                        let $nl := "&#10;"
                        return
			
                   if(fn:data($ESSINTIALRequest/ns2:Notes/text()) !='')then
                    (if($ESSINTIALRequest/ns2:TotalLaborTime/text() !='')then
                      <ns1:SupplierComments>{ fn:concat($ESSINTIALRequest/ns2:Notes/text(),$nl,'TIME SPENT: ',$ESSINTIALRequest/ns2:TotalLaborTime/text()) }</ns1:SupplierComments>	
                      else
                      <ns1:SupplierComments>{ fn:data($ESSINTIALRequest/ns2:Notes/text()) }</ns1:SupplierComments>
                      )
                      else
                    <ns1:SupplierComments>{ fn:data($ESSINTIALRequest/ns2:Notes) }</ns1:SupplierComments>
                    }

                        {if(fn:data($ESSINTIALRequest/ns2:TotalLaborTime))then
                        <ns1:TimeSpent>{fn:data($ESSINTIALRequest/ns2:TotalLaborTime)}</ns1:TimeSpent>
                        else()
                        }{
                        if(fn:data($ESSINTIALRequest/ns2:TotalTravelTime))then
                        <ns1:TravelTime>{fn:data($ESSINTIALRequest/ns2:TotalTravelTime)}</ns1:TravelTime>
                        else()
                        }{
                        if($ResolutionCodeDestinationValue)then
                        <ns1:ResolutionCode>{$ResolutionCodeDestinationValue}</ns1:ResolutionCode>
                        else()
                        }{
                        if(fn:data($ESSINTIALRequest/ns2:ReceivedMethod))then
                        <ns1:ReportMethod>{fn:data($ESSINTIALRequest/ns2:ReceivedMethod)}</ns1:ReportMethod>
                        else()
                        }
		</ns1:IncidentDetails>



		<ns1:IncidentAsset>
                        {
                        if(fn:data($ESSINTIALRequest/ns2:CustomerReference2))then
			<ns1:CI>{fn:data($ESSINTIALRequest/ns2:CustomerReference2)}</ns1:CI>
                        else ()
                        }
		</ns1:IncidentAsset>

	</ns1:IncidentRequestBody>
        
        }


</ns1:IncidentRequestMessage>
};

local:func($MsgTranId,$SourceSystem,$ExtRefNumber,$TransactionType, $StatusDestinationValue,$ResolutionCodeDestinationValue,$ESSINTIALRequest)