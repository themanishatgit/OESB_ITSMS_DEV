xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare default element namespace "";
(:: import schema at "../Schemas/BA_IncidentRecord.xsd" ::)
declare namespace ns1="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $IncidentRecord as element() (:: schema-element(IncidentRecord) ::) external;
declare variable $ResolvedValues as element(*) external;
declare variable $DefaultValues as element(*) external;
declare variable $Message_TranId as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $RecType as xs:string external;
declare variable $DestinationSystem as xs:string external;
declare variable $ExtRefNumber as xs:string external;
declare variable $TicketNumber as xs:string external;

declare function local:func($IncidentRecord as element() (:: schema-element(IncidentRecord) ::), 
                            $ResolvedValues as element(*), 
                            $DefaultValues as element(*),
                            $Message_TranId as xs:string,
                            $TransactionType as xs:string,
                            $RecType as xs:string,
                            $DestinationSystem as xs:string,
                            $ExtRefNumber as xs:string,
                            $TicketNumber as xs:string) 
                            as element() (:: schema-element(ns1:IncidentRequestMessage) ::) {
    <ns1:IncidentRequestMessage>
	<ns1:IncidentRequestHeader>
		<ns1:TransactionId>{$Message_TranId}</ns1:TransactionId>
		<ns1:TransactionType>{$TransactionType}</ns1:TransactionType>
		<ns1:RecType>{$RecType}</ns1:RecType>
		<ns1:SourceSystem>BA</ns1:SourceSystem>
		<ns1:DestinationSystem>{$DestinationSystem}</ns1:DestinationSystem>
	</ns1:IncidentRequestHeader>
	<ns1:IncidentRequestBody>
		<ns1:IncidentDetails>
                        {
                        if($TransactionType='CREATE')
                        then()
                        else(<ns1:TicketNumber>{$TicketNumber}</ns1:TicketNumber>)
                        }
			<ns1:Status>{$ResolvedValues/Status/text()}</ns1:Status>
			<ns1:AssignmentGroup>{
                        if(fn:exists($ResolvedValues/Group/text()))
                        then($ResolvedValues/Group/text())
                        else($IncidentRecord/IncidentDetails/PrimaryAssignGroup/text())
                        }</ns1:AssignmentGroup>
			<ns1:Description>{$IncidentRecord/IncidentDetails/IncidentDescription/text()}</ns1:Description>
                        <ns1:ShortDescription>{$IncidentRecord/IncidentDetails/IncidentTitle/text()}</ns1:ShortDescription>
                        <ns1:Priority>{
                        if(fn:exists($ResolvedValues/Priority/text()))
                        then($ResolvedValues/Priority/text())
                        else($DefaultValues/Priority/text())
                        }</ns1:Priority>
			<ns1:Category>{$DefaultValues/Category/text()}</ns1:Category>
			<ns1:Customer>
				<ns1:Name>BA</ns1:Name>
				<ns1:RefNumber>{$ExtRefNumber}</ns1:RefNumber>
			</ns1:Customer>
                        <ns1:AdditionalComments>{fn:concat('Category: ',$IncidentRecord/IncidentDetails/Category/text(),'. Corrective Actions: ',$IncidentRecord/IncidentActivities/CorrectiveActions/text())}</ns1:AdditionalComments>
                        {
                        if($ResolvedValues/Status/text()='6')
                        then(<ns1:ResolutionCode>{$DefaultValues/ResolutionCode/text()}</ns1:ResolutionCode>)
                        else()
                        }
                        {
                        if(fn:exists($IncidentRecord/IncidentActivities/ResolutionSummary/text()))
                        then(<ns1:ResolutionSummary>{$IncidentRecord/IncidentActivities/ResolutionSummary/text()}</ns1:ResolutionSummary>)
                        else()
                        }
                        {
                        if(fn:exists($IncidentRecord/IncidentHistory/ResolvedAt/text()))
                        then(<ns1:ResolvedAt>{$IncidentRecord/IncidentHistory/ResolvedAt/text()}</ns1:ResolvedAt>)
                        else()
                        }
		</ns1:IncidentDetails>
                <ns1:IncidentContact>
                        {
                            if(fn:exists($IncidentRecord/IncidentContact/ContactFirstName/text()))
                            then(<ns1:FirstName>{$IncidentRecord/IncidentContact/ContactFirstName/text()}</ns1:FirstName>)
                            else()
                        }
                        {
                            if(fn:exists($IncidentRecord/IncidentContact/ContactLastName/text()))
                            then(<ns1:LastName>{$IncidentRecord/IncidentContact/ContactLastName/text()}</ns1:LastName>)
                            else()
                        }
                        <ns1:EmailAddress>{
                            if(fn:exists($IncidentRecord/IncidentContact/ContactEmail/text()))
                            then($IncidentRecord/IncidentContact/ContactEmail/text())
                            else()
                        }</ns1:EmailAddress>
                        {
                            if(fn:exists($IncidentRecord/IncidentContact/ContactPhone/text()))
                            then(<ns1:PhoneNumber>{$IncidentRecord/IncidentContact/ContactPhone/text()}</ns1:PhoneNumber>)
                            else()
                        }
                </ns1:IncidentContact>
                <ns1:IncidentAsset>
                {
                          if(fn:exists($IncidentRecord/IncidentAsset/AffectedAsset/text()))
                          then(<ns1:CI>{$IncidentRecord/IncidentAsset/AffectedAsset/text()}</ns1:CI>)
                          else()
                          }
                </ns1:IncidentAsset>
		<ns1:IncidentLocation>
                {
                          if(fn:exists($IncidentRecord/IncidentAsset/ServiceLocation/text()))
                          then(<ns1:Location>{$IncidentRecord/IncidentAsset/ServiceLocation/text()}</ns1:Location>)
                          else()
                          }
                          {
                        if($ResolvedValues/Status/text()='6')
                        then(<ns1:Issue>{$DefaultValues/Issue/text()}</ns1:Issue>)
                        else()
                        }
		</ns1:IncidentLocation>
	</ns1:IncidentRequestBody>
</ns1:IncidentRequestMessage>
};

local:func($IncidentRecord, $ResolvedValues, $DefaultValues, $Message_TranId, $TransactionType, $RecType, $DestinationSystem, $ExtRefNumber, $TicketNumber)