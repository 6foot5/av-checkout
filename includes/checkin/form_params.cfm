
	<cfparam name="url.resID" default=0>
	<cfparam name="url.deptID" default=0>
	<cfparam name="form.somethingChecked" default=0>
	<cfparam name="form.alreadyChecked" default=0>
	<cfparam name="form.miscOutstanding" default="off">
	<cfparam name="form.fine" default=0>
	<cfparam name="form.resID" default="#url.resID#">
	<cfparam name="form.specialResType" default="normal">
	
	<cfquery name="get_notes" datasource="#APP_dsn#">
		select	NOTES, RES_NOTES, DUE_DT
		from	RESERVATIONS
		where	RES_ID = #form.resID#
	</cfquery>

	<cfset resDue = CreateODBCDateTime(get_notes.DUE_DT)>
	<cfif Trim(get_notes.NOTES) NEQ "">
		<cfset miscNotes = get_notes.NOTES>
	<cfelse>
		<cfset miscNotes = "None">
	</cfif>
	<cfset resNotes = get_notes.RES_NOTES>
	
	<cfif NOT IsDefined("form.equip_list")>
	
		<cfquery name="get_equips" datasource="#APP_dsn#">
			select	R.EQUIP_ID, R.ACC_LIST, R.STATUS, E.NAME, E.BARCODE, RE.DUE_DT
			from	RES_DETAILS R, EQUIPMENT E, RESERVATIONS RE
			where	R.RES_ID = #form.resID# and
					R.RES_ID = RE.RES_ID and
					R.EQUIP_ID = E.EQUIP_ID				
		</cfquery>
		
		<cfset EquipList = ""> 
		<!--- <cfset CheckinList = ""> --->
		<cfloop query="get_equips">
			<!--- <cfquery name="get_equip" datasource="#APP_dsn#">
				select	EQUIP_ID, BARCODE, NAME
				from	EQUIPMENT
				where	EQUIP_ID = #get_equips.EQUIP_ID#
			</cfquery>
			<cfoutput>#STATUS#</cfoutput> --->
			<cfif Trim(STATUS) EQ "checked">
				<cfset eStatus = "out">
			<cfelseif Trim(STATUS) EQ "closed">
				<cfset form.alreadyChecked = form.alreadyChecked + 1>
				<cfset eStatus = "in">
			</cfif>
			<!--- <cfoutput>#DUE_DT#<br></cfoutput> --->
			<cfmodule 
				template="#APP_webroot#/#APP_path_customtags#/build_equip_list.cfm"
				equipID="#EQUIP_ID#"
				barcode="#BARCODE#"
				equipName="#NAME#"
				dueDate="#DUE_DT#"
				equipStatus="#eStatus#"
				accList="#ACC_LIST#">

			<cfset EquipList = ListAppend(EquipList,equipItemString)>			
		</cfloop>
	
	</cfif>

	<cfparam name="form.status" default="ready">
	<cfparam name="form.URL" default="">
	<cfparam name="EquipList" default="">
	<cfparam name="form.equip_list" default="#EquipList#">
	<!--- <cfparam name="CheckinList" default="">
	<cfparam name="form.checkin_list" default="#CheckinList#"> --->
	<cfparam name="form.removeID" default=0>
	<cfparam name="form.type" default="">
	<cfparam name="form.resID" default="#url.resID#">
	<cfparam name="form.initials" default="">
	
	<cfif form.URL EQ "">
		<cfset referringURL = ListLast(HTTP_REFERER, "/")>
		<cfif referringURL EQ "">
			<cfset referringURL = "home.cfm">
		</cfif>
	<cfelse>
		<cfset referringURL = form.URL>
	</cfif>
	
	<cfset deletedConstant = "deleted666">

	<cfset instanceArray = ListToArray(form.equip_list,"^")>	

	<cfset equipArray = ArrayNew(1)>
	<!--- <cfset validEquips = ArrayNew(1)>  nov 2004 - this doesn't need to be an array!
	<cfset validEquips[1] = 0> --->
	<cfset validEquips = 0> 
	
	<cfloop index="ii" from="1" to="#ArrayLen(instanceArray)#">  <!--- need this outer loop to assign equipArray the appropriate values --->
		<cfset equipArray[ii] = ListToArray(instanceArray[ii])>
		<cfset validEquips = 0>
		<cfloop index="x" from="1" to="#ArrayLen(equipArray[ii])#">
			<cfif equipArray[ii][x] NEQ deletedConstant>
				<cfset validEquips = validEquips + 1>
			</cfif>
		</cfloop>
	</cfloop>

	<script LANGUAGE="JavaScript">
	<!--

		function validateForm(theForm) 
		{
			
		<cfif form.status EQ "ready">
			if (theForm.initial_req.value == "yes")
			{
				if (!validRequired(theForm.initials,"Employee Initials"))
					return false;
			}
		</cfif>
			
			return true;
		}

	//-->
	</script>
	
