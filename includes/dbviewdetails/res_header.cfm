

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	DEPT_NAME, FIRST_NAME, LAST_NAME, EMAIL, PHONE1, PHONE2, PHONE3, RES_DT, OUT_DT, DUE_DT, RETURN_DT, RES_TYPE, STATUS, R.NOTES
		from	RESERVATIONS R, USERS U, DEPARTMENTS D
		where	R.RES_ID = #url.itemID# and
				R.DEPT_ID = D.DEPT_ID and
				R.USER_ID = U.USER_ID
	</cfquery>
	
	
	 <cfquery name="get_equip" datasource="#APP_dsn#">
		select	NAME, BARCODE, ACC_PKG, ACC_LIST, ITEM_RETURN_DT
		from	EQUIPMENT E, RES_DETAILS R
		where	R.RES_ID = #url.itemID# and
				R.EQUIP_ID = E.EQUIP_ID
		order by
				NAME
	</cfquery>
	
	<!---<cfquery name="get_users" datasource="#APP_dsn#">
		select	FIRST_NAME, LAST_NAME
		from	USERS U, ROLES_USERS R
		where	R.ROLE_ID = #url.itemID# and
				R.USER_ID = U.USER_ID
		order by
				LAST_NAME
	</cfquery>
	
	<cfquery name="get_classes" datasource="#APP_dsn#">
		select	PS_CLASS_NAME
		from	ROLES_CLASSES 
		where	ROLE_ID = #url.itemID# 
		order by
				PS_CLASS_NAME
	</cfquery> --->
	
	
