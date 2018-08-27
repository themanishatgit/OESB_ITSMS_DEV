xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace typ="http://eai/Sav/Trillium/Types";
(:: import schema at "../Schemas/CISCOOutboundMessage.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)


declare variable $StatusDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($StatusDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string, 
                            $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) 
                            as element() (:: schema-element(typ:TRANSACTION) ::) {
    <typ:TRANSACTION>
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <TRANSACTION_TYPE>Creation</TRANSACTION_TYPE>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE')
          then
            <TRANSACTION_TYPE>Update</TRANSACTION_TYPE>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE')
          then
            <ID>{fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionId)}</ID>
          else()
        }
        
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <REC_TYPE>{fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:RecType)}</REC_TYPE>
          else()
        }
        
        <SR_ID>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</SR_ID>
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE' and dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'Type', '')='CUSTOMER')
          then
            <EXTERNAL_ID>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Customer/ns1:RefNumber)}</EXTERNAL_ID>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE' and dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'Type', '')='SUPPLIER')
          then
            <EXTERNAL_ID>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Supplier/ns1:RefNumber)}</EXTERNAL_ID>
          else()
        }
        
        <INTERFACE>{dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'InterfaceId', '')}</INTERFACE>
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <DESCRIPTION>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</DESCRIPTION>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <SUMMARY>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</SUMMARY>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <SEVERITY>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)}</SEVERITY>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <STATUS>{$StatusDestinationValue}</STATUS>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <CATEGORY>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Category)}</CATEGORY>
          else()
        }
        
        
        <GROUP>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AssignmentGroup)}</GROUP>
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE')
          then
            <UPDATE_INFO>
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:EmailAddress/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>AFFECTED_CONTACT</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:EmailAddress)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>SERVICE_CI</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Category/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>CATEGORY</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Category)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>SEVERITY</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>SUMMARY</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($ResolutionCodeDestinationValue)>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>RES_REMOTE</FIELD_NAME>
                        <FIELD_VALUE>{$ResolutionCodeDestinationValue}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    else()
                  
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>ETA</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ETA)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>ATA</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ATA)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AFT/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>ATD</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AFT)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TravelTime/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>TRAVEL_TIME</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TravelTime)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'Type', '')='CUSTOMER' and fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>COMMENTS</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else if(dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'Type', '')='SUPPLIER' and fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>COMMENTS</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                    
                  else()
                }
                {
                  
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TimeSpent/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>TIME_ON_SITE</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TimeSpent)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else()
                }
                
                {
                  if(fn:string-length($StatusDestinationValue)>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>STATUS</FIELD_NAME>
                        <FIELD_VALUE>{$StatusDestinationValue}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else()
                }
                
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>IMPACT</FIELD_NAME>
                        <FIELD_VALUE>{dvmtr:lookup('CISCO_INC/Resources/DVMs/OutboundImpactUrgency', 'Priority', $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text(), 'Impact', '')}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else()
                }
                
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>URGENCY</FIELD_NAME>
                        <FIELD_VALUE>{dvmtr:lookup('CISCO_INC/Resources/DVMs/OutboundImpactUrgency', 'Priority', $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text(), 'Urgency', '')}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else()
                }
                
                {
                  if(fn:string-length($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description/text())>0)then
                    <UPDATE_FIELD>
                        <FIELD_NAME>DESCRIPTION</FIELD_NAME>
                        <FIELD_VALUE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</FIELD_VALUE>
                    </UPDATE_FIELD>
                  else()
                }
                
            </UPDATE_INFO>          
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='UPDATE' and dvmtr:lookup('CISCO_INC/Resources/DVMs/SystemValues', 'SystemName', fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:DestinationSystem), 'Type', '')='CUSTOMER')
          then
            <ACT_LOG>
                <LOG_DESCRIPTION>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:AdditionalComments)}</LOG_DESCRIPTION>
            </ACT_LOG>       
          else(<ACT_LOG>
                <LOG_DESCRIPTION>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)}</LOG_DESCRIPTION>
            </ACT_LOG>       )
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <LOCATION>
                <LOCATION_NAME>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location)}</LOCATION_NAME>
                <ADDRESS_LINE_1>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[1]}</ADDRESS_LINE_1>
                <ADDRESS_LINE_2>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[2]}</ADDRESS_LINE_2>
                <ADDRESS_LINE_3>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[3]}</ADDRESS_LINE_3>
                <ADDRESS_LINE_4>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[4]}</ADDRESS_LINE_4>
                <ADDRESS_LINE_5>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[5]}</ADDRESS_LINE_5>
                <ADDRESS_LINE_6>{fn:tokenize(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street), ":")[6]}</ADDRESS_LINE_6>
                <CITY>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:City)}</CITY>
                <STATE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:State)}</STATE>
                <COUNTRY_CODE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:CountryCode)}</COUNTRY_CODE>
                <POSTAL_CODE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:PostalCode)}</POSTAL_CODE>
                <LOC_DESC>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:CustomerLOCCode)}</LOC_DESC>
            </LOCATION>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <CUSTOMER>
                <LAST_NAME>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName)}</LAST_NAME>
                <FIRST_NAME>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName)}</FIRST_NAME>
                <MIDDLE_NAME>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:MiddleName)}</MIDDLE_NAME>
                <EMAIL_ADDRESS>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:EmailAddress)}</EMAIL_ADDRESS>
                <CUSTOMER_ORG>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Company)}</CUSTOMER_ORG>
            </CUSTOMER>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <PRIMARY_CI>
                <ASSET_TAG>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)}</ASSET_TAG>
            </PRIMARY_CI>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <SECONDARY_CI>
                <ASSET_TAG>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</ASSET_TAG>
                <NODE_NAME>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:SecondaryCINodeName)}</NODE_NAME>
            </SECONDARY_CI>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <NCC>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:NCC)}</NCC>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <IMPACT>{dvmtr:lookup('CISCO_INC/Resources/DVMs/OutboundImpactUrgency', 'Priority', $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text(), 'Impact', '')}</IMPACT>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <URGENCY>{dvmtr:lookup('CISCO_INC/Resources/DVMs/OutboundImpactUrgency', 'Priority', $SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text(), 'Urgency', '')}</URGENCY>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <ID>{fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionId)}</ID>
          else()
        }
        
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <REPORT_METHOD>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ReportMethod)}</REPORT_METHOD>
          else()
        }
        
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <OPEN_DATE>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:OpenDate)}</OPEN_DATE>
          else()
        }
        {
          if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')
          then
            <TIME_STAMP>{fn:current-dateTime()}</TIME_STAMP>
          else()
        }
    </typ:TRANSACTION>
};

local:func($StatusDestinationValue,  $ResolutionCodeDestinationValue, $SNRequest)