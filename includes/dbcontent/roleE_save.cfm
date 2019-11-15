

	<cfset equipArray = ListToArray(form.oEquip)>

	<cfquery name="insert_org" datasource="#APP_dsn#">
		
		delete
		from	ROLES_EQUIP
		where	ROLE_ID = #form.oRole#;
		
		<cfloop index="x" from="1" to="#ArrayLen(equipArray)#">
			insert into	ROLES_EQUIP 
					(ROLE_ID,EQUIP_ID)
			values		
				(#form.oRole#,#equipArray[x]#);
		</cfloop>
		
	</cfquery>	
