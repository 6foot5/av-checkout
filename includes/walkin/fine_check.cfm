

	<cfquery name="get_user_fines" datasource="#APP_dsn#">
		select	USER_ID
		from	FINES F, RESERVATIONS R
		where	R.USER_ID = '#Trim(userID)#' and
				R.RES_ID = F.RES_ID and
				RTRIM(LTRIM(F.STATUS)) = 'open'
	</cfquery>
	
	<cfif get_user_fines.recordcount>
		<script language="JavaScript">
		<!-- 
			alert('According to our records, <cfoutput>#userName#</cfoutput> has an outstanding fine.  Any outstanding fines must be settled before any items may be reserved or checked out.');
			location.replace('home.cfm');			
		-->
		</script>
	</cfif>
	
