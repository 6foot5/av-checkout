
	<cfif form.specialResType EQ "normal">
	
		<cfset countdown = 0>
		<cfset validDT = DateFormat(Now(),"m/d/yyyy")>
	
		<cfmodule 
			template="#APP_webroot#/#APP_path_customtags#/get_advance_days.cfm"
			advanceTime="#resAdvanceTime#"
			deptID="#form.dept#"
			startDate="#validDT#">
	
		<cfset numDaysOpen = ListLen(advanceDays)>
		
		<cfif numDaysOpen>
			<p><b>Walkin Checkouts and<br>Advance Reservations</b><br><br>
			Select Desired Pickup Date:<br>
			<select name="date" class="small">
				
				<cfloop index="x" from="1" to="#ListLen(advanceDays)#">
					<cfoutput>
						<cfset thisDate = GetToken(advanceDays,x,",")>
						<option value="#thisDate#">#DateFormat(thisDate,"dddd, mmm d")#</option>
					</cfoutput>		
				</cfloop>
				
			</select></p>
		<cfelse>
		
			<p>There are no days available to make advance reservations.</p>
		</cfif>
	
	<cfelse>
		
		<cfoutput>
			<cfif form.specialResType EQ "longterm">
				<b>Long Term Reservation</b><br><br>
			<cfelse>
				<b>Recurring Reservation - Every #form.specialResType#</b><br><br>
			</cfif>
		
			<table width="400" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td valign="top" colspan="3"><hr width="100%" size="1" noshade></td>
			  </tr>
			  <tr>
				<td>
					Starts On:<br>
					<input class="#APP_style_inputAdmin#" type="text" size="12" name="specialStartDate" value="">
					<a href="javascript:cal1.popup();"><img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to set the date"></a>
				</td>
				<td colspan="2">
					Ends On:<br>
					<input class="#APP_style_inputAdmin#" type="text" size="12" name="specialEndDate" value="">
					<a href="javascript:cal2.popup();"><img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to set the date"></a>
				</td>
			  </tr>
				
			  <tr>
				<td valign="top" colspan="3"><hr width="100%" size="1" noshade></td>
			  </tr>
			</table><br>
		
		</cfoutput>		
			
	</cfif>

	


