
	<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
		<cfset dList="">
		<cfset showAll = "yes">
	<cfelse>
		<cfset showAll = "no">
		<cfset dList = cookie.userAdminDepts>
	</cfif>

	<cfquery name="get_depts" datasource="#APP_dsn#">
		select 	*
		from 	DEPARTMENTS
		<cfif NOT showAll>
			where	DEPT_ID in (#dList#)
		</cfif>
		order by
				DEPT_NAME
	</cfquery>

	<option value="JavaScript:void(0);" selected>&nbsp;Select Your View Options Below...&nbsp;&nbsp;&nbsp;</option>
	
