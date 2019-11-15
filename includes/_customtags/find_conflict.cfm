
<cfparam name="attributes.resOut" default="#Now()#">
<cfparam name="attributes.resLength" default="24">

<cfset pickupDT = CreateODBCDateTime(attributes.resOut)>
<cfset dueDT = CreateODBCDateTime(DateAdd("h",attributes.resLength,pickupDT)>

<cfquery name="check_res" datasource="#caller.APP_dsn#">
	select	*
	from 	RES_DETAILS RD, RESERVATIONS R
	where	RD.RES_ID = R.RES_ID and
			RD.EQUIP_ID = #get_equip.EQUIP_ID# and
			( 	
				RTRIM(LTRIM(RD.STATUS)) = 'checked' or
				(	
					RTRIM(LTRIM(RD.STATUS)) = 'open' and
					(#pickupDT# <= R.RES_DT <!--- or #pickupDT# <= R.DUE_DT --->)
				)  <!--- ****** FIX THIS SHIT!!! ---> 
			)  
</cfquery>

	<cfset caller.validEquip = "no">
	<cfset caller.hoursString = "none">
	

