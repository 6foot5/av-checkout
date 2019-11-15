
	<cfset lenArray = ListToArray(form.length_list,"^")>	

	<cfset resLengths = ArrayNew(1)>

	<cfloop index="ii" from="1" to="#ListLen(form.date)#">  
		<cfset resLengths[ii] = ListToArray(lenArray[ii])>
	</cfloop>

	<!--- <cfset resLengths = ListToArray(form.length_list)> --->

	<cfloop index="rs" from="1" to="#ListLen(form.date)#">
	
		<cfloop index="d" from="1" to="#ArrayLen(resLengths[rs])#">
			
			<cfset rLength = GetToken(resLengths[rs][d],1,"|")>
			<cfset dueDT = GetToken(resLengths[rs][d],2,"|") & " " & GetToken(resLengths[rs][d],3,"|")>
			<!--- <cfset dDate = GetToken(resLengths[d],2,"|")> 
			<cfset dTime = GetToken(resLengths[d],3,"|")> --->
			<cfset noteName = "form.notes" & rLength & rs>
			<cfset miscName = "form.misc" & rLength & rs>
			<!--- <cfoutput>#noteName#, #resLengths[d]#</cfoutput> --->
			<cfset formNotes = Evaluate(noteName)>
			<cfset formMisc = Evaluate(miscName)>
			<cfset pickupDT = CreateODBCDateTime(GetToken(form.date,rs,",") & " " & GetToken(form.time,rs,","))>
			<cfif form.type EQ "res">
				<cfset outDT = pickupDT>
			<cfelse>
				<cfset outDT = CreateODBCDateTime(Now())>
			</cfif>
			<cfset dueDT = CreateODBCDateTime(dueDT)>
	
			<cfif form.existing>
	
				<cfset currResID = form.resID>
				
				<cfquery name="updateRes" datasource="#APP_dsn#">
					update	RESERVATIONS
					set		OUT_DT = #outDT#, STATUS='checked', RES_NOTES='#formNotes#', NOTES='#formMisc#', INITIALS='#form.initials#'
					where 	RES_ID = #form.resID#;
	
					update	RES_DETAILS
					set		STATUS='checked'
					where 	RES_ID = #form.resID#;
				</cfquery>
					
			<cfelse>
			
				<cfif form.type EQ "walkin">
					<cfset resType = "w">
				<cfelse>
					<cfset resType = "r">
				</cfif>
	
				<cftransaction action="begin">
		
					<cfquery name="insertRes" datasource="#APP_dsn#">
						insert into	RESERVATIONS
							(USER_ID, DEPT_ID, RES_DT, OUT_DT, DUE_DT, RES_TYPE, STATUS, NOTES, RES_NOTES, INITIALS)
						values
							(#form.userID#, #form.dept#, #pickupDT#, #outDT#, #dueDT#, '#resType#', '#setResStatus#', '#formMisc#', '#formNotes#', '#form.initials#')
					</cfquery>
		
					<cfquery name="getNew" datasource="#APP_dsn#">
						select 	max(RES_ID) as newResID
						from	RESERVATIONS
					</cfquery>
					
				</cftransaction>
				
				<cfset currResID = getNew.newResID>
				
				<cfloop index="i" from="1" to="#ArrayLen(equipArray[rs])#">
				
					<cfif equipArray[rs][i] NEQ deletedConstant AND GetToken(GetToken(equipArray[rs][i],1,"|"),4,"_") EQ rLength>
				
						<cfset addEquipID = GetToken(GetToken(equipArray[rs][i],1,"|"),1,"_")>
						<cfset accList = "">
						
						<cfif GetToken(equipArray[rs][i],2,"|")	NEQ "empty">
							<cfset accArray = ListToArray(GetToken(equipArray[rs][i],2,"|"),"~")>
							<cfloop index="x" from="1" to="#ArrayLen(accArray)#">
								<cfif accArray[x] NEQ deletedConstant>
									<cfset accList = ListAppend(accList,GetToken(accArray[x],1,"_"))>
								</cfif>
							</cfloop>
						</cfif>
						
						<cfquery name="insertDetails" datasource="#APP_dsn#">
							insert into	RES_DETAILS
								(RES_ID, EQUIP_ID, ACC_LIST, STATUS)
							values
								(#getNew.newResID#, #addEquipID#, '#accList#', '#setResStatus#')
						</cfquery>
					
					</cfif>
				
				</cfloop>
	
			</cfif>		
				
		</cfloop>
	
	</cfloop>
										

	<!--- BEGIN EMAIL RECEIPT TO USER --->

	<cfif setResStatus EQ "checked">
	
		<cfquery name="get_email" datasource="#APP_dsn#">
			select 	EMAIL, FIRST_NAME, LAST_NAME
			from	USERS
			where 	USER_ID = #form.userID#;
		</cfquery>
	
		<cfquery name="get_dept_email" datasource="#APP_dsn#">
			select 	DEPT_EMAIL
			from	DEPARTMENTS
			where 	DEPT_ID = #form.dept#;
		</cfquery>
	
		<!--- make dept email a DB variable, not hardcoded! --->
	
		<cfmail
			to="#get_email.EMAIL#"
			from="#get_dept_email.DEPT_EMAIL#"
			subject="Equipment Checkout Receipt"
			server="[MAIL-SERVER]"> 						
Dear #get_email.FIRST_NAME# #get_email.LAST_NAME#: 

The following is a summary of your checkout:
	<cfloop index="d" from="1" to="#ArrayLen(resLengths[1])#"><cfset rLength = GetToken(resLengths[1][d],1,"|")><cfset dueDT = GetToken(resLengths[1][d],2,"|") & " " & GetToken(resLengths[1][d],3,"|")><cfset noteName = "form.misc" & rLength & "1"><cfset formNotes = Evaluate(noteName)><cfset pickupDT = CreateODBCDateTime(GetToken(form.date,1,",") & " " & GetToken(form.time,1,","))><cfset dueDT = CreateODBCDateTime(dueDT)>
-------- Items Due on #DateFormat(dueDT,"dddd, m/d/yy")# BEFORE #TimeFormat(dueDT,"h:mm tt")# --------
<cfloop index="i" from="1" to="#ArrayLen(equipArray[1])#"><cfif equipArray[1][i] NEQ deletedConstant AND GetToken(GetToken(equipArray[1][i],1,"|"),4,"_") EQ rLength><cfset addEquipID = GetToken(GetToken(equipArray[1][i],1,"|"),1,"_")><cfset accList = "">		
* #GetToken(GetToken(equipArray[1][i],1,"|"),3,"_")#	<cfif GetToken(equipArray[1][i],2,"|")	NEQ "empty"><cfset accArray = ListToArray(GetToken(equipArray[1][i],2,"|"),"~")>
	Accessories (<cfloop index="x" from="1" to="#ArrayLen(accArray)#"><cfif accArray[x] NEQ deletedConstant><cfset accList = ListAppend(accList,GetToken(accArray[x],1,"_"))>#GetToken(accArray[x],2,"_")#, </cfif></cfloop>)</cfif></cfif></cfloop>
	
#formNotes#
</cfloop>
		
		</cfmail>
	
	</cfif>
	
	
