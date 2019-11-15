

<cfquery name="delete" datasource="#APP_dsn#">
	update	ACCESSORY_PKG
	set 	STATUS = 'deleted'
	where	PKG_ID = #dbDeleteID#;

	update	ACCESSORIES
	set 	STATUS = 'deleted'
	where	PKG_ID = #dbDeleteID#;
</cfquery>

