
	<cfset rowID = RES_ID>

	<cfquery name="get_equips" datasource="#APP_dsn#">
		select	E.NAME, E.BARCODE
		from	RES_DETAILS R, EQUIPMENT E
		where	R.EQUIP_ID = E.EQUIP_ID AND
				R.RES_ID = #rowID#	
				<cfif url.upcoming EQ "checkins">
					AND R.STATUS = 'checked'
				</cfif>
	</cfquery>
	
	<cfset count = 1>
	<cfif get_equips.recordcount>
		<cfset equipList = "">
	<cfelse>
		<cfset equipList = " ">
	</cfif>
	<cfloop query="get_equips">
		<cfif count GT 1>
			<cfset equipList = equipList & "<br>">
		</cfif>
		<cfset equipList = equipList & "#NAME# (#BARCODE#)">
		<cfset count = count + 1>
	</cfloop>
	
	<cfif Trim(NOTES) EQ "">
		<cfset miscText = " ">
	<cfelse>
		<cfset miscText = NOTES>
	</cfif>
	
	<cfif Trim(RES_NOTES) EQ "">
		<cfif Trim(INITIALS) EQ "">
			<cfset noteText = " ">
		<cfelse>
			<cfset noteText = "(" & INITIALS & ") ">
		</cfif>
	<cfelse>
		<cfif Trim(INITIALS) EQ "">
			<cfset noteText = RES_NOTES>
		<cfelse>
			<cfset noteText = "(" & INITIALS & ")<br>" & RES_NOTES>
		</cfif>
	</cfif>
	
	<cfif CreateODBCDateTime(DUE_DT) LT CreateODBCDateTime(Now())>
		<cfset isResLate = "yes">
	</cfif>
	
	
	<!--- 	<cfif url.upcoming EQ "checkins">
		<cfset tableContent = DateFormat(DUE_DT,"mmm d yy") & "<br>" & TimeFormat(DUE_DT,"h:mm tt") & "|" & "<a href=""mailto:" & EMAIL & """>" & LAST_NAME & ", " & FIRST_NAME & "</a>" & "|" & equipList & "|" & noteText>
	<cfelse>
		<cfset tableContent = DateFormat(RES_DT,"mmm d yy") & "<br>" & TimeFormat(RES_DT,"h:mm tt") & "|" & "<a href=""mailto:" & EMAIL & """>" & LAST_NAME & ", " & FIRST_NAME & "</a>" & "|" & equipList & "|" & noteText>
	</cfif>
 --->
 
	<cfset tableContent = DateFormat(RES_DT,"mmm d yy") & " - " & TimeFormat(RES_DT,"h:mm tt") & "|" & DateFormat(DUE_DT,"mmm d yy") & " - " & TimeFormat(DUE_DT,"h:mm tt") & "|" & "<a href=""mailto:" & EMAIL & """>" & LAST_NAME & ", " & FIRST_NAME & "</a>" & "|" & equipList & "<br>" & miscText & "|" & noteText>
