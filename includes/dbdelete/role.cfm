

<cfquery name="delete" datasource="#APP_dsn#">
	delete
	from	ROLES_CLASSES
	where	ROLE_ID = #dbDeleteID#;

	delete
	from	ROLES_EQUIP
	where	ROLE_ID = #dbDeleteID#;

	delete
	from	ROLES_USERS
	where	ROLE_ID = #dbDeleteID#;

	delete
	from	ROLES
	where	ROLE_ID = #dbDeleteID#;
</cfquery>

