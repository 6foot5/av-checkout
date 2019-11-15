

	<cfset rightNow = CreateODBCDateTime(Now())>

	<cfquery name="get_user_overdue" datasource="#APP_dsn#">
		select	E.NAME, E.BARCODE
		from	RES_DETAILS D, RESERVATIONS R, EQUIPMENT E
		where	R.USER_ID = '#Trim(userID)#' and
				R.RES_ID = D.RES_ID and
				RTRIM(LTRIM(D.STATUS)) = 'checked' and
				D.EQUIP_ID = E.EQUIP_ID and
				R.DUE_DT < #rightNow# and
				R.DEPT_ID = #form.dept#				
	</cfquery>
	
	<cfif get_user_overdue.recordcount>
		<cfset overdueList = "">
		<cfloop query="get_user_overdue">
			<cfset overdueList =  overdueList & NAME & " (" & BARCODE & ")\r">
		</cfloop>
		<script language="JavaScript">
		<!-- 
			alert('Warning: According to our records, <cfoutput>#userName#</cfoutput> has the following overdue equipment:\r\r<cfoutput>#overdueList#</cfoutput>');
		-->
		</script>
	</cfif>
	
