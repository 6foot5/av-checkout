
<cfparam name="attributes.startDate" default="#Now()#">
<cfparam name="attributes.advanceTime" default=168>
<cfparam name="attributes.deptID" default=0>

	<cfset countdown = 0>
	<cfset dayList = "">
	<cfset validDT = DateFormat(attributes.startDate,"m/d/yyyy")>
	
	<cfset APP_dsn = caller.APP_dsn>
	
	<cfloop condition="countdown LTE #attributes.advanceTime#">
		<cfmodule 
			template="#caller.APP_webroot#/#caller.APP_path_customtags#/get_hours.cfm"
			deptID="#attributes.deptID#"
			date="#validDT#">
		<cfif isOpen>
			<cfset dayList = ListAppend(dayList,validDT)>
		</cfif>		
		<cfset countdown = countdown + 24>
		<cfset validDT = DateFormat(DateAdd("h", 24, "#validDT#"),"m/d/yyyy")>
	</cfloop>
	
	<cfset caller.advanceDays = dayList>