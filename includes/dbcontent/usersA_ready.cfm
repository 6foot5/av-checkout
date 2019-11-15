
<cfoutput>

	<p>Select User:<br>
	<select name="editID" class="#APP_style_inputAdmin#">
		<option value="">Select User Below...</option>
		<cfloop query="get_user">
			<option value="#USER_ID#">#LAST_NAME#, #FIRST_NAME# (#PSID#)</option>
		</cfloop>
	</select><br><br>
	
	<a href="dbcontent.cfm?type=users">Add New User</a><br><br>
	<a href="home.cfm">Search Again</a><br><br>

	<input type="hidden" name="contentType" value="users">
	<input type="hidden" name="dept" value="#dept#">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
