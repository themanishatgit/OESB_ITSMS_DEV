xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../WSDLs/ServiceTecInboundIncSync.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SourceSystem as xs:string external;
declare variable $MsgTranId as xs:string external;
declare variable $StatusDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $SERVICETECRequest as element() (:: schema-element(CALL) ::) external;

declare function local:func($MsgTranId as xs:string,
                            $SourceSystem as xs:string,
                            $TransactionType as xs:string,
                            $StatusDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string,
                            $SERVICETECRequest as element() (:: schema-element(CALL) ::)) 
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
            if($SERVICETECRequest/CallStates.Name/text()='Update' or $SERVICETECRequest/CallStates.Name/text()='Partner and Customer' or $SERVICETECRequest/CallStates.Name/text()='CustomerOK')then
	<ns1:IncidentRequestBody>
		<ns1:IncidentDetails>
			<ns1:TicketNumber>{fn:data($SERVICETECRequest/Calls.SPCallID)}</ns1:TicketNumber>
			<ns1:Supplier>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{fn:data($SERVICETECRequest/Calls.CustCallID)}</ns1:RefNumber>
			</ns1:Supplier>
                      {
                        
                        let $nl := "&#10;"
                        return
			
                   if(fn:data($SERVICETECRequest/Calls.Remarks/text()) !='')then
                    (if($SERVICETECRequest/Calls.CallAcknowlegeTime/text() !='')then
                      <ns1:SupplierComments>{ fn:concat($SERVICETECRequest/Calls.Remarks/text(),'. ',$nl,'TIME SPENT: ',$SERVICETECRequest/Calls.CallAcknowlegeTime/text()) }</ns1:SupplierComments>	
                      else
                      <ns1:SupplierComments>{ fn:data($SERVICETECRequest/Calls.Remarks/text()) }</ns1:SupplierComments>
                      )
                      else
                    <ns1:SupplierComments>{ fn:data($SERVICETECRequest/Calls.Remarks) }</ns1:SupplierComments>
                    }
                      
		</ns1:IncidentDetails>
	</ns1:IncidentRequestBody>
            
        else
            
          <ns1:IncidentRequestBody>
		<ns1:IncidentDetails>

			<ns1:TicketNumber>{fn:data($SERVICETECRequest/Calls.SPCallID)}</ns1:TicketNumber>
			{
                        if($StatusDestinationValue)then
                        <ns1:Status>{$StatusDestinationValue}</ns1:Status>
                        else()
                        }{
                        if(fn:data($SERVICETECRequest/Calls.ShortDescription))then
                        <ns1:ShortDescription>{fn:data($SERVICETECRequest/Calls.ShortDescription)}</ns1:ShortDescription>
                        else()
                        }{
                        if(fn:data($SERVICETECRequest/Severities.Name))then
                        <ns1:Priority>{fn:data($SERVICETECRequest/Severities.Name)}</ns1:Priority>
                        else()}
			
			

			<ns1:Supplier>
				<ns1:Name>{$SourceSystem}</ns1:Name>
				<ns1:RefNumber>{fn:data($SERVICETECRequest/Calls.CustCallID)}</ns1:RefNumber>
			</ns1:Supplier>

                      {
                        
                        let $nl := "&#10;"
                        return
			
                   if(fn:data($SERVICETECRequest/Calls.Remarks/text()) !='')then
                    (if($SERVICETECRequest/Calls.CallAcknowlegeTime/text() !='')then
                      <ns1:SupplierComments>{ fn:concat($SERVICETECRequest/Calls.Remarks/text(),$nl,'TIME SPENT: ',$SERVICETECRequest/Calls.CallAcknowlegeTime/text()) }</ns1:SupplierComments>	
                      else
                      <ns1:SupplierComments>{ fn:data($SERVICETECRequest/Calls.Remarks/text()) }</ns1:SupplierComments>
                      )
                      else
                    <ns1:SupplierComments>{ fn:data($SERVICETECRequest/Calls.Remarks) }</ns1:SupplierComments>
                    }

                        {if(fn:data($SERVICETECRequest/Calls.CallAcknowlegeTime))then
                        <ns1:TimeSpent>{fn:data($SERVICETECRequest/Calls.CallAcknowlegeTime)}</ns1:TimeSpent>
                        else()
                        }{
                        if(fn:data($SERVICETECRequest/Calls.CustomerRequestedStartTime))then
                        <ns1:TravelTime>{fn:data($SERVICETECRequest/Calls.CustomerRequestedStartTime)}</ns1:TravelTime>
                        else()
                        }{
                        if($ResolutionCodeDestinationValue)then
                        <ns1:ResolutionCode>{$ResolutionCodeDestinationValue}</ns1:ResolutionCode>
                        else()
                        }{
                        if(fn:data($SERVICETECRequest/Calls.Diagnosis))then
                        <ns1:ReportMethod>{fn:data($SERVICETECRequest/Calls.Diagnosis)}</ns1:ReportMethod>
                        else()
                        }
		</ns1:IncidentDetails>



		<ns1:IncidentAsset>
                        {
                        if(fn:data($SERVICETECRequest/Calls.SubCompName))then
			<ns1:CI>{fn:data($SERVICETECRequest/Calls.SubCompName)}</ns1:CI>
                        else ()
                        }
		</ns1:IncidentAsset>

	</ns1:IncidentRequestBody>
        
        }


</ns1:IncidentRequestMessage>
};

local:func($MsgTranId,$SourceSystem,$TransactionType, $StatusDestinationValue,$ResolutionCodeDestinationValue,$SERVICETECRequest)