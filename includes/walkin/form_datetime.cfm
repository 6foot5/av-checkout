
<cfoutput>

	<p><b>Pickup Date(s) &amp; Time(s):</b><br><br>
	
	<cfloop index="p" from="1" to="#ListLen(form.date)#">
		
		<cfset pickup = CreateODBCDateTime(GetToken(form.date,p,",") & " " & GetToken(form.time,p,","))>

		<cfif form.status EQ "ready">
			
			<cfmodule 
				template="#APP_webroot#/#APP_path_customtags#/set_due_date.cfm"
				deptID="#form.dept#"
				resLength="0"
				resOut="#pickup#">
		
			<cfset pickupDate = DateFormat(dueDate,"m/d/yyyy")>
			<cfset pickupTime = TimeFormat(dueDate, "H:mm")>
		
			<cfmodule 
				template="#APP_webroot#/#APP_path_customtags#/adjust_time.cfm"
				rawTime="#pickupTime#">
						
			<cfset pickupTime = adjustedTime>

		<cfelse>
		
			<cfset pickupDate = DateFormat(pickup,"m/d/yyyy")>
			<cfset pickupTime = TimeFormat(pickup, "H:mm")>
			
		</cfif>
		
		#DateFormat(pickupDate,"dddd, mmm d")#, #TimeFormat(pickupTime,"h:mm tt")#<br>

	</cfloop>	
	</p>

</cfoutput>
