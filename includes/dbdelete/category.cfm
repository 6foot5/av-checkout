

<cfquery name="delete" datasource="#APP_dsn#">
	delete
	from	CATEGORIES
	where	CAT_ID = #dbDeleteID#;

	delete
	from	EQUIP_ORG
	where	CAT_ID = #dbDeleteID#;
</cfquery>

