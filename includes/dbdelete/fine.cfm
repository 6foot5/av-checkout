

<cfquery name="delete" datasource="#APP_dsn#">
	delete
	from	FINES
	where	FINE_ID = #dbDeleteID#;
</cfquery>

