

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	DEPT_NAME, BARCODE, NAME, ACC_PKG, SERIAL, E.NOTES, AVAILABILITY, RES_LENGTH
		from	EQUIPMENT E, DEPARTMENTS D
		where	E.EQUIP_ID = #url.itemID# and
				E.DEPT_ID = D.DEPT_ID
	</cfquery>
	
	<cfif get_content.ACC_PKG NEQ "">
		<cfset accExists = "yes">
		<cfquery name="get_acc" datasource="#APP_dsn#">
			select	PKG_NAME
			from	ACCESSORY_PKG
			where	PKG_ID = '#get_content.ACC_PKG#'
		</cfquery>
		<cfset pName = get_acc.PKG_NAME>
	<cfelse>
		<cfset accExists = "no">
		<cfset pName = "None">
	</cfif>
	
	<cfquery name="get_cats" datasource="#APP_dsn#">
		select	CAT_NAME
		from	CATEGORIES C, EQUIP_ORG O
		where	O.EQUIP_ID = #url.itemID# and
				O.CAT_ID = C.CAT_ID
	</cfquery>
