

	<cfmodule 
		template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
		deptID="#updateDept#"> 
	
	<!--- resExpireTime comes from tag above --->
	<cfset timesUpFocker = CreateODBCDateTime(DateAdd("n",(resExpireTime*-1),Now()))>

	<cfquery name="update_res_status" datasource="#APP_dsn#">
		update	RESERVATIONS 
		set		STATUS = 'pending'
		where	STATUS = 'open' and
				DEPT_ID = #updateDept# and
				RES_DT < #timesUpFocker#				
	</cfquery>

	<cfquery name="update_res_details_status" datasource="#APP_dsn#">
		update	RES_DETAILS
		set		STATUS = 'cancelled'
		where	RES_ID in (select RES_ID from RESERVATIONS where STATUS = 'pending')
	</cfquery>

	<cfquery name="update_res_status" datasource="#APP_dsn#">
		update	RESERVATIONS 
		set		STATUS = 'cancelled'
		where	STATUS = 'pending'				
	</cfquery>

