

	<cfparam name="form.oUsers" default="">

	<cfset usersArray = ListToArray(form.oUsers)>

	<cfquery name="insert_org" datasource="#APP_dsn#">
		
		delete
		from	ROLES_USERS
		where	ROLE_ID = #form.oRole#;
		
		<cfloop index="x" from="1" to="#ArrayLen(usersArray)#">
			insert into	ROLES_USERS 
					(ROLE_ID,USER_ID)
			values		
				(#form.oRole#,#usersArray[x]#);
		</cfloop>
		
	</cfquery>	
