	
	
	<cfif dbEditID eq 0>
	
		<cfquery name="get_equip" datasource="#APP_dsn#">
			select	*
			from	EQUIPMENT
			where	BARCODE = #form.eBarcode# and
					DEPT_ID = #form.eDept# and
					STATUS <> 'deleted'
		</cfquery>
		
		<cfif get_equip.RecordCount EQ 0>

			<cfif form.eResLengthException NEQ "" AND form.eResLengthExceptionDay NEQ "">
				<cfset newException = form.eResLengthExceptionDay & "," & form.eResLengthException>
			<cfelse>
				<cfset newException = "">
			</cfif>
			
			<cftransaction action="begin">
				<cfquery name="eInsert" datasource="#APP_dsn#">
					INSERT INTO EQUIPMENT 	
									(DEPT_ID,
									BARCODE, 
									NAME, 
									SERIAL, 
									NOTES, 
									<cfif form.eAcc NEQ "">
										ACC_PKG,
									</cfif>
									FINE_SCHEDULE,
									STATUS,
									AVAILABILITY, 
									RES_LENGTH,
									RES_LENGTH_EXCEPTION)	
					VALUES
									(#form.eDept#, 
									#form.eBarcode#, 
									'#form.eName#', 
									'#form.eSerial#', 
									'#form.eNotes#', 
									<cfif form.eAcc NEQ "">
										#form.eAcc#,
									</cfif>
									'#form.eFine#', 
									'current', 
									'#form.eAvail#', 
									#form.eResLength#,
									'#newException#')									
				</cfquery>
				<cfquery name="get_max" datasource="#APP_dsn#">
					select	max(EQUIP_ID) as newID
					from	EQUIPMENT
				</cfquery>
			</cftransaction>
			
			<cfif form.catID GT 0>
				<cfquery name="cInsert" datasource="#APP_dsn#">
					INSERT INTO EQUIP_ORG 	
									(CAT_ID,
									EQUIP_ID)	
					VALUES
									(#form.catID#, 
									#get_max.newID#)									
				</cfquery>			
			</cfif>	
	
		<cfelse>
		
			<cfset loadReferringPage = "no">
			<br><br>
			<p><b>Error:</b> you have entered an equipment barcode that is already taken.  
			<br>Please use your browser's "back" button to return and enter a different barcode.</p>
			
		</cfif>
	
	<cfelse>
	
		<cfif form.eResLengthException NEQ "" AND form.eResLengthExceptionDay NEQ "">
			<cfset newException = form.eResLengthExceptionDay & "," & form.eResLengthException>
		<cfelse>
			<cfset newException = "">
		</cfif>
		
		<cfquery name="eUpdate" datasource="#APP_dsn#">
			UPDATE	EQUIPMENT
			SET 	DEPT_ID = #form.eDept#,	
					BARCODE = #form.eBarcode#,
					SERIAL = '#form.eSerial#',
					NAME = '#form.eName#',
					AVAILABILITY = '#form.eAvail#',
					RES_LENGTH = #form.eResLength#,
					RES_LENGTH_EXCEPTION = '#newException#',
					<cfif form.eAcc NEQ "">
						ACC_PKG = #form.eAcc#,
					</cfif>
					FINE_SCHEDULE = '#form.eFine#',
					NOTES = '#form.eNotes#'
			WHERE 	EQUIP_ID = #dbEditID#
		</cfquery>
	
	</cfif>

