
<cfparam name="attributes.resOut" default="#Now()#">
<cfparam name="attributes.resLength" default=0>
<cfparam name="attributes.deptID" default=0>

<cfset pickupDT = CreateODBCDateTime(attributes.resOut)>
<cfset defaultDueTime = TimeFormat(DateAdd("h",attributes.resLength,pickupDT),"H:mm")>

<cfset APP_dsn = caller.APP_dsn> <!--- this is set so that the custom tag used below can reference the dsn variable --->

<cfset dueDT = DateFormat(DateAdd("h",attributes.resLength,pickupDT),"m/d/yyyy")>
<cfset isBadDate = "yes">

<cfset extraDays = 0>

<cfif attributes.resLength EQ -1>
	<cfmodule 
		template="#caller.APP_webroot#/#caller.APP_path_customtags#/get_hours.cfm"
		deptID="#attributes.deptID#"
		date="#pickupDT#">
	<cfset hours = ListToArray(hoursString)>
	<cfset timeClose = TimeFormat(GetToken(hours[ArrayLen(hours)],2,"-"), "H:mm")>
	<cfset todayClose = DateFormat(pickupDT, "m/d/yyyy") & " " & timeClose>
	<cfset todayClose = CreateODBCDateTime(todayClose)>
	<cfset isBadDate = "no">
	<cfset dueTimeDefined = "yes">
	<cfset caller.dueDate = todayClose>
</cfif>

<!--- <cfoutput>
	#dueDT#, #attributes.resLength#, #pickupDT#<br>
</cfoutput> --->

<cfloop condition="#isBadDate#">

	<cfmodule 
		template="#caller.APP_webroot#/#caller.APP_path_customtags#/get_hours.cfm"
		deptID="#attributes.deptID#"
		date="#dueDT#">
	
	<cfif isOpen>
		<cfset isBadDate = "no">
		<cfset hours = ListToArray(hoursString)>
	<cfelse>
		<cfset extraDays = extraDays + 1>
		<cfset dueDT = DateFormat(DateAdd("d", 1, "#dueDT#"),"m/d/yyyy")>
	</cfif>
	
	<!--- if default due time is later than closing on first available due date, continue to next available due date. --->
	<!--- <cfif NOT isBadDate AND (extraDays EQ 0) AND (defaultDueTime GT TimeFormat(GetToken(hours[ArrayLen(hours)],2,"-"), "H:mm")) and (attributes.resLength)>
		<cfset dueDT = DateFormat(DateAdd("d", 1, "#dueDT#"),"m/d/yyyy")>
		<cfset isBadDate = "yes">		
	</cfif> --->
	
</cfloop>


<cfset dueTimeDefined = "no">

<cfloop index="x" from="1" to="#ArrayLen(hours)#">

	<cfif NOT dueTimeDefined>

		<cfset timeStart = TimeFormat(GetToken(hours[x],1,"-"), "H:mm")>
		<cfset timeEnd = TimeFormat(GetToken(hours[x],2,"-"), "H:mm")>
		
		<!--- <cfif extraDays GT 0>
			<cfset dueTime = timeStart>		
			<cfset dueTimeDefined = "yes">
		<cfelse> --->
			<cfif defaultDueTime LT timeStart>
				<cfset dueTime = timeStart>
				<cfset dueTimeDefined = "yes">
			<cfelseif defaultDueTime GTE timeStart AND defaultDueTime LTE timeEnd>
				<cfset dueTime = defaultDueTime>
				<cfset dueTimeDefined = "yes">
			<cfelse>
				<cfif x EQ ArrayLen(hours)>
					<cfset dueTime = timeEnd>
					<cfset dueTimeDefined = "yes">
				</cfif>
			</cfif>
		<!--- </cfif> --->

	</cfif>

</cfloop>

<cfif attributes.resLength NEQ -1>
	<cfset caller.dueDate = DateFormat(dueDT,"m/d/yyyy") & " " & TimeFormat(dueTime,"H:mm")>
</cfif>

<!--- <cfoutput><br>#pickupDT# + #caller.dueDate#<br><br></cfoutput> --->
<cfset caller.newResLength = DateDiff("n",pickupDT,caller.dueDate)>

<!--- <cfoutput>
	pickup: #pickupDT#<br>len: #attributes.resLength#<br>extradays: #extraDays#<br>due: #dueDT#<br>default: #defaultDueTime#<br>due: #dueTime#<br>hours: #hoursString#
</cfoutput><br> --->


<!--- <cfquery name="check_res" datasource="#caller.APP_dsn#">
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
	<cfset caller.hoursString = "none"> --->
	

