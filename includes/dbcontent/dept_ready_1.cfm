
<cfoutput>

	<p>Department Name:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="dName" value="#dName#"></p>								
	
	<p>Email Address:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="dEmail" value="#dEmail#"></p>								
	
	<p>IP Address String:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="dIpAddress" value="#dIpAddress#"></p>								
	
	<p>Notes:<br>
	<textarea class="#APP_style_inputAdmin#" name="dNotes" rows="5" cols="50">#dNotes#</textarea></p>
	
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
