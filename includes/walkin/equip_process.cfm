

	<cfif form.add>
		
		<!--- does equip already exist in cart? --->
		<cfset equipInCart="no">
		<cfif validEquips>
			<cfloop index="e" from="1" to="#ArrayLen(equipArray[1])#">  <!--- equip items will be the same for every day, so only need to check first day (recurring) --->
				<cfif GetToken(GetToken(equipArray[1][e],1,"|"),2,"_") EQ form.equipID>
					<cfset equipInCart="yes">
				</cfif>
			</cfloop>
		</cfif>
		
		<!--- if so, alert and do nothing --->
		
		<cfif equipInCart>
		
			<script LANGUAGE="JavaScript">
			<!--
				alert("Equipment already exists in your cart.");
			//-->
			</script>			

		<cfelse>
		
			<!--- get added equip info --->
		
			<cfset tmpRoles = ListToArray(form.roleList,",")>
			<cfset roleIDs = "">
			<cfloop index="x" from="1" to="#ArrayLen(tmpRoles)#">
				<cfset roleIDs = ListAppend(roleIDs,GetToken(tmpRoles[x],1,"|"))>
			</cfloop>
		
			<cfquery name="get_equip" datasource="#APP_dsn#">
				select	E.EQUIP_ID, E.BARCODE, E.NAME, E.RES_LENGTH, E.RES_LENGTH_EXCEPTION
				from 	EQUIPMENT E, ROLES_EQUIP RE
				where	E.BARCODE = #form.equipID# and
						E.DEPT_ID = #form.dept# and 
						E.EQUIP_ID = RE.EQUIP_ID and 
						RE.ROLE_ID in (#roleIDs#) and
						E.AVAILABILITY = 'yes' and
						E.STATUS <> 'deleted'
			</cfquery>
	
			<cfif get_equip.recordcount>
			
				<cfloop index="k" from="1" to="#ListLen(form.date)#">

					<cfset pickupDT = CreateODBCDateTime(GetToken(form.date,k,",") & " " & GetToken(form.time,k,","))>
					
					<!--- 1st step is to get due date based on dept schedules... --->
					
					<!--- Nov 2004 - changed pickupDate to pickupDT below.  wasn't sure why pickupDate was used --->
					<cfif form.specialResType EQ "longterm">
						<cfset adjustedResLength = DateDiff("h",form.specialStartDate,form.specialEndDate)>
					<cfelse>
						<cfif Trim(get_equip.RES_LENGTH_EXCEPTION) NEQ "" and Trim(DateFormat(pickupDT,"dddd")) EQ Trim(GetToken(get_equip.RES_LENGTH_EXCEPTION,1,","))>
								<cfset adjustedResLength = Trim(GetToken(get_equip.RES_LENGTH_EXCEPTION,2,","))>					
						<cfelse>
							<cfif get_equip.RES_LENGTH EQ 0>
								<cfset adjustedResLength = -1> <!--- equip due at closing the same day, -1 is to indicate this in the set_due_date include file--->
							<cfelse>
								<cfset adjustedResLength = get_equip.RES_LENGTH>
							</cfif>
						</cfif>
					</cfif>
					
					<!--- will need to insert a conditional here for long term res length adjustments --->
					
					<cfmodule 
						template="#APP_webroot#/#APP_path_customtags#/set_due_date.cfm"
						deptID="#form.dept#"
						resLength="#adjustedResLength#"
						resOut="#pickupDT#">
						
					<!--- 2nd step is to check for reservation conflicts - either fatal, or warn-worthy (truncating the res time for equip) --->
					
					<cfquery name="check_res" datasource="#APP_dsn#">
						select	*
						from 	RES_DETAILS RD, RESERVATIONS R
						where	RD.RES_ID = R.RES_ID and
								RD.EQUIP_ID = #get_equip.EQUIP_ID# and
								(
									RTRIM(LTRIM(RD.STATUS)) = 'checked' or
									RTRIM(LTRIM(RD.STATUS)) = 'open'
								)
						order by
								RES_DT
					</cfquery> 
					
					<cfset timeConflict = 0>
					<cfset validRequest = 1>
	
					<cfloop query="check_res">
					
						<cfset queryOut = CreateODBCDateTime(OUT_DT)>
						<cfset queryIn = CreateODBCDateTime(DUE_DT)>
						<cfset pendingOut = CreateODBCDateTime(pickupDT)>
						<cfset pendingIn = CreateODBCDateTime(dueDate)>
						
						<!--- this tag returns inConflict and outInBetween vars --->
						<cfmodule 
							template="#APP_webroot#/#APP_path_customtags#/conflict_check.cfm"
							existingOut = "#queryOut#"
							existingIn = "#queryIn#"
							pendingOut = "#pendingOut#"
							pendingIn = "#pendingIn#">
							
							<!--- <cfoutput>#outInBetween#, #inConflict#<br></cfoutput> --->
										
						<cfif outInBetween EQ 1 OR (form.type EQ "walkin" AND Trim(STATUS) EQ "checked")>
							<cfset validRequest = 0>
							<cfset conflictingRes = RES_ID>
						</cfif>
						<cfif inConflict EQ 1>
							<cfif NOT timeConflict>
								<cfset dueDate = CreateODBCDateTime(RES_DT)>
								<cfset newResLength = DateDiff("n",pickupDT,dueDate)>
								<cfset timeConflict = RES_ID>
							</cfif>
						</cfif>
						
					</cfloop>
	
					<cfif validRequest>
	
						<cfmodule 
							template="#APP_webroot#/#APP_path_customtags#/build_equip_list.cfm"
							equipID="#get_equip.EQUIP_ID#"
							barcode="#get_equip.BARCODE#"
							equipName="#get_equip.NAME#"
							resLength="#newResLength#"
							dueDate="#dueDate#"
							timeConflict="#timeConflict#">
	
						<!--- created: equipItemString --->
						
						<cfset equipArray[k][ArrayLen(equipArray[k])+1] = equipItemString>
	
					<cfelse>
							
						<!--- query for helpful conflict information here --->
	
						<cfquery name="get_conflict" datasource="#APP_dsn#">
							select	FIRST_NAME, LAST_NAME, RES_DT, DUE_DT
							from 	USERS U, RESERVATIONS R
							where	R.RES_ID = #conflictingRes# and
									U.USER_ID = R.USER_ID
						</cfquery> 
						
						<cfoutput query="get_conflict">
							<cfset conflictOut = DateFormat(RES_DT,"mmm d") & " at " & TimeFormat(RES_DT,"h:mm tt")>
							<cfset conflictIn = DateFormat(DUE_DT,"mmm d") & " at " & TimeFormat(DUE_DT,"h:mm tt")>
							<script LANGUAGE="JavaScript">
							<!--
								alert("Equipment is currently checked out or reserved.\r\rPlease select a different item.\r\rThe conflicting reservation begins on #conflictOut#, ends on #conflictIn# and belongs to #FIRST_NAME# #LAST_NAME#");
							//-->
							</script>
						</cfoutput>
	
					</cfif>				
				</cfloop>
				
		
									
			<cfelse>  <!--- this code does not need to be updated for recurring reservations - it's merely checking non-date-specific equipment access --->
		
				<cfquery name="check_exists" datasource="#APP_dsn#">
					select	*
					from 	EQUIPMENT
					where	BARCODE = #form.equipID# and
							DEPT_ID = #form.dept# and 
							STATUS <> 'deleted'					
				</cfquery>
				
				<cfif check_exists.recordcount>
					<cfif Trim(check_exists.AVAILABILITY)>
						<cfset problemMessage = "This piece of equipment may not be checked out.\r\rThe user with [ORG-NAME] ID " & form.psid & " does not have permission to checkout/reserve this piece of equipment.\r\rPlease contact the checkout administrator to obtain access to this equipment.">
					<cfelse>
						<cfset problemMessage = "This piece of equipment may not be checked out.\r\rThe equipment has been made unavailable for checkout.">
					</cfif>
				<cfelse>
					<cfset problemMessage = "This piece of equipment may not be checked out.\r\rEquipment ID was not found in the system.">
				</cfif>
				
				<script LANGUAGE="JavaScript">
				<!--
					alert("<cfoutput>#problemMessage#</cfoutput>");
				//-->
				</script>
		
			</cfif>
	
		</cfif>

	</cfif>
	
	<cfif form.removeID NEQ 0>	<!--- code below updated Nov 2004 to work for recurring reservations --->
	
		<cfloop index="t" from="1" to="#ListLen(form.date)#">  
			<cfif ListLen(form.removeID,"|") EQ 1>
				<cfset equipArray[t][form.removeID] = deletedConstant>
				
			<cfelseif ListLen(form.removeID,"|") EQ 2>
				<cfset eID = GetToken(form.removeID,1,"|")>
				<cfset aID = GetToken(form.removeID,2,"|")>
				<cfset tmpEquipInfo = GetToken(equipArray[t][GetToken(eID,1,"_")],1,"|")>
				<cfset tmpAccArray = ListToArray(GetToken(equipArray[t][eID],2,"|"),"~")>
				<cfloop index="r" from="1" to="#ArrayLen(tmpAccArray)#">
					<cfif GetToken(tmpAccArray[r],1,"_") EQ aID>
						<cfset tmpAccArray[r] = deletedConstant>
					</cfif>
				</cfloop>
				<cfset tmpAccList = ArrayToList(tmpAccArray,"~")>
				<cfset equipArray[t][eID] = "#tmpEquipInfo#|#tmpAccList#">
				
			</cfif>
		</cfloop>				
	
	</cfif>
	
<!--- <cfoutput>
	<cfloop index="i" from="1" to="#ListLen(form.date)#">
		<cfloop index="x" from="1" to="#ArrayLen(equipArray[i])#">
			(#equipArray[i][x]#) +<br>
		</cfloop><br>
	</cfloop> 
</cfoutput>	 --->
	
	
	<cfif form.add OR (form.removeID NEQ 0)>
	
		<!--- <cfoutput>#ListLen(form.date)# #ArrayLen(equipArray[1])# #equipArray[1][3]#</cfoutput> --->
	
		<cfloop index="i" from="1" to="#ListLen(form.date)#">
			<!--- <cfset equipArray[i] = ListToArray(instanceArray[i])> dont want to overwrite what's already there--->
			<cfset validEquips = 0>
			<cfloop index="xx" from="1" to="#ArrayLen(equipArray[i])#">
				<cfif equipArray[i][xx] NEQ deletedConstant>
					<cfset validEquips = validEquips + 1>
				</cfif>
			</cfloop>
		</cfloop>

	</cfif>

