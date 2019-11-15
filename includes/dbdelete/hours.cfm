

<cfquery name="delete" datasource="#APP_dsn#">
	delete
	from	HOURS_DEF
	where	HOURS_ID = #dbDeleteID#;

	delete
	from	HOURS_DETAIL
	where	HOURS_ID = #dbDeleteID#;
</cfquery>

