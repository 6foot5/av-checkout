
<cfoutput>

	<cfif ArrayLen(daysSelected) EQ 0>
		<p>Because you have not selected any days on the previous screen, you will be CLOSED for the period
		beginning #DateFormat(form.hDateOn, "ddd, mmmm d, yyyy")# and ending #DateFormat(form.hDateOff, "ddd, mmmm d, yyyy")#.  
		If this is your intention, please click the <i>Save and Continue</i> button below.  If not, click the browser's
		back button and select at least one day from the list.</p>
	<cfelse>
		<p>You must enter time periods separated by commas, with hyphens separating the start and end times for each period.  
		<br><br>All times must be in military format.  
		<br><br>For example, to enter hours for a day when you are open from 8am - 11:30am and again from 2pm - 6pm, 
		you would enter 8:00-11:30,14:00-18:00.  
		<br><br>For a day when you are open from 10am - 8pm, you would simply enter 10:00-20:00.</p>
	</cfif>

	<cfloop index="x" from="1" to="#ArrayLen(daysSelected)#">
		<cfset fieldName = "hHoursDay" & x>
		<p><b>#daysSelected[x]#</b> Hours:<br><br>
		<input class="#APP_style_inputAdmin#" type="text" size="30" name="#fieldName#" value="">											
		</p>
	</cfloop>
	
	<input type="hidden" name="hDept" value="#form.hDept#">
	<input type="hidden" name="hTag" value="#form.hTag#">
	<input type="hidden" name="hType" value="#form.hType#">
	<input type="hidden" name="hDateOn" value="#form.hDateOn#">
	<input type="hidden" name="hDateOff" value="#form.hDateOff#">
	<input type="hidden" name="hDOW" value="#form.hDOW#">

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="step" value="four">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
