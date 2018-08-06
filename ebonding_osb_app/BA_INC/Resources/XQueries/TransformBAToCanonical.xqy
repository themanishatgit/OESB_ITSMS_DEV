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
declare variable $Priority as xs:string external;

declare function local:func($IncidentRecord as element() (:: schema-element(IncidentRecord) ::), 
                            $ResolvedValues as element(*), 
                            $DefaultValues as element(*),
                            $Message_TranId as xs:string,
                            $TransactionType as xs:string,
                            $RecType as xs:string,
                            $DestinationSystem as xs:string,
                            $ExtRefNumber as xs:string,
                            $TicketNumber as xs:string,$Priority as xs:string) 
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
			{
                        if($TransactionType='CREATE')
                        then(
                          if(fn:exists($ResolvedValues/Group/text()))
                          then(<ns1:AssignmentGroup>{$ResolvedValues/Group/text()}</ns1:AssignmentGroup>)
                          else(<ns1:AssignmentGroup>{$DefaultValues/Group/text()}</ns1:AssignmentGroup>)
                          )
                        else(
                        if(fn:exists($ResolvedValues/Group/text()))
                        then(<ns1:AssignmentGroup>{$ResolvedValues/Group/text()}</ns1:AssignmentGroup>)
                        else()
                        )
                        }
			{
                        if($TransactionType='CREATE')
                        then(<ns1:Description>{$IncidentRecord/IncidentDetails/IncidentDescription/text()}</ns1:Description>)
                        else()
                        }
                        {
                        if($TransactionType='CREATE')
                        then(<ns1:ShortDescription>{$IncidentRecord/IncidentDetails/IncidentTitle/text()}</ns1:ShortDescription>)
                        else()
                        }
                        <ns1:Priority>{$Priority}</ns1:Priority>
			<ns1:Category>{$DefaultValues/Category/text()}</ns1:Category>
			<ns1:Impact>{
                        if(fn:exists($ResolvedValues/Impact/text()))
                        then($ResolvedValues/Impact/text())
                        else($DefaultValues/Impact/text())
                        }</ns1:Impact>
			<ns1:Urgency>{
                        if(fn:exists($ResolvedValues/Urgency/text()))
                        then($ResolvedValues/Urgency/text())
                        else($DefaultValues/Urgency/text())
                        }
                        </ns1:Urgency>
			<ns1:Customer>
				<ns1:Name>BA</ns1:Name>
				<ns1:RefNumber>{$ExtRefNumber}</ns1:RefNumber>
			</ns1:Customer>
                        <ns1:AdditionalComments>{$IncidentRecord/IncidentActivities/CorrectiveActions/text()}</ns1:AdditionalComments>
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
                            else($DefaultValues/DefContact_Email/text())
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
                          <ns1:BusinessService>{$DefaultValues/ServiceCI/text()}</ns1:BusinessService>
                </ns1:IncidentAsset>
		<ns1:IncidentLocation>
		</ns1:IncidentLocation>
	</ns1:IncidentRequestBody>
</ns1:IncidentRequestMessage>
};

local:func($IncidentRecord, $ResolvedValues, $DefaultValues, $Message_TranId, $TransactionType, $RecType, $DestinationSystem, $ExtRefNumber, $TicketNumber,$Priority)