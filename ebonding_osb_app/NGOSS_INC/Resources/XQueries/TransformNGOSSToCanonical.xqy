xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../Schemas/NGOSSInboundMessage.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $IncidentXML as element() (:: schema-element(IncidentXML) ::) external;
declare variable $TransactionType as xs:string external;
declare variable $Message_TranId as xs:string external;
declare variable $TicketNumber as xs:string external;
declare variable $ExtRefNumber as xs:string external;
declare variable $ResolvedValues as element(*) external;
declare variable $DefaultValues as element(*) external;

declare function local:func($IncidentXML as element() (:: schema-element(IncidentXML) ::),
                            $TransactionType as xs:string,
                            $Message_TranId as xs:string,
                            $TicketNumber as xs:string,
                            $ExtRefNumber as xs:string,
                            $ResolvedValues as element(*),
                            $DefaultValues as element(*)) as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
        <ns1:IncidentRequestHeader>
              <ns1:TransactionId>{$Message_TranId}</ns1:TransactionId>
              <ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
              <ns1:RecType>INC</ns1:RecType>
              <ns1:SourceSystem>NGOSS</ns1:SourceSystem>
              <ns1:DestinationSystem>SN</ns1:DestinationSystem>
        </ns1:IncidentRequestHeader>
        <ns1:IncidentRequestBody>
              <ns1:IncidentDetails>
                    {
                    if($TransactionType='CREATE')
                    then()
                    else(<ns1:TicketNumber>{$TicketNumber}</ns1:TicketNumber>)
                    }
                  <ns1:AssignmentGroup>{
                    if(fn:data($IncidentXML/sitaTrilliumGroup))
                    then(fn:data($IncidentXML/sitaTrilliumGroup))
                    else($DefaultValues/Group/text())
                    }</ns1:AssignmentGroup>
                    <ns1:Description>{fn:concat($IncidentXML/IncidentDescription/text(),'. Hardware CI Location : ',$IncidentXML/SiteReference/text())}</ns1:Description>
                    <ns1:ShortDescription>{fn:substring($IncidentXML/IncidentDescription/text(),1,160)}</ns1:ShortDescription>
                    <ns1:Priority>{
                     if($ResolvedValues/Priority/text()) 
                    then($ResolvedValues/Priority/text()) 
                      else($DefaultValues/Priority/text())
                     }</ns1:Priority>
                    <ns1:Category>{
                    if($ResolvedValues/Category/text())
                    then($ResolvedValues/Category/text())
                    else($DefaultValues/Category/text())
                    }</ns1:Category>
                    <ns1:Customer>
                          <ns1:Name>NGOSS</ns1:Name>
                          <ns1:RefNumber>{$IncidentXML/EventID/text()}</ns1:RefNumber>
                    </ns1:Customer>
                     <ns1:WorkNotes>{fn:concat($IncidentXML/EventLogComment/text(),$IncidentXML/TimeLogComment/text(),
                    if($IncidentXML/Active/text()='True')
                    then('The NGOSS/SMARTS Event is Active on the Affected Device/CI.')
                    else('The NGOSS/SMARTS Event has Cleared on the Affected Device/CI.'),
                    if($IncidentXML/Acknowledged/text()='True')
                    then('The NGOSS/SMARTS Event is Acknowledged by the User Name Above.')
                    else('The NGOSS/SMARTS Event has been Unacknowledged.'),
                    if($IncidentXML/InMaintenance/text()='True')
                    then('The Affected Device/CI is in Maintenance within NGOSS/SMARTS.')
                    else('The Affected Device/CI is not in Maintenance within NGOSS/SMARTS.')
                    )}</ns1:WorkNotes>
              </ns1:IncidentDetails>
              <ns1:IncidentContact>
                    <ns1:EmailAddress>{$IncidentXML/Owner/EmailAddress/text()}</ns1:EmailAddress>
              </ns1:IncidentContact>
              <ns1:IncidentAsset>
                    <ns1:CI>{$IncidentXML/ElementId/text()}</ns1:CI>
              </ns1:IncidentAsset>
        </ns1:IncidentRequestBody>
    </ns1:IncidentRequestMessage>
};

local:func($IncidentXML, $TransactionType, $Message_TranId, $TicketNumber, $ExtRefNumber, $ResolvedValues, $DefaultValues)