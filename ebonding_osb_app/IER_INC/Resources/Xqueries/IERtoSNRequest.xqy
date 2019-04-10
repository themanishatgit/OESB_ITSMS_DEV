xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../WSDL/IERInboundIncSyncPS.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)



declare variable $SourceSystem as xs:string external;
declare variable $MsgTranId as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $ResolutionCode as xs:string external;
declare variable $Priorities as element(*) external;
declare variable $Request as element(*) external;

declare function local:func($MsgTranId as xs:string,$ResolutionCode as xs:string, $Priorities as element(*), $SourceSystem as xs:string, $TransactionType as xs:string,
$Request as element(*) ) as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
    <ns1:IncidentRequestHeader>
		<ns1:TransactionId>{$MsgTranId}</ns1:TransactionId>
		<ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
		<ns1:RecType>INC</ns1:RecType>
		<ns1:SourceSystem>{$SourceSystem}</ns1:SourceSystem>
		<ns1:DestinationSystem>SN</ns1:DestinationSystem>
	</ns1:IncidentRequestHeader>
        {
          
      if
        (($Request/CallStates.Name/text() = 'General' )
         or ($Request/CallStates.Name/text() = 'Error')
        or fn:data(fn:string-length($Request/CallStates.Name/text())<0)
      )then
 
        
    <ns1:IncidentRequestBody>
        <ns1:IncidentDetails>
            <ns1:TicketNumber>{fn:data($Request/CallData/Calls.SPCallID)}</ns1:TicketNumber>      
             <ns1:Supplier>
                   <ns1:Name>{$SourceSystem}</ns1:Name>
                   <ns1:RefNumber>{fn:data($Request/CallData/Calls.CustCallID)}</ns1:RefNumber>
         </ns1:Supplier>        
      
            <ns1:SupplierComments>{fn:data($Request/CallData/Calls.Remarks)}</ns1:SupplierComments>           
          
        </ns1:IncidentDetails>
       
      </ns1:IncidentRequestBody>
      else()
        }
        {
        if ($TransactionType='UPDATE') then
         <ns1:IncidentRequestBody>
        <ns1:IncidentDetails>
            <ns1:TicketNumber>{fn:data($Request/CallData/Calls.SPCallID)}</ns1:TicketNumber>
            <ns1:Status>{fn:data($Request/CallData/Calls.CallerRoom)}</ns1:Status>
              <ns1:AssignmentGroup></ns1:AssignmentGroup>
            { if(fn:data($Request/CallData/Calls.Description[1])) then
                  <ns1:Description>{fn:data($Request/CallData/Calls.Description)}</ns1:Description> 
                  else()
            }
            
            {
             if (fn:data($Request/CallData/Calls.ShortDescription)) then
              <ns1:ShortDescription>{fn:data($Request/CallData/Calls.ShortDescription)}</ns1:ShortDescription>
             else()            
            }            
            {
            if (fn:data($Request/CallData/Severities.Name)) then
               <ns1:Priority>{fn:data($Priorities/Inbound/Priority[IER=fn:data($Request/CallData/Severities.Name)]/SN)}</ns1:Priority>  
            else
             <ns1:Priority>{fn:data($Priorities/Inbound/Priority[IER='Default']/SN)}</ns1:Priority>  
            }
            
              <ns1:Category></ns1:Category>        
               <ns1:Supplier>
                   <ns1:Name>{$SourceSystem}</ns1:Name>
                   <ns1:RefNumber>{fn:data($Request/CallData/Calls.CustCallID)}</ns1:RefNumber>
            </ns1:Supplier>
            <ns1:ETA>{fn:data($Request/CallData/ExtTableValues.Field3)}</ns1:ETA>
            <ns1:ATA>{fn:data($Request/CallData/ExtTableValues.Field1)}</ns1:ATA>
            <ns1:AFT>{fn:data($Request/CallData/ExtTableValues.Field2)}</ns1:AFT>
            <ns1:SupplierComments>{fn:data($Request/CallData/Calls.Remarks)}</ns1:SupplierComments>
              <ns1:TimeSpent></ns1:TimeSpent>
            <ns1:TravelTime></ns1:TravelTime>
	
			<ns1:ResolutionCode>{$ResolutionCode}</ns1:ResolutionCode>
			
			<ns1:ReportMethod></ns1:ReportMethod>
        </ns1:IncidentDetails>
         <ns1:IncidentContact>
                      <ns1:EmailAddress></ns1:EmailAddress>
            <ns1:PhoneNumber></ns1:PhoneNumber>
        </ns1:IncidentContact>
        <ns1:IncidentAsset>
            <ns1:CI></ns1:CI>           
            <ns1:BusinessService>{fn:data($Request/CallData/Calls.MainCompName)}</ns1:BusinessService>       
        </ns1:IncidentAsset>
        
      </ns1:IncidentRequestBody>
        else()
        
        }
        
        
        
        
         </ns1:IncidentRequestMessage>
};

local:func($MsgTranId,$ResolutionCode,$Priorities,$SourceSystem,$TransactionType,$Request)