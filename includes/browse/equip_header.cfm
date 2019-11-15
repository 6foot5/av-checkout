

	<cfset tmpRoles = ListToArray(form.roleList,",")>
	<cfset roleIDs = "">
	<cfloop index="x" from="1" to="#ArrayLen(tmpRoles)#">
		<cfset roleIDs = ListAppend(roleIDs,GetToken(tmpRoles[x],1,"|"))>
	</cfloop>

	<!--- <cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_user_roles_equip.cfm"
				deptID="#form.dept#"
				userID="#form.userID#"
				roleList="#roleIDs#"> --->			

	<cfquery name="get_equip" datasource="#APP_dsn#">
		select	DISTINCT E.EQUIP_ID, E.BARCODE, E.NAME, C.CAT_NAME, E.RES_LENGTH
		from	EQUIPMENT E, CATEGORIES C, EQUIP_ORG O, ROLES_EQUIP RE
		where	C.CAT_ID = O.CAT_ID and
				C.CAT_ID = #form.catID# and
				O.EQUIP_ID = E.EQUIP_ID and
				E.EQUIP_ID = RE.EQUIP_ID and 
				RE.ROLE_ID in (#roleIDs#) and
				RTRIM(LTRIM(E.STATUS)) = 'current' and
				RTRIM(LTRIM(E.AVAILABILITY)) = 'yes'
		order by 
				E.NAME, E.EQUIP_ID
	</cfquery>
	