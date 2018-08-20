xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../WSDLs/CiscoInboundIncSync.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $SourceSystem as xs:string external;
declare variable $MsgTranId as xs:string external;
declare variable $StatusDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $CauseCodeDestinationValue as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $Priority as xs:string external;
declare variable $CISCORequest as element() (:: schema-element(incidentData) ::) external;

declare function local:func($MsgTranId as xs:string,
                            $SourceSystem as xs:string,
                            $TransactionType as xs:string,
                            $StatusDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string, 
                            $CauseCodeDestinationValue as xs:string, 
                            $Priority as xs:string,
                            $CISCORequest as element() (:: schema-element(incidentData) ::)) 
                            as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
        <ns1:IncidentRequestHeader>
            <ns1:TransactionId>{$MsgTranId}</ns1:TransactionId>
            <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
            <ns1:RecType>{fn:data($CISCORequest/REC_TYPE)}</ns1:RecType>
            <ns1:SourceSystem>{$SourceSystem}</ns1:SourceSystem>
            <ns1:DestinationSystem>SN</ns1:DestinationSystem>
        </ns1:IncidentRequestHeader>
        {
            if($CISCORequest/TRANSACTION_TYPE/text()='LOGCOMMENT')then
              <ns1:IncidentRequestBody>
                <ns1:IncidentDetails>
                  <ns1:TicketNumber>{fn:data($CISCORequest/INCIDENT_NUMBER)}</ns1:TicketNumber>
                  {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
                        <ns1:Customer>
                            <ns1:Name>{$SourceSystem}</ns1:Name>
                            <ns1:RefNumber>{fn:data($CISCORequest/CUSTOMER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                        </ns1:Customer>
                      else()
                      }
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                        then
                        <ns1:Supplier>
                          <ns1:Name>{$SourceSystem}</ns1:Name>
                          <ns1:RefNumber>{fn:data($CISCORequest/SUPPLIER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                        </ns1:Supplier>
                        else()
                      }
                        {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
                        <ns1:AdditionalComments>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:AdditionalComments>
                        else()
                      }
                      
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                        then
                        <ns1:SupplierComments>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:SupplierComments>
                        else()
                      }
                </ns1:IncidentDetails>
              </ns1:IncidentRequestBody>
            else()
        }
        {
            if($CISCORequest/TRANSACTION_TYPE/text()='Error_Msg')then
              <ns1:IncidentRequestBody>
                <ns1:IncidentDetails>
                  <ns1:TicketNumber>{fn:data($CISCORequest/INCIDENT_NUMBER)}</ns1:TicketNumber>
                  <ns1:Supplier>
                     <ns1:Name>{$SourceSystem}</ns1:Name>
                     <ns1:RefNumber>{fn:data($CISCORequest/SUPPLIER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                  </ns1:Supplier>
                  {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
                        <ns1:AdditionalComments>{concat(fn:data($CISCORequest/ERROR_CODE),':',fn:data($CISCORequest/ERROR_DESCRIPTION))}</ns1:AdditionalComments>
                        else()
                      }
                      
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                        then
                        <ns1:SupplierComments>{concat(fn:data($CISCORequest/ERROR_CODE),':',fn:data($CISCORequest/ERROR_DESCRIPTION))}</ns1:SupplierComments>
                        else()
                      }
                  
                </ns1:IncidentDetails>
              </ns1:IncidentRequestBody>
            else()
        }
        {
            if($CISCORequest/TRANSACTION_TYPE/text()='Creation' or $CISCORequest/TRANSACTION_TYPE/text()='UPDATEINCIDENTSTATUS' or $CISCORequest/TRANSACTION_TYPE/text()='ASSIGNREFNUM')then
              <ns1:IncidentRequestBody>
                  <ns1:IncidentDetails>
                      
                        <ns1:TicketNumber>{fn:data($CISCORequest/INCIDENT_NUMBER)}</ns1:TicketNumber>
                        <ns1:Status>{$StatusDestinationValue}</ns1:Status>
                        <ns1:AssignmentGroup>{$CISCORequest/GROUP/text()}</ns1:AssignmentGroup>
                        <ns1:Description>{fn:data($CISCORequest/DESCRIPTION)}</ns1:Description>
                        <ns1:ShortDescription>{fn:data($CISCORequest/SUMMARY)}</ns1:ShortDescription>
                      
                        <ns1:Priority>{$Priority}</ns1:Priority>
                        <ns1:Category>{fn:data($CISCORequest/INCIDENT_CATEGORY)}</ns1:Category>
                      
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER')
                        then
                        <ns1:Customer>
                            <ns1:Name>{$SourceSystem}</ns1:Name>
                            <ns1:RefNumber>{fn:data($CISCORequest/CUSTOMER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                        </ns1:Customer>
                      else()
                      }
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER')
                        then
                        <ns1:Supplier>
                          <ns1:Name>{$SourceSystem}</ns1:Name>
                          <ns1:RefNumber>{fn:data($CISCORequest/SUPPLIER_EXTERNAL_REFERENCE)}</ns1:RefNumber>
                        </ns1:Supplier>
                        else()
                      }
                        <ns1:ETA>{fn:data($CISCORequest/ESTIMATED_ARRIVAL_TIME)}</ns1:ETA>
                        <ns1:ATA>{fn:data($CISCORequest/ACTUAL_TECH_ARRIVAL)}</ns1:ATA>
                        <ns1:AFT>{fn:data($CISCORequest/ACTUAL_FIX_TIME)}</ns1:AFT>
                        
                        
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='CUSTOMER' and fn:data($CISCORequest/ACTLOG_DESC)!='')
                        then
                        <ns1:AdditionalComments>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:AdditionalComments>
                        else(<ns1:AdditionalComments>{fn:data($CISCORequest/COMMENTS)}</ns1:AdditionalComments>)
                      }
                      
                      {
                        if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', $SourceSystem, 'Type', '')='SUPPLIER' and fn:data($CISCORequest/ACTLOG_DESC)!='')
                        then
                        <ns1:SupplierComments>{fn:data($CISCORequest/ACTLOG_DESC)}</ns1:SupplierComments>
                        else(<ns1:SupplierComments>{fn:data($CISCORequest/COMMENTS)}</ns1:SupplierComments>)
                      }
                      
                        <ns1:TimeSpent>{fn:data($CISCORequest/TIME_SPENT)}</ns1:TimeSpent>
                        <ns1:TravelTime>{fn:data($CISCORequest/TRAVEL_TIME)}</ns1:TravelTime>
                        <ns1:ResolutionCode>{$ResolutionCodeDestinationValue}</ns1:ResolutionCode>
                        <ns1:ReportMethod>{fn:data($CISCORequest/REPORT_METHOD)}</ns1:ReportMethod>
                      
                  </ns1:IncidentDetails>
                    
                      <ns1:IncidentContact>
                          <ns1:EmailAddress>{fn:data($CISCORequest/AFFECTED_CONTACT)}</ns1:EmailAddress>
                      </ns1:IncidentContact>
                      
                      <ns1:IncidentAsset>
                          <ns1:CI>{fn:data($CISCORequest/HARDWARE_CI)}</ns1:CI>
                          <ns1:BusinessService>{fn:data($CISCORequest/SERVICE_CI)}</ns1:BusinessService>
                      </ns1:IncidentAsset>
                     
                  <ns1:IncidentLocation>
                      <ns1:Issue>{$CauseCodeDestinationValue}</ns1:Issue>
                  </ns1:IncidentLocation>
              </ns1:IncidentRequestBody>
            else()
        }
        
        
    </ns1:IncidentRequestMessage>
};

local:func($MsgTranId,$SourceSystem,$TransactionType, $StatusDestinationValue,$ResolutionCodeDestinationValue,$CauseCodeDestinationValue,$Priority,$CISCORequest)