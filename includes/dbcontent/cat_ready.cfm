
<cfoutput>

	<p>Department Owner:<br>
	<select class="#APP_style_inputAdmin#" name="cDept">
		<cfset compareDept = cDept>
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

	<p>Category Name:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="cName" value="#cName#"></p>								
	
	<p>Enforce checkout limits for this category?<br><br>
	<select class="#APP_style_inputAdmin#" name="cEnforceLimit">
		<cfif cEnforceLimit EQ "yes" or cEnforceLimit EQ "">
			<option value="yes" Selected>Yes &nbsp;</option>
			<option value="no">No &nbsp;</option>
		<cfelse>
			<option value="no" Selected>No &nbsp;</option>
			<option value="yes">Yes &nbsp;</option>
		</cfif>
	</select> 
	</p>									

	<p>Notes:<br>
	<textarea class="#APP_style_inputAdmin#" name="cNotes" rows="5" cols="50">#cNotes#</textarea></p>
	
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
