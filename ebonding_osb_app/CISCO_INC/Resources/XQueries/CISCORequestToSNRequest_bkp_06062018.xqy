xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../WSDLs/CiscoInboundIncSync.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SourceSystem as xs:string external;
declare variable $Impact as xs:string external;
declare variable $Urgency as xs:string external;
declare variable $StatusDestinationValue as xs:string external;
declare variable $GroupDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $CauseCodeDestinationValue as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $CISCORequest as element() (:: schema-element(incidentData) ::) external;

declare function local:func($SourceSystem as xs:string,
                            $TransactionType as xs:string,
                            $Impact as xs:string, 
                            $Urgency as xs:string, 
                            $StatusDestinationValue as xs:string, 
                            $GroupDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string, 
                            $CauseCodeDestinationValue as xs:string, 
                            $CISCORequest as element() (:: schema-element(incidentData) ::)) 
                            as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
        <ns1:IncidentRequestHeader>
            <ns1:TransactionId>{fn-bea:uuid()}</ns1:TransactionId>
            <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
            <ns1:RecType>{fn:data($CISCORequest/REC_TYPE)}</ns1:RecType>
            <ns1:SourceSystem>{$SourceSystem}</ns1:SourceSystem>
            <ns1:DestinationSystem>SN</ns1:DestinationSystem>
        </ns1:IncidentRequestHeader>
        <ns1:IncidentRequestBody>
            <ns1:IncidentDetails>
                {
                  if($TransactionType='UPDATE_REFNUMBER' or $TransactionType='UPDATE')
                  then
                  <ns1:TicketNumber>{fn:data($CISCORequest/INCIDENT_NUMBER)}</ns1:TicketNumber>
                  else()
                }
                {
                  if($TransactionType='CREATE' or $TransactionType='UPDATE')
                  then
                    <ns1:Status>{$StatusDestinationValue}</ns1:Status>
                  else()
                }
                <ns1:AssignmentGroup>{$GroupDestinationValue}</ns1:AssignmentGroup>
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:Description>{fn:data($CISCORequest/DESCRIPTION)}</ns1:Description>
                  else()
                }
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:ShortDescription>{fn:data($CISCORequest/SUMMARY)}</ns1:ShortDescription>
                  else()
                }
                {
                  if($TransactionType='CREATE' or $TransactionType='UPDATE')
                  then
                  <ns1:Priority>{fn:data($CISCORequest/PRIORITY)}</ns1:Priority>
                  else()
                }
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:Category>{fn:data($CISCORequest/INCIDENT_CATEGORY)}</ns1:Category>
                  else()
                }
                
                
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:Impact>{$Impact}</ns1:Impact>
                  else()
                }
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:Urgency>{$Urgency}</ns1:Urgency>
                  else()
                }
                <ns1:Customer>
                    <ns1:Name>{$SourceSystem}</ns1:Name>
                    <ns1:RefNumber>{fn:data($CISCORequest/CUSTOMER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                </ns1:Customer>
                {
                  if($TransactionType='UPDATE_REFNUMBER' or $TransactionType='UPDATE')
                  then
                  <ns1:Supplier>
                    <ns1:Name>{$SourceSystem}</ns1:Name>
                    <ns1:RefNumber>{fn:data($CISCORequest/SUPPLIER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                  </ns1:Supplier>
                  else()
                }
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:ETA>{fn:data($CISCORequest/ESTIMATED_ARRIVAL_TIME)}</ns1:ETA>
                  else()
                }
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:ATA>{fn:data($CISCORequest/ACTUAL_TECH_ARRIVAL)}</ns1:ATA>
                  else()
                }
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:AFT>{fn:data($CISCORequest/ACTUAL_FIX_TIME)}</ns1:AFT>
                  else()
                }
                {
                  if($TransactionType='CREATE')
                  then
                  <ns1:AdditionalComments>{fn:data($CISCORequest/COMMENTS)}</ns1:AdditionalComments>
                  else()
                }
                {
                  if($TransactionType='UPDATE' and dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues.dvm', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                  then
                  <ns1:AdditionalComments>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:AdditionalComments>
                  else()
                }
                {
                  if($TransactionType='UPDATE' and dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues.dvm', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                  then
                  <ns1:WorkNotes>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:WorkNotes>
                  else()
                }
                
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:TimeSpent>{fn:data($CISCORequest/TIME_SPENT)}</ns1:TimeSpent>
                  else()
                }
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:TravelTime>{fn:data($CISCORequest/TRAVEL_TIME)}</ns1:TravelTime>
                  else()
                }
                {
                  if($TransactionType='UPDATE')
                  then
                  <ns1:ResolutionCode>{$ResolutionCodeDestinationValue}</ns1:ResolutionCode>
                  else()
                }
            </ns1:IncidentDetails>
              {
                if($TransactionType='CREATE')
                then
                <ns1:IncidentContact>
                    <ns1:EmailAddress>{fn:data($CISCORequest/AFFECTED_CONTACT)}</ns1:EmailAddress>
                </ns1:IncidentContact>
                else()
              }
              {
                if($TransactionType='CREATE')
                then
                <ns1:IncidentAsset>
                    <ns1:CI>{fn:data($CISCORequest/HARDWARE_CI)}</ns1:CI>
                    <ns1:BusinessService>{fn:data($CISCORequest/SERVICE_CI)}</ns1:BusinessService>
                </ns1:IncidentAsset>
                else()
              }
            <ns1:IncidentLocation>
            </ns1:IncidentLocation>
        </ns1:IncidentRequestBody>
    </ns1:IncidentRequestMessage>
};

local:func($SourceSystem,$TransactionType,$Impact, $Urgency, $StatusDestinationValue,$GroupDestinationValue,$ResolutionCodeDestinationValue,$CauseCodeDestinationValue,$CISCORequest)