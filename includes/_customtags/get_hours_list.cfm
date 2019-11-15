
<cfparam name="attributes.date" default="#Now()#">
<cfparam name="attributes.deptID" default=0>

	<cfset APP_dsn = caller.APP_dsn>
	
	<cfmodule 
		template="#caller.APP_webroot#/#caller.APP_path_customtags#/get_hours.cfm"
		deptID="#attributes.deptID#"
		date="#attributes.Date#">

	<cfif isOpen>
	
		<cfset hours = ListToArray(hoursString)>
		<cfset timesList = "">
		<cfif DateFormat(attributes.Date,"m/d/yyyy") EQ DateFormat(Now(),"m/d/yyyy")>
			<cfset validTime = TimeFormat(Now(), "H:mm")>
			<cfmodule 
				template="#caller.APP_webroot#/#caller.APP_path_customtags#/adjust_time.cfm"
				rawTime="#validTime#">
			<cfset validTime = adjustedTime>
		<cfelse>	
			<cfset validTime = TimeFormat(GetToken(hours[1],1,"-"), "H:mm")>
		</cfif>
		
		<cfloop index="x" from="1" to="#ArrayLen(hours)#">

			<cfset startTime = TimeFormat(GetToken(hours[x],1,"-"), "H:mm")>
			<cfset endTime = TimeFormat(GetToken(hours[x],2,"-"), "H:mm")>

			<cfif validTime LTE startTime>
				<cfset tempTime = startTime>
				<cfloop condition="#tempTime# LTE #endTime#">
					<cfset timesList = ListAppend(timesList,TimeFormat(tempTime,"H:mm"))>
					<cfset tempTime = DateAdd("n",15,tempTime)>				
				</cfloop>
			<cfelseif validTime GT startTime AND validTime LTE endTime>
				<cfset tempTime = validTime>
				<cfloop condition="#tempTime# LTE #endTime#">
					<cfset timesList = ListAppend(timesList,TimeFormat(tempTime,"H:mm"))>
					<cfset tempTime = DateAdd("n",15,tempTime)>				
				</cfloop>
			</cfif>
		
		</cfloop>
			
		<cfset caller.timesList = timesList>
	
	<cfelse>
	
		<cfset caller.timesList = "">
	
	</cfif>

