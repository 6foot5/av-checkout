

<cfquery name="delete" datasource="#APP_dsn#">
	update	RES_DETAILS
	set		STATUS = 'cancelled'
	where	RES_ID = #dbDeleteID#;
	
	update	RESERVATIONS
	set		STATUS = 'cancelled'
	where	RES_ID = #dbDeleteID#;
</cfquery>

