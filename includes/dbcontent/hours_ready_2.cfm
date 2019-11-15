
<cfoutput>

	<p>Select days of week that the checkout is open during this period:<br><br>
	<i>NOTE</i>: if no days are selected below, the checkout will be CLOSED for the time period you defined on the previous screen.<br><br>
	
	<select class="#APP_style_inputAdmin#" name="hDOW" multiple size="7">
		<cfloop index="x" from="1" to="#ArrayLen(dow)#">
			<cfif ListFind(availDays, dow[x])>
				<option value="#dow[x]#">&nbsp; #dow[x]# &nbsp;</option>
			</cfif>
		</cfloop>
	</select><br><br>

	<!--- <p>How do you wish to set the hours?<br><br>
	<select class="#APP_style_inputAdmin#" name="hDefineType">
		<option value="simple" Selected>Hours are the same for each day selected above&nbsp;</option>
		<option value="advanced">Hours are different depending on the day &nbsp;</option>
	</select>
	</p>	 --->								

	<input type="hidden" name="hDept" value="#form.hDept#">
	<input type="hidden" name="hTag" value="#form.hTag#">
	<input type="hidden" name="hType" value="#form.hType#">
	<input type="hidden" name="hDateOn" value="#form.hDateOn#">
	<input type="hidden" name="hDateOff" value="#form.hDateOff#">

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="step" value="three">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
