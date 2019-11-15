
<cfparam name="attributes.dueDT" default="#Now()#">
<cfparam name="attributes.equipID" default=0>
<cfparam name="attributes.deptID" default=0>

<cfset cdate = DateFormat(Now(), "m/d/yyyy")>
<cfset ddate = DateFormat(Attributes.dueDT, "m/d/yyyy")>
<cfset cdateFull = CreateODBCDateTime(Now())>
<cfset ddateFull = CreateODBCDateTime(Attributes.dueDT)>

<cfset APP_dsn = caller.APP_dsn>

<cfset daysOff = 0>
<cfset idate = ddate>
<cfset fine = 0>

<cfloop condition="idate LT cdate">

	<cfmodule 
		template="#caller.APP_webroot#/#caller.APP_path_customtags#/get_hours.cfm"
		deptID="#attributes.deptID#"
		date="#idate#">
		
	<cfif NOT isOpen>
		<cfset daysOff = daysOff + 1>			
	</cfif>		
	
	<cfset idate = DateFormat(DateAdd("d", 1, idate))>

</cfloop>

<!--- <cfoutput>#ddate# - #cdate#<br></cfoutput> ---> 

<cfif attributes.equipID>
	<cfquery name="get_finesE" datasource="#caller.APP_dsn#">
		select	FINE_SCHEDULE
		from 	EQUIPMENT
		where	EQUIP_ID = #attributes.equipID#
	</cfquery>
	<cfset fineScheduleE = Trim(get_finesE.FINE_SCHEDULE)>
<cfelse>	
	<cfset fineScheduleE = "">
</cfif>

<cfif fineScheduleE NEQ "">

	<cfset fineSchedule = ListToArray(fineScheduleE)>

<cfelse>

	<cfquery name="get_finesD" datasource="#caller.APP_dsn#">
		select	FINE_SCHEDULE
		from 	DEPARTMENTS
		where	DEPT_ID = #attributes.deptID#
	</cfquery>

	<cfif Trim(get_finesD.FINE_SCHEDULE) NEQ "">

		<cfset fineSchedule = ListToArray(get_finesD.FINE_SCHEDULE)>

	<cfelse>

		<cfset fineSchedule = ArrayNew(1)>
		<cfset fineSchedule[1] = 0>

	</cfif>

</cfif>

<cfset numFines = ArrayLen(fineSchedule)>
<cfset totalDiff = DateDiff("h", ddateFull, cdateFull)>
<cfset offDiff = totalDiff - (daysOff * 24)>

<cfset index = 1>
<cfset nextFine = fineSchedule[1]>

<!--- 
2004.10.12
inserting code to make fines behave differently...
first hour *past due*, not past when fine starts.
for fines starting an hour or more after due, this first value will never get used, it'll jump right to first+second
first hour takes first value in array
rest of first day takes second value (make it zero to have entire first day take first value in array)
from there on, each day gets the next value in array. 
--->

<cfif offDiff GTE 0> <!--- this <cfif> is for the first hour --->

	<cfset fine = fine + nextFine>

	<cfif index GTE numFines>
		<cfset nextFine = nextFine>
	<cfelse>
		<cfset nextFine = fineSchedule[index+1]>
	</cfif>
	
	<cfset offDiff = offDiff - 1>
	
	<cfset index = index + 1>

</cfif>

<cfloop condition="offDiff GTE 0">
		
	<cfset fine = fine + nextFine>

	<cfif index GTE numFines>
		<cfset nextFine = nextFine>
	<cfelse>
		<cfset nextFine = fineSchedule[index+1]>
	</cfif>
	
	<cfif index EQ 2>
		<cfset offDiff = offDiff - 23> <!--- first hour of first day already was taken care of above loop 23 more to kill day one --->
	<cfelse>
		<cfset offDiff = offDiff - 24>
	</cfif>
	
	<cfset index = index + 1>
	
</cfloop>	

<cfset caller.fine = fine>
