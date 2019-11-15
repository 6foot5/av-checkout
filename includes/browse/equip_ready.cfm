
<h4>Choose Equipment</h4>
<cfoutput>
<table width="600" border="1" cellspacing="0" cellpadding="3" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
</cfoutput>
	
	<cfset pickupD = ListToArray(form.date,",")>
	<cfset pickupT = ListToArray(form.time,",")>
	<!--- <cfset pickupDT = CreateODBCDateTime(form.date & " " & form.time)>
	<cfset dueDate = CreateODBCDateTime(DateAdd("d",2,form.date) & " " & form.time)> --->
	<cfset counter = 1>

	<cfoutput query="get_equip">
	
		<cfif RES_LENGTH NEQ "">
			<cfset thisEquipLen = RES_LENGTH>
		<cfelse>
			<cfset thisEquipLen = resLengthGen>
		</cfif>
	
		<cfquery name="get_conflicts" datasource="#APP_dsn#">
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
					<!--- ( 	
						RTRIM(LTRIM(RD.STATUS)) = 'checked' or
						(	
							RTRIM(LTRIM(RD.STATUS)) = 'open' and
							(#pickupDT# < R.RES_DT)
						)  <!--- ****** FIX THIS SHIT!!! ---> 
					)  --->
		</cfquery> 
		<!--- <cfquery name="get_conflicts" datasource="#APP_dsn#">
			select	R.RES_ID, R.OUT_DT, R.DUE_DT
			from	RESERVATIONS R, RES_DETAILS RD
			where  	R.RES_ID = RD.RES_ID and	
					RD.EQUIP_ID = #get_equip.EQUIP_ID# and
					(
						RTRIM(LTRIM(RD.STATUS)) = 'open' or
						RTRIM(LTRIM(RD.STATUS)) = 'checked'
					) and
					(
						( 
							DATEPART(mm,R.OUT_DT) = #DateFormat(form.date,"mm")# AND 
							DATEPART(dd,R.OUT_DT) = #DateFormat(form.date,"dd")# AND 
							DATEPART(yyyy,R.OUT_DT) = #DateFormat(form.date,"yyyy")# 
						)
						OR					
						( 	DATEPART(mm,R.DUE_DT) = #DateFormat(form.date,"mm")# AND 
							DATEPART(dd,R.DUE_DT) = #DateFormat(form.date,"dd")# AND 
							DATEPART(yyyy,R.DUE_DT) = #DateFormat(form.date,"yyyy")# 
						)
					)
			order by 
					R.OUT_DT
		</cfquery> --->
		
		<cfif counter EQ 1>
			<tr>
				<td width="250" class="tableHead"><b>#CAT_NAME# Listing</b></td>
				<td width="350" class="tableHead"><b>Relevant Conflict Information (if any)</b></td>
			</tr>
		</cfif>
	
		<tr>
			<td class="table">
				<a href="JavaScript:opener.walkinBuild.equipID.value='#BARCODE#';window.close();">#NAME# (#BARCODE#)<!--- <br>
				<i><b>Cat:</b> #CAT_NAME#</i> --->
				</a>
			</td>
			<td class="table">
				<p>
				<cfset conflictFound = 0>
				<cfloop query="get_conflicts">
				
					<cfloop index="c" from="1" to="#ArrayLen(pickupD)#">
					
						<cfset queryOut = CreateODBCDateTime(OUT_DT)>
						<cfset queryIn = CreateODBCDateTime(DUE_DT)>
						<cfset pendingOut = CreateODBCDateTime(pickupD[c] & " " & pickupT[c])>
						<cfset pendingIn = CreateODBCDateTime(DateAdd("h",thisEquipLen,pendingOut))>
						
						<!--- this tag returns inConflict and outInBetween vars --->
						<cfmodule 
						template="#APP_webroot#/#APP_path_customtags#/conflict_check.cfm"
						existingOut = "#queryOut#"
						existingIn = "#queryIn#"
						pendingOut = "#pendingOut#"
						pendingIn = "#pendingIn#">
							
						<cfif outInBetween OR inConflict OR Trim(STATUS) EQ "checked">
							<cfset conflictFound = 1>
							<b>Out:</b> #DateFormat(OUT_DT, "mmm d")# at #TimeFormat(OUT_DT, "h:mm tt")#
							<b>Due:</b> #DateFormat(DUE_DT, "mmm d")# at #TimeFormat(DUE_DT, "h:mm tt")#<br>
						</cfif>

					</cfloop>
										
				</cfloop>
				<cfif NOT conflictFound>
					...
				</cfif>
				</p>	
			</td>
		</tr>
		<cfset counter = counter + 1>
	</cfoutput>
	
</table>

