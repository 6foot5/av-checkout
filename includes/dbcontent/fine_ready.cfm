
<cfoutput>

	<p>Offending User:
	#fUser#
	</p>									

	<p>Fine Amount:<br>
	<cfif Trim(fStatus) EQ "open" or Trim(fStatus) EQ "">
		<input class="#APP_style_inputAdmin#" type="text" size="10" name="fAmount" value="#fAmount#">
	<cfelse>
		<input class="#APP_style_inputAdmin#" type="text" size="10" name="fAmount" value="#fAmount#" readonly="yes">
	</cfif>
	</p>								
		
	<p>Paid Status:<br>
	<cfif Trim(fStatus) EQ "open" or Trim(fStatus) EQ "">
		<select class="#APP_style_inputAdmin#" name="fStatus">
			<option value="open" Selected>Open &nbsp;</option>
			<option value="paid">Paid &nbsp;</option>
		</select> 
	<cfelse>
		<input class="#APP_style_inputAdmin#" type="text" size="10" name="fStatus" value="#fStatus#" readonly="yes">
	</cfif>
	</p>									

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
