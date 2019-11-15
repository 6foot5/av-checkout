	
	<cfset resLengths = ArrayNew(1)>

	<cfif form.existing>

		<cfquery name="getDT" datasource="#APP_dsn#">
			select 	RES_DT, DUE_DT
			from	RESERVATIONS
			where	RES_ID = #form.resID#
		</cfquery>

		<cfset resLengths = ArrayNew(1)>  
		<cfset resLengths[1] =ListToArray( DateDiff("n",getDT.RES_DT,getDT.DUE_DT) & "|" & DateFormat(getDT.DUE_DT,"m/d/yyyy") & "|" & TimeFormat(getDT.DUE_DT,"H:mm"))>
		<!--- make this element an array just to be consistent with recurring shizzle --->
		
	<cfelse>
	
		<cfloop index="rc" from="1" to="#ListLen(form.date)#">
			
			<cfset pickupDate = CreateODBCDateTime(GetToken(form.date,rc,",") & " " & GetToken(form.time,rc,","))>

			<cfset lengthList = "">
		
			<cfloop index="z" from="1" to="#ArrayLen(equipArray[rc])#">
				<cfif equipArray[rc][z] NEQ deletedConstant>
					<cfset tmpLength = GetToken(GetToken(equipArray[rc][z],1,"|"),4,"_")>		
					<cfif NOT ListContains(lengthList,tmpLength)>
						<!--- <cfset tmpDueDate = DateFormat(DateAdd("h",tmpLength,pickupDate),"m/d/yyyy")>
						<cfset tmpDueTime = TimeFormat(pickupTime,"H:mm")>
						<cfset lengthList = ListAppend(lengthList,"#tmpLength#|#tmpDueDate#|#tmpDueTime#")> --->
						<cfset lengthList = ListAppend(lengthList,tmpLength)>
					</cfif>
				</cfif>
			</cfloop>
			<!--- <cfoutput>#resLengthGen#</cfoutput> --->	
			<cfif lengthList EQ ""> <!--- *** Must make this a value from the department rules table - general res length...done *** --->
				<cfif resLengthExceptionDay NEQ "">
					<cfset lengthList = resLengthException> 
				<cfelse>
					<cfset lengthList = resLengthGen> 
				</cfif>
				<cfmodule 
					template="#APP_webroot#/#APP_path_customtags#/set_due_date.cfm"
					deptID="#form.dept#"
					resLength="#lengthList#"
					resOut="#pickupDate#">
				<cfset lengthList = newResLength> 
			<!--- <cfoutput>#newResLength#</cfoutput> --->	
			</cfif>
			
			<cfset lengthList = ListSort(lengthList,"numeric")>
			<cfset resLengths[rc] = ListToArray(lengthList)>
			
			<cfloop index="a" from="1" to="#ArrayLen(resLengths[rc])#">
				<cfset tmpDueDate = DateFormat(DateAdd("n",resLengths[rc][a],pickupDate),"m/d/yyyy")>
				<cfset tmpDueTime = TimeFormat(DateAdd("n",resLengths[rc][a],pickupDate),"H:mm")>
				<cfset resLengths[rc][a] = resLengths[rc][a] & "|#tmpDueDate#|#tmpDueTime#">
			</cfloop>
	
		</cfloop>

	</cfif>
	
	<cfset resLengthsList = ArrayNew(1)>
	
	<cfloop index="hl" from="1" to="#ArrayLen(resLengths)#">
		<cfset resLengthsList[hl] = ArrayToList(resLengths[hl])>
	</cfloop>
	<cfset new_length_list = ArrayToList(resLengthsList,"^")>

	<cfoutput>
		<input type="hidden" name="length_list" value="#new_length_list#">
	</cfoutput>
	
	
	<!--- *** NEED TO ACTUALLY CHECK HOURS HERE - NO!!! actually do all checks on equip insert *** --->
	
	
	
		