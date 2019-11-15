

<cfquery name="delete" datasource="#APP_dsn#">
	update	EQUIPMENT
	set		STATUS = 'deleted'
	where	EQUIP_ID = #dbDeleteID#;
	
	delete
	from	EQUIP_ORG
	where	EQUIP_ID = #dbDeleteID#;

	delete
	from	ROLES_EQUIP
	where	EQUIP_ID = #dbDeleteID#;
</cfquery>

