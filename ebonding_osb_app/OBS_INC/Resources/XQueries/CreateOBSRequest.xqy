xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://eai/Sav/Trillium/Types";
(:: import schema at "../WSDL/PH_B2B_EPH_TRILLIUM_TroubleTicket_source_services.wsdl" ::)
declare namespace ns2="http://www.sita.aero/schema/IncidentEbondingMessageV1";
(:: import schema at "../../../Common/Resources/Schemas/IncidentEbondingMessage.xsd" ::)

declare variable $CanonicalRequestMessage as element() (:: schema-element(ns2:IncidentRequestMessage) ::) external;

declare variable $Status_Code as xs:string external;
declare variable $TravelTime as xs:string external;
declare variable $TimeSpent as xs:string external;
declare variable $Status as xs:string external;
declare variable $Resolution_Code as xs:string external;
declare variable $DefaultValues as element(*) external;

declare function local:func($Status_Code as xs:string,$TravelTime as xs:string,$TimeSpent as xs:string , $Status as xs:string, $DefaultValues as element(*),$Resolution_Code as xs:string,$CanonicalRequestMessage as element() (:: schema-element(ns2:IncidentRequestMessage) ::)) as element() (:: schema-element(ns1:TRANSACTION) ::) {
<ns1:TRANSACTION>
      {   if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<TRANSACTION_TYPE>Creation</TRANSACTION_TYPE>

          else if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='UPDATE')then
	<TRANSACTION_TYPE>Update</TRANSACTION_TYPE>

         else if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='ACK')then
	<TRANSACTION_TYPE>Ack</TRANSACTION_TYPE>

	else if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='ERROR')then
	<TRANSACTION_TYPE>ERROR</TRANSACTION_TYPE>
          else()
       } 


        {
        if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<REC_TYPE>Incident</REC_TYPE>
        else()
        }


	<TRANSACTION_ID>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionId)}</TRANSACTION_ID>

	<SR_ID>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:TicketNumber)}</SR_ID>
	 {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)!='CREATE')then
            (
            if ((fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Supplier/ns2:Name/text()) = 'OBS'))then
	<EXTERNAL_ID>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Supplier/ns2:RefNumber)}</EXTERNAL_ID>
         else if ((fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Customer/ns2:Name/text()) = 'OBS'))then
	<EXTERNAL_ID>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Customer/ns2:RefNumber)}</EXTERNAL_ID>
            else() 
           ) 
            else()
        }
	<INTERFACE>SITA</INTERFACE>
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then

	<DESCRIPTION>{
        if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Description))
        then(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Description))
        else(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ShortDescription))
        }</DESCRIPTION>
          else()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<SUMMARY>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ShortDescription)}</SUMMARY>
          else()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<SEVERITY>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority)}</SEVERITY>
          else()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE') then
	<STATUS>Open</STATUS>
          else if (fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='UPDATE') then
	<STATUS>{ if ($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y') then 'Resolved' 	
	else if(fn:string($Status_Code) = 'Resolved' and fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ResolutionCode/text()))) then 'Concurrence Requested' else if(fn:string($Status_Code) = 'Acknowledged')then $Status_Code else ($Status)}</STATUS>
          else()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<CATEGORY>{
                      if(fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Category/text())))
                      then(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Category))
                      else($DefaultValues/CATEGORY/text())
                    }</CATEGORY> 	
          else()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<GROUP>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AssignmentGroup)}</GROUP>
          else()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<LOCATION>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentLocation/ns2:Location)}</LOCATION>
            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<CUSTOMER>
		<LAST_NAME>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:LastName)}</LAST_NAME>
		<FIRST_NAME>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:FirstName)}</FIRST_NAME>
		<MIDDLE_NAME>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:MiddleName)}</MIDDLE_NAME>
		<EMAIL_ADDRESS>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:EmailAddress)}</EMAIL_ADDRESS>
	</CUSTOMER>

            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<PRIMARY_CI>
		<ASSET_TAG>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentAsset/ns2:BusinessService)}</ASSET_TAG>
	</PRIMARY_CI>
            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
	<SECONDARY_CI>
		<ASSET_TAG>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentAsset/ns2:CI)}</ASSET_TAG>
	</SECONDARY_CI>
            else ()
        }
        {
          if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='UPDATE')then
	<UPDATE_INFO>
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AssignmentGroup/text())>0)then

		<UPDATE_FIELD>
			<FIELD_NAME>GROUP</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AssignmentGroup)}</FIELD_VALUE>
		</UPDATE_FIELD>
                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:EmailAddress/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>AFFECTED_CONTACT</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentContact/ns2:EmailAddress)}</FIELD_VALUE>
		</UPDATE_FIELD>
                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ETA/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>eta</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ETA)}</FIELD_VALUE>
		</UPDATE_FIELD>
                    else()
                }

		<UPDATE_FIELD>
			<FIELD_NAME>STATUS</FIELD_NAME>
			<FIELD_VALUE>{ if ($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y') then 'Resolved'
			else if(fn:string($Status_Code) = 'Resolved' and fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ResolutionCode/text()))) then 'Concurrence Requested'  else if(fn:string($Status_Code) = 'Acknowledged')then $Status_Code else ($Status)}</FIELD_VALUE>                      
		</UPDATE_FIELD>


                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ATD/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>ATD</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ATD)}</FIELD_VALUE>
		</UPDATE_FIELD>
                    else()
                }

                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>SEVERITY</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority)}</FIELD_VALUE>

		</UPDATE_FIELD>

                    else()
                }
			{
			if(fn:string($Status_Code) != 'Acknowledged')then
		<UPDATE_FIELD>
			<FIELD_NAME>CATEGORY</FIELD_NAME>
			<FIELD_VALUE>{if(fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Category/text())))
                      then(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Category))
                      else($DefaultValues/CATEGORY/text())}</FIELD_VALUE>			

		</UPDATE_FIELD>
		else()
		}


                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AdditionalComments/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>comments</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AdditionalComments)}</FIELD_VALUE>

		</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ShortDescription/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>SUMMARY</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ShortDescription)}</FIELD_VALUE>

		</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Description/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>DESCRIPTION</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Description)}</FIELD_VALUE>

		</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ATA/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>ata</FIELD_NAME>
			<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ATA)}</FIELD_VALUE>

		</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:TravelTime/text())>0)then
		<UPDATE_FIELD>
			<FIELD_NAME>travel_time</FIELD_NAME>
			<FIELD_VALUE>{if(fn:string-length(fn:substring-before($TravelTime,':')) < 2)
                        then (fn:concat('0',$TravelTime))
                        else($TravelTime)
                        }</FIELD_VALUE>

				</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Impact/text())>0)then
				<UPDATE_FIELD>
					<FIELD_NAME>IMPACT</FIELD_NAME>
					<FIELD_VALUE>{dvmtr:lookup('OBS_INC/Resources/DVM/OBSOutboundImpactUrgency', 'Priority', $CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority/text(), 'Impact', '')}</FIELD_VALUE>

				</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentLocation/ns2:Issue/text())>0)then
				<UPDATE_FIELD>
					<FIELD_NAME>SYMPTOM</FIELD_NAME>
					<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentLocation/ns2:Issue)}</FIELD_VALUE>

				</UPDATE_FIELD>

                    else()
                }
                   {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:TimeSpent/text())>0)then
				<UPDATE_FIELD>
					<FIELD_NAME>time_site</FIELD_NAME>
					<FIELD_VALUE>{if (fn:string-length(fn:substring-before($TimeSpent,':'))<2) 
	then ((fn:concat('0', if ((fn:substring-before($TimeSpent,':')) eq '0' ) then ('1:') else (fn:concat(fn:substring-before($TimeSpent,':'),':')),
	'00:00')))
						else if ((fn:substring-before(($TimeSpent),':')) = '00') then '01:00:00'
                                    else if ((fn:substring-before(($TimeSpent),':')) >= '12') then ('12:00:00')
                                    else($TimeSpent)}
							</FIELD_VALUE>
						</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentAsset/ns2:BusinessService/text())>0)then
						<UPDATE_FIELD>
							<FIELD_NAME>SERVICE_CI</FIELD_NAME>
							<FIELD_VALUE>{data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentAsset/ns2:BusinessService)}</FIELD_VALUE>

						</UPDATE_FIELD>

                    else()
                }
                {
                  if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Urgency/text())>0)then
						<UPDATE_FIELD>
							<FIELD_NAME>URGENCY</FIELD_NAME>
							<FIELD_VALUE> {dvmtr:lookup('OBS_INC/Resources/DVM/OBSOutboundImpactUrgency', 'Priority', $CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority/text(), 'Urgency', '')}</FIELD_VALUE>

						</UPDATE_FIELD>
                    else()
                }
			{
			if(fn:string($Status_Code) != 'Acknowledged')then
						<UPDATE_FIELD>
							<FIELD_NAME>resol_local</FIELD_NAME>
							<FIELD_VALUE>{ if ($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y') then 'Cancelled'
			else if(fn:string-length($Resolution_Code)>0) then $Resolution_Code else ('No Fault Found')}</FIELD_VALUE>
						</UPDATE_FIELD>
		else()
		}


					</UPDATE_INFO>
          else()
        }
              {
	  if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='UPDATE')then
        (<ACT_LOG>{
            if ((fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Supplier/ns2:Name/text()) = 'OBS'))then
						<DESCRIPTION>{ if (($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y')) then 'Resolved'
		else if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:SupplierComments))
          then(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:SupplierComments))

			else if (($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y')) then 'Status Changed to Resolved'
			else if(fn:string($Status_Code) = 'Acknowledged')then 'Ticket Acknowledged' 
          else(fn:concat('Status changed to ', if(fn:string($Status_Code) = 'Resolved' and fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ResolutionCode/text()))) then 'Concurrence Requested'  else ($Status)))}</DESCRIPTION>


         else if ((fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Customer/ns2:Name/text()) = 'OBS'))then
						<DESCRIPTION>{  if (($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:KillFlag/text()='Y')) then 'Status Changed to Resolved'

		else if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:WorkNotes))
          then(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:WorkNotes))	
		  else if(fn:string($Status_Code) = 'Acknowledged')then 'Ticket Acknowledged' 		  
          else(fn:concat('Status changed to ', if(fn:string($Status_Code) = 'Resolved' and fn:exists(fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ResolutionCode/text()))) then 'Concurrence Requested' else ($Status)))}</DESCRIPTION>
            else(<DESCRIPTION/>) 
           }</ACT_LOG>)
        else()
	}

	{
	if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='ERROR') 
	then(<ACT_LOG>
						<DESCRIPTION>
				{if(fn:string-length($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AdditionalComments) > 0)then
                                fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:AdditionalComments)
                                else
                                fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:WorkNotes)
                                }
						</DESCRIPTION>
					</ACT_LOG>)
	else()
	}
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<NCC>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentAsset/ns2:NCC)}</NCC>
            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<IMPACT>{dvmtr:lookup('OBS_INC/Resources/DVM/OBSOutboundImpactUrgency', 'Priority', $CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority/text(), 'Impact', '')}</IMPACT>
            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<URGENCY>{dvmtr:lookup('OBS_INC/Resources/DVM/OBSOutboundImpactUrgency', 'Priority', $CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:Priority/text(), 'Urgency', '')}</URGENCY>
              else ()
        }

        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<REPORT_METHOD>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:ReportMethod)}</REPORT_METHOD>
            else ()
        }
       {
        if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<TIME_STAMP>{fn:current-time()}</TIME_STAMP>
           else()
       }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<OPEN_DATE>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentDetails/ns2:OpenDate)}</OPEN_DATE>
            else ()
        }
        {
            if(fn:data($CanonicalRequestMessage/ns2:IncidentRequestHeader/ns2:TransactionType)='CREATE')then
					<SYMPTOM>{fn:data($CanonicalRequestMessage/ns2:IncidentRequestBody/ns2:IncidentLocation/ns2:Issue)}</SYMPTOM>
            else ()
        }


				</ns1:TRANSACTION>
};

local:func($Status_Code,  $TravelTime , $TimeSpent ,$Status, $DefaultValues, $Resolution_Code,$CanonicalRequestMessage)