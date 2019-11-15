

	<cfset equipArray = ListToArray(form.oEquip)>

	<cfquery name="insert_org" datasource="#APP_dsn#">
		
		delete
		from	EQUIP_ORG
		where	CAT_ID = #form.oCat#;
		
		<cfloop index="x" from="1" to="#ArrayLen(equipArray)#">
			insert into	EQUIP_ORG 
					(CAT_ID,EQUIP_ID)
			values		
				(#form.oCat#,#equipArray[x]#);
		</cfloop>
		
	</cfquery>	
