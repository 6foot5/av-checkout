
	<cfset allCheckedIn = "yes">
	<cfset equipIn = ArrayNew(1)>
	<cfset numIn = 0>
	<cfloop index="c" from="1" to="#ArrayLen(equipArray[1])#">
		<cfif GetToken(GetToken(equipArray[1][c],1,"|"),7,"_") EQ "out">
			<cfset allCheckedIn = "no">
		<cfelse>
			<cfset numIn = numIn + 1>
			<cfset equipIn[numIn] = GetToken(GetToken(equipArray[1][c],1,"|"),1,"_")>	
		</cfif>
	</cfloop>
	
	<cfset rightNow = DateFormat(Now(),"m/d/yyyy") & " " & TimeFormat(Now(),"H:mm")>
	<cfset rightNow = CreateODBCDateTime(rightNow)>

	<cfquery name="update_res" datasource="#APP_dsn#">
		update	RESERVATIONS
		set		INITIALS=(INITIALS+',#form.initials#')
		where	RES_ID = #form.resID#;
	</cfquery>

	<cfif allCheckedIn>
		<cfquery name="update_res" datasource="#APP_dsn#">
			<cfif form.miscOutstanding EQ "on">
				update	RESERVATIONS
				set		STATUS = 'closed', RETURN_DT = #rightNow#
				where	RES_ID = #form.resID#;
			</cfif>

			update	RES_DETAILS
			set		STATUS = 'closed', ITEM_RETURN_DT = #rightNow#
			where	RES_ID = #form.resID#;
		</cfquery>
		
		<cfif form.fine and (form.miscOutstanding EQ "on")>
			<cfquery name="insertFine" datasource="#APP_dsn#">
				insert into	FINES 
					(RES_ID, AMOUNT, STATUS)
				values
					(#form.resID#, #form.fine#, 'open')	
			</cfquery>		
		</cfif>
	<cfelse>
		<cfquery name="update_res" datasource="#APP_dsn#">
			update	RES_DETAILS
			set		STATUS = 'closed', ITEM_RETURN_DT = #rightNow#
			where	RES_ID = #form.resID# AND (
					<cfloop index="u" from="1" to="#ArrayLen(equipIn)#">
						EQUIP_ID = #equipIn[u]# OR
					</cfloop> 1 = 0)
		</cfquery>
	</cfif>