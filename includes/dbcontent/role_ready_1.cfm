
<cfoutput>

	<p>Department Owner:<br>
	<select class="#APP_style_inputAdmin#" name="rDept">
		<cfset compareDept = rDept>
		<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
			<cfset dList="">
			<cfset showAll = "yes">
		<cfelse>
			<cfset showAll = "no">
			<cfset dList = cookie.userAdminDepts>
		</cfif>
		<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
	</select>
	</p>									

	<p>Package Name:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="rName" value="#rName#"></p>								
	
	<p>Notes:<br>
	<textarea class="#APP_style_inputAdmin#" name="rNotes" rows="5" cols="50">#rNotes#</textarea></p>
	
	<input type="hidden" name="from" value="one">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
