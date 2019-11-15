

<cfif NOT IsDefined("userID")><cfset userID = form.userID></cfif>
<cfif NOT IsDefined("userName")><cfset userName = form.userName></cfif>
<cfif NOT IsDefined("userEmail")><cfset userEmail = form.userEmail></cfif>
<cfif NOT IsDefined("userPhone")><cfset userPhone = form.userPhone></cfif>
<cfif NOT IsDefined("roleList")><cfset roleList = form.roleList></cfif>
<cfif NOT IsDefined("adminType")><cfset adminType = form.adminType></cfif>
<cfif NOT IsDefined("adminDepts")><cfset adminDepts = form.adminDepts></cfif>


<cfoutput>
	<input type="hidden" name="add" value="no">
	<input type="hidden" name="complete" value="no">
	<input type="hidden" name="removeID" value=0>
	<cfif form.status EQ "confirm" or form.status EQ "ready" or form.status EQ "time">
		<input type="hidden" name="date" value="#form.date#">
		<input type="hidden" name="specialStartDate" value="#form.specialStartDate#">
		<input type="hidden" name="specialEndDate" value="#form.specialEndDate#">
	</cfif>
	<cfif form.status EQ "confirm" or form.status EQ "ready" or form.status EQ "date">
		<input type="hidden" name="time" value="#form.time#">
	</cfif>
	<input type="hidden" name="dept" value="#form.dept#">
	<input type="hidden" name="psid" value="#form.psid#">
	<input type="hidden" name="status" value="#form.status#"> <!--- this vale is altered using javascript in the form submission --->
	<!--- <input type="hidden" name="source" value="#form.source#"> --->
	<input type="hidden" name="existing" value="#form.existing#">
	<input type="hidden" name="type" value="#form.type#">
	<input type="hidden" name="from" value="#form.from#">
	<input type="hidden" name="resID" value="#form.resID#">
	<input type="hidden" name="adminUser" value="#form.adminUser#">
	<input type="hidden" name="userID" value="#userID#">
	<input type="hidden" name="userName" value="#userName#">
	<input type="hidden" name="userEmail" value="#userEmail#">
	<input type="hidden" name="userPhone" value="#userPhone#">
	<input type="hidden" name="roleList" value="#roleList#">
	<input type="hidden" name="adminType" value="#adminType#">
	<input type="hidden" name="adminDepts" value="#adminDepts#">
	
	<cfloop index="hv" from="1" to="#ArrayLen(equipArray)#">
		<cfset equipArray[hv] = ArrayToList(equipArray[hv])>
	</cfloop>
	<cfset new_equip_list = ArrayToList(equipArray,"^")>

	<input type="hidden" name="equip_list" value="#new_equip_list#">
	<cfif form.status NEQ "confirm">
		<input type="hidden" name="initials" value="#form.initials#">
	</cfif>
	<input type="hidden" name="notes" value="#form.notes#">
	<input type="hidden" name="resNotes" value="#form.resNotes#">
	<input type="hidden" name="specialResType" value="#form.specialResType#">
</cfoutput>
