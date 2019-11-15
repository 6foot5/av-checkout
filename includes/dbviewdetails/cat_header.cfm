

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	DEPT_NAME, CAT_ID, CAT_NAME, C.NOTES
		from	CATEGORIES C, DEPARTMENTS D
		where	C.CAT_ID = #url.itemID# and
				C.DEPT_ID = D.DEPT_ID
	</cfquery>
	
	
	<cfquery name="get_equip" datasource="#APP_dsn#">
		select	NAME, BARCODE
		from	EQUIPMENT E, EQUIP_ORG O
		where	O.CAT_ID = #url.itemID# and
				O.EQUIP_ID = E.EQUIP_ID
	</cfquery>
	
	
