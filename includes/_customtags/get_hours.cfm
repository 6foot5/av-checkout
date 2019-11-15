
<cfparam name="attributes.date" default="#Now()#">
<cfparam name="attributes.deptID" default=0>

<cfset hoursDate = DateFormat(attributes.date, "m/d/yyyy")>
<cfset hoursDOW = DateFormat(attributes.date, "dddd")>

<cfquery name="get_hoursOR" datasource="#caller.APP_dsn#">
	select	*
	from 	HOURS_DEF
	where	DATE_ON <= #CreateODBCDate(hoursDate)# and
			DATE_OFF >= #CreateODBCDate(hoursDate)# and
			TYPE = 'override' and
			DEPT_ID = #attributes.deptID#
</cfquery>

<cfif get_hoursOR.RecordCount EQ 0>
	
	<cfquery name="get_hoursNOR" datasource="#caller.APP_dsn#">
		select	*
		from 	HOURS_DEF
		where	DATE_ON <= #CreateODBCDate(hoursDate)# and
				DATE_OFF >= #CreateODBCDate(hoursDate)# and
				TYPE = 'normal' and
				DEPT_ID = #attributes.deptID#
	</cfquery>
	
	<cfif get_hoursNOR.RecordCount EQ 0>
		
		<cfset isOpen = "no">
	
	<cfelse>
	
		<cfset isOpen = "yes">
		<cfset hoursID = get_hoursNOR.HOURS_ID>

	</cfif>
	
<cfelse>

		<cfset isOpen = "yes">
		<cfset hoursID = get_hoursOR.HOURS_ID>

</cfif>

<cfif isOpen>

	<cfquery name="get_hoursDetail" datasource="#caller.APP_dsn#">
		select	*
		from 	HOURS_DETAIL
		where	HOURS_ID = #hoursID# and
				DOW = '#hoursDOW#'
	</cfquery>
	
	<cfif get_hoursDetail.RecordCount EQ 0>
		
		<cfset caller.isOpen = "no">
		<cfset caller.hoursString = "none">
	
	<cfelse>
	
		<cfset caller.isOpen = "yes">
		<cfset caller.hoursString = get_hoursDetail.DAILY_HOURS>
	
	</cfif>

<cfelse>

	<cfset caller.isOpen = "no">
	<cfset caller.hoursString = "none">
	
</cfif>
	
