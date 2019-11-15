

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	U.FIRST_NAME, U.LAST_NAME, R.DUE_DT, R.RETURN_DT, U.EMAIL, U.PHONE1, U.PHONE2, U.PHONE3, R.NOTES, F.AMOUNT, F.SETTLE_DATE, F.STATUS
		from	RESERVATIONS R, USERS U, FINES F
		where	F.FINE_ID = #url.itemID# and
				F.RES_ID = R.RES_ID and
				R.USER_ID = U.USER_ID
	</cfquery>
	
	
	 <cfquery name="get_equip" datasource="#APP_dsn#">
		select	NAME, BARCODE, ACC_PKG, ACC_LIST, ITEM_RETURN_DT
		from	EQUIPMENT E, RES_DETAILS R, FINES F
		where	R.RES_ID = F.RES_ID and
				F.FINE_ID = #url.itemID# and
				R.EQUIP_ID = E.EQUIP_ID
		order by
				NAME
	</cfquery>
	
 	
