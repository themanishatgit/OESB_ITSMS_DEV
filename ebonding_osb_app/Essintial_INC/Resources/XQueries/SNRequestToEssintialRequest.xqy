xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://net4.essintial.com";
(:: import schema at "../WSDLs/BasicEssintialService.wsdl" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare namespace sit = "http://net4.essintial.com/SitaTicket_1.xsd";

declare variable $StatusDestinationValue as xs:string external;
declare variable $ResolutionCodeDestinationValue as xs:string external;
declare variable $ExternalRefNum as xs:string external;
declare variable $ReopenFlag as xs:string external;
declare variable $MapData as element() external;
declare variable $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::) external;

declare function local:func($StatusDestinationValue as xs:string, 
                            $ResolutionCodeDestinationValue as xs:string,
                            $ExternalRefNum as xs:string,
                            $ReopenFlag as xs:string,
                            $MapData as element(), 
                            $SNRequest as element() (:: schema-element(ns1:IncidentRequestMessage) ::)) as element() (:: schema-element(ns2:HandleTicket) ::) {
    <ns2:HandleTicket>
    {
    if($ReopenFlag="Y")then
    
    let $InitialCreateRequest := fn-bea:inlinedXML(fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('PAYLOAD'),'SELECT PAYLOAD FROM EBONDINGS_TRANSACTIONS where TICKET_NUM=? and IS_FIRST_REFNUM=?',fn:string($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber/text()),'Y')//text())
    return
       <ns2:serviceTicket sit:Version="1" sit:AcknowledgementNumber="{fn:substring(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber), 3)}" sit:PreviousVORDID="{fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('EXTERNAL_REFNUM'),'SELECT EXTERNAL_REFNUM FROM EBONDINGS_TRANSACTIONS where TICKET_NUM=? ORDER BY UPDATE_TIME DESC OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY',fn:string($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber/text()))//text()}">
           <sit:LocationCode>{fn:substring(fn:concat(fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location),' ',fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)),0,50)}</sit:LocationCode>
            <sit:EndUserOrganization>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Company)}</sit:EndUserOrganization>
            <sit:AddressDetails>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)}</sit:AddressDetails>
            <sit:AddressCity>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:City)}</sit:AddressCity>
            <sit:AddressState>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:State)}</sit:AddressState>
            <sit:AddressZip>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:PostalCode)}</sit:AddressZip>
            <sit:AddressCountry>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:CountryCode)}</sit:AddressCountry>
            {
                if ($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)
                then <sit:ServiceGroup>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)}</sit:ServiceGroup>
                else ()
            }
            <sit:Priority>{fn:data($MapData/Priorities/Priority[SN=$InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text()]/Essintial)}</sit:Priority>
            <sit:CustomerReference4>{fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:RecType)}</sit:CustomerReference4>
            <sit:CustomerReference3>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</sit:CustomerReference3>
            <sit:VORDID></sit:VORDID>
            <sit:Comments>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</sit:Comments>
            <sit:CustomerReference2>{fn:data($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</sit:CustomerReference2>
            <sit:StatusCode>Open</sit:StatusCode>
            <sit:ReceivedMethod>{fn:data($MapData/ReceivedMethod)}</sit:ReceivedMethod>
            <sit:CustomerReceivedDate>{fn:data($MapData/CustomerReceivedDate)}</sit:CustomerReceivedDate>
            <sit:ScheduledDS>{fn:data($MapData/ScheduledDS)}</sit:ScheduledDS>
            <sit:TechOnSite>{fn:data($MapData/TechOnSite)}</sit:TechOnSite>
            <sit:TechCheckedOut>{fn:data($MapData/TechCheckedOut)}</sit:TechCheckedOut>
            <sit:TotalLaborTime>{fn:data($MapData/TotalLaborTime)}</sit:TotalLaborTime>
            <sit:TotalTravelTime>{fn:data($MapData/TotalTravelTime)}</sit:TotalTravelTime>
            <sit:FinalAction></sit:FinalAction>
            <sit:CustomerName>{fn:concat($InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName,' ',$InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:MiddleName,' ',$InitialCreateRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName)}</sit:CustomerName>
            <sit:Notes>{fn:concat("Ticket is back on Essintial side. ",fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments))}</sit:Notes>
        </ns2:serviceTicket>
        
        else
        
        <ns2:serviceTicket sit:Version="1" sit:AcknowledgementNumber="{fn:substring(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber), 3)}" sit:PreviousVORDID="{fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('EXTERNAL_REFNUM'),'SELECT EXTERNAL_REFNUM FROM EBONDINGS_TRANSACTIONS where TICKET_NUM=? ORDER BY UPDATE_TIME DESC OFFSET 1 ROWS FETCH FIRST 1 ROWS ONLY',fn:string($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber/text()))//text()}">
           <sit:LocationCode>{fn:substring(fn:concat(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Location),' ',fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)),0,50)}</sit:LocationCode>
            <sit:EndUserOrganization>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Company)}</sit:EndUserOrganization>
            <sit:AddressDetails>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:Street)}</sit:AddressDetails>
            <sit:AddressCity>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:City)}</sit:AddressCity>
            <sit:AddressState>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:State)}</sit:AddressState>
            <sit:AddressZip>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:PostalCode)}</sit:AddressZip>
            <sit:AddressCountry>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentLocation/ns1:CountryCode)}</sit:AddressCountry>
            {
                if ($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)
                then <sit:ServiceGroup>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:BusinessService)}</sit:ServiceGroup>
                else ()
            }
            <sit:Priority>{fn:data($MapData/Priorities/Priority[SN=$SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Priority/text()]/Essintial)}</sit:Priority>
            <sit:CustomerReference4>{fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:RecType)}</sit:CustomerReference4>
            <sit:CustomerReference3>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:TicketNumber)}</sit:CustomerReference3>
            {
            if($ExternalRefNum)then
            <sit:VORDID>{$ExternalRefNum}</sit:VORDID>
            else
            <sit:VORDID></sit:VORDID>
            }
            <sit:Comments>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ShortDescription)}</sit:Comments>
            <sit:CustomerReference2>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentAsset/ns1:CI)}</sit:CustomerReference2>
            {
            if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')then
            <sit:StatusCode>Open</sit:StatusCode>
            else
            <sit:StatusCode>{$StatusDestinationValue}</sit:StatusCode>
            }
            <sit:ReceivedMethod>{fn:data($MapData/ReceivedMethod)}</sit:ReceivedMethod>
            <sit:CustomerReceivedDate>{fn:data($MapData/CustomerReceivedDate)}</sit:CustomerReceivedDate>
            <sit:ScheduledDS>{fn:data($MapData/ScheduledDS)}</sit:ScheduledDS>
            <sit:TechOnSite>{fn:data($MapData/TechOnSite)}</sit:TechOnSite>
            <sit:TechCheckedOut>{fn:data($MapData/TechCheckedOut)}</sit:TechCheckedOut>
            <sit:TotalLaborTime>{fn:data($MapData/TotalLaborTime)}</sit:TotalLaborTime>
            <sit:TotalTravelTime>{fn:data($MapData/TotalTravelTime)}</sit:TotalTravelTime>
            {
            if(fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionCode/text()))then
            <sit:FinalAction>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:ResolutionCode/text())}</sit:FinalAction>
            else
            <sit:FinalAction></sit:FinalAction>
            }
            <sit:CustomerName>{fn:concat($SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:FirstName,' ',$SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:MiddleName,' ',$SNRequest/ns1:IncidentRequestBody/ns1:IncidentContact/ns1:LastName)}</sit:CustomerName>
           {
            if(fn:data($SNRequest/ns1:IncidentRequestHeader/ns1:TransactionType)='CREATE')then
            <sit:Notes>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:Description)}</sit:Notes>
            else
            <sit:Notes>{fn:data($SNRequest/ns1:IncidentRequestBody/ns1:IncidentDetails/ns1:SupplierComments)}</sit:Notes>
            }
        </ns2:serviceTicket>
}
    </ns2:HandleTicket>
};

local:func($StatusDestinationValue, $ResolutionCodeDestinationValue,$ExternalRefNum,$ReopenFlag,$MapData, $SNRequest)