
<h4>Choose Category</h4>

<p>
<cfoutput>
	<form action="browse.cfm" name="browse" method="post">
		<select class="#APP_style_inputAdmin#" name="catID">
			<cfloop query="get_cats">
				<option value="#CAT_ID#">#CAT_NAME#&nbsp;&nbsp;</option>
			</cfloop>
		</select><br><br>
		<cfinclude template="#APP_webroot#/includes/browse/form_hidden.cfm">
		<input type="hidden" name="status" value="equip">
		<input class="#APP_style_inputAdmin#" type="submit" value="Continue" name="submit">
	</form>
</cfoutput>
</p>

