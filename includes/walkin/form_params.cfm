
	<cfparam name="url.resID" default=0>
	<cfparam name="url.deptID" default=0>
	<cfparam name="url.dept" default=0>
	<cfparam name="url.psid" default="">
	<cfparam name="url.time" default="">
	<cfparam name="url.date" default="">
	<cfparam name="url.type" default="">
	<cfparam name="url.specialResType" default="normal">
	<cfparam name="url.existing" default="no">
	<cfparam name="url.status" default="ready">

	<cfparam name="form.existing" default="#url.existing#">
	<cfparam name="form.date" default="#url.date#">
	<cfparam name="form.time" default="#url.time#">
	<cfparam name="form.status" default="#url.status#">
	<cfparam name="form.dept" default="#url.dept#">
	<cfparam name="form.from" default="home">
	<cfparam name="form.psid" default="#url.psid#">
	<cfparam name="form.DT" default="no">
	<cfparam name="form.formatDT" default="no">
	<cfparam name="form.resID" default="#url.resID#">
	<cfparam name="form.specialResType" default="#url.specialResType#">
	<cfparam name="form.specialStartDate" default="">
	<cfparam name="form.specialEndDate" default="">

	<cfif form.formatDT>
	
		<cfset dateList = ListToArray(form.DT,",")>
		<cfset form.time = "">
		<cfset form.date = "">
		
		<cfloop index="x" from="1" to="#ArrayLen(dateList)#">
			<cfset form.time = ListAppend(form.time,GetToken(dateList[x],2,"|"))>
			<cfset form.date = ListAppend(form.date,GetToken(dateList[x],1,"|"))>
		</cfloop>

	</cfif>
	
	
	<!--- 
	
	Check user's account to make sure they are cleared to checkout 
	
	--->

	<cfquery name="check_user" datasource="#APP_dsn#">
		select	*
		from	USERS
		where	RTRIM(LTRIM(PSID))='#Trim(form.psid)#' AND
				(
					RTRIM(LTRIM('|'+DEPT_OWNER+'|')) LIKE '|#form.dept#,%' OR
					RTRIM(LTRIM(DEPT_OWNER)) LIKE '%,#form.dept#,%' OR
					RTRIM(LTRIM('|'+DEPT_OWNER+'|')) LIKE '%,#form.dept#|' OR
					RTRIM(LTRIM(DEPT_OWNER)) = '#form.dept#'
				) 
	</cfquery>
	
	<cfif NOT check_user.recordcount>
	
		<script LANGUAGE="JavaScript">
		<!--
			alert("The user with [ORG-NAME] ID <cfoutput>#Trim(form.psid)#</cfoutput> is not cleared to check out equipment for the department selected.");
			window.location.replace('home.cfm');
		//-->
		</script>			

	</cfif>

	
	<cfif form.status EQ "ready">
	
		<cfset tmpDates = ListToArray(form.date)>
		<cfset tmpTimes = ListToArray(form.time)>
		
		<cfloop index="d" from="1" to="#ArrayLen(tmpDates)#">
		
			<cfset pickupDate = DateFormat(tmpDates[d],"m/d/yyyy")>
			<cfset pickupTime=TimeFormat(tmpTimes[d], "H:mm")>
			<cfset pickup = pickupDate & " " & pickupTime>
	
			<cfmodule 
				template="#APP_webroot#/#APP_path_customtags#/set_due_date.cfm"
				deptID="#form.dept#"
				resLength="0"
				resOut="#pickup#">
	
			<cfset tmpDates[d] = DateFormat(dueDate,"m/d/yyyy")>
	
			<cfset tempTime = TimeFormat(dueDate, "H:mm")>
	
			<cfmodule 
				template="#APP_webroot#/#APP_path_customtags#/adjust_time.cfm"
				rawTime="#tempTime#">
	
			<cfset tmpTimes[d] = TimeFormat(adjustedTime, "H:mm")>

		</cfloop>

		<cfset form.time = ArrayToList(tmpTimes)>
		<cfset form.date = ArrayToList(tmpDates)>

		<!--- <cfset today = DateFormat(Now(),"m/d/yyyy")>
		<cfset currentTime=TimeFormat(Now(), "H:mm")>
		<cfparam name="form.date" default="#today#">
		<cfparam name="form.time" default="#currentTime#"> --->
	</cfif>

	<cfparam name="form.URL" default="">
	<cfparam name="form.equipID" default=0>
	<cfparam name="form.length_list" default="">
	<cfparam name="form.complete" default="no">
	<cfparam name="form.add" default="no">
	<cfparam name="form.removeID" default=0>

	<cfif form.existing>
		<cfquery name="get_notes" datasource="#APP_dsn#">
			select	RES_NOTES, NOTES, INITIALS
			from	RESERVATIONS
			where	RES_ID = #url.resID#
		</cfquery>
		<cfset miscNotes = get_notes.NOTES>
		<cfset resNotes = get_notes.RES_NOTES>
		<!--- <cfset empInitials = get_notes.INITIALS> need to be fresh each time--->
		<cfset empInitials = "">
	<cfelse>
		<cfset miscNotes = "">
		<cfset resNotes = "">
		<cfset empInitials = "">
	</cfif>		

	<cfparam name="form.initials" default="#empInitials#">
	<cfparam name="form.notes" default="#miscNotes#"> <!--- this stores the misc items --->
	<cfparam name="form.resNotes" default="#resNotes#">
	<cfparam name="form.adminUser" default="yes">
	<cfparam name="form.updateStatus" default="no">
	<cfparam name="form.type" default="#url.type#">
	<cfparam name="form.userID" default="">
	<cfparam name="form.userName" default="">
	<cfparam name="form.userEmail" default="">
	<cfparam name="form.userPhone" default="">
	<cfparam name="form.roleList" default="">
	<cfparam name="form.adminDepts" default="">
	<cfparam name="form.adminType" default="">
	
	<cfset EquipList = ""> 
	<cfset existingResBadEquip = 0>
	<cfset existingResBadEquipMsg = "">
	
	<cfif url.resID>

		<cfquery name="get_res_equip" datasource="#APP_dsn#">
			select	E.EQUIP_ID, E.BARCODE, E.NAME, E.RES_LENGTH, R.RES_DT, R.DUE_DT, RD.ACC_LIST
			from 	EQUIPMENT E, RES_DETAILS RD, RESERVATIONS R
			where	RD.RES_ID = #url.resID# and
					RD.RES_ID = R.RES_ID and
					E.EQUIP_ID = RD.EQUIP_ID
		</cfquery>

		<cfloop query="get_res_equip">

			<cfquery name="check_res_existing" datasource="#APP_dsn#">
				select	*
				from 	RES_DETAILS RD, RESERVATIONS R
				where	RD.RES_ID = R.RES_ID and
						RD.EQUIP_ID = #get_res_equip.EQUIP_ID# and
						(
							RTRIM(LTRIM(RD.STATUS)) = 'checked'
						)
			</cfquery> 
			
			<cfif check_res_existing.recordcount>

				<cfset existingResBadEquip = existingResBadEquip + 1>
				<cfset existingResBadEquipMsg = existingResBadEquipMsg & "\r\r#NAME# (#BARCODE#)">

			<cfelse>

				<cfset itemDueDate = DateFormat(DUE_DT,"m/d/yyyy") & " " & TimeFormat(DUE_DT,"H:mm")>
				<cfset itemResLength = DateDiff("n",RES_DT,DUE_DT)>
				
				<cfmodule 
					template="#APP_webroot#/#APP_path_customtags#/build_equip_list.cfm"
					equipID="#EQUIP_ID#"
					barcode="#BARCODE#"
					equipName="#NAME#"
					resLength="#itemResLength#"
					dueDate="#itemDueDate#"
					accList="#ACC_LIST#">
	
				<cfset EquipList = ListAppend(EquipList,equipItemString)>			

			</cfif>			

		</cfloop>

	</cfif>

	<cfparam name="form.equip_list" default="#EquipList#">
	
	<cfif form.URL EQ "">
		<cfset referringURL = ListLast(HTTP_REFERER, "/")>
		<cfif referringURL EQ "">
			<cfset referringURL = "home.cfm">
		</cfif>
	<cfelse>
		<cfset referringURL = form.URL>
	</cfif>
	
	<!--- Nov 2004
	equiparray will now be an array of equipment arrays...
	the outer array will be for each instance of the reservation (applicable for recurring reservations)
	the inner array will represent all of the equipment to be reserved on an instance (date) of the recurring reservation
	for normal reservations, the outer array will be one element (day) long
 	--->
		<!--- <cfset equipListLen = ArrayLen(equipArray)> --->
	
	<cfset deletedConstant = "deleted666">

	<cfif ListLen(form.equip_list,"^") EQ ListLen(form.date)>
		<cfset instanceArray = ListToArray(form.equip_list,"^")>	
	<cfelse>	
		<cfset instanceArray = ArrayNew(1)>	
		<cfloop index="ia" from="1" to="#ListLen(form.date)#">
			<cfset instanceArray[ia] = deletedConstant>	
		</cfloop>
	</cfif>
	<cfset equipArray = ArrayNew(1)>
	<!--- <cfset validEquips = ArrayNew(1)>  nov 2004 - this doesn't need to be an array!
	<cfset validEquips[1] = 0> --->
	<cfset validEquips = 0> 
	
	<cfloop index="ii" from="1" to="#ListLen(form.date)#">  <!--- need this outer loop to assign equipArray the appropriate values --->
		<cfset equipArray[ii] = ListToArray(instanceArray[ii])>
		<cfset validEquips = 0>
		<cfloop index="x" from="1" to="#ArrayLen(equipArray[ii])#">
			<cfif equipArray[ii][x] NEQ deletedConstant>
				<cfset validEquips = validEquips + 1>
			</cfif>
		</cfloop>
	</cfloop>
	
	
	<cfif existingResBadEquip>
		
		<script LANGUAGE="JavaScript">
		<!--
			alert("The following equipment is currently checked out in the system.  Please check it in if it really has been returned.  <cfoutput>#existingResBadEquipMsg#</cfoutput>");
			window.location.replace('home.cfm');
		//-->
		</script>			

	</cfif>
	
