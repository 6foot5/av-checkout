
<cfoutput>

	<cfif form.rOnline>
	
		<p>Select advance reservation time period:<br><br>
		<select class="#APP_style_inputAdmin#" name="rAdvanceTime">
			<cfloop index="x" from="1" to="#ArrayLen(advanceTime)#">
				<cfif rAdvanceTime EQ advanceTime[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#advanceTime[x][1]#" #isSelected#>#advanceTime[x][2]# &nbsp;</option>
			</cfloop>
		</select>
		</p>	
		
		<p>How soon will reservations expire if not picked up?<br><br>
		<select class="#APP_style_inputAdmin#" name="rResExpire">
			<cfloop index="x" from="1" to="#ArrayLen(resExpire)#">
				<cfif rResExpire EQ resExpire[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#resExpire[x][1]#" #isSelected#>#resExpire[x][2]# &nbsp;</option>
			</cfloop>
		</select>
		</p>	
		
		<p><i>For each category</i>, is there a limit to the number of advance reservations that a user can make?<br><br>
		<select class="#APP_style_inputAdmin#" name="rResCatWeekLimitA" onChange="checkFieldsA();">
			<cfloop index="x" from="1" to="#ArrayLen(resCatWeekLimitA)#">
				<cfif rResCatWeekLimitA EQ resCatWeekLimitA[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#resCatWeekLimitA[x][1]#" #isSelected#>#resCatWeekLimitA[x][2]# &nbsp;</option>
			</cfloop>
		</select> per
		<select class="#APP_style_inputAdmin#" name="rResCatWeekLimitB" onChange="checkFieldsB();">
			<cfloop index="x" from="1" to="#ArrayLen(resCatWeekLimitB)#">
				<cfif rResCatWeekLimitB EQ resCatWeekLimitB[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#resCatWeekLimitB[x][1]#" #isSelected#>#resCatWeekLimitB[x][2]# &nbsp;</option>
			</cfloop>
		</select> unless made within
		<select class="#APP_style_inputAdmin#" name="rResCatWeekLimitException" onChange="checkFieldsC();">
			<cfloop index="x" from="1" to="#ArrayLen(resCatWeekLimitException)#">
				<cfif rResCatWeekLimitException EQ resCatWeekLimitException[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#resCatWeekLimitException[x][1]#" #isSelected#>#resCatWeekLimitException[x][2]# &nbsp;</option>
			</cfloop>
		</select> of the pickup time.
		</p>	

	<cfelse>
			
		<input type="hidden" name="rAdvanceTime" value=168>
		<input type="hidden" name="rResExpire" value=60>
		<input type="hidden" name="rResCatWeekLimitA" value=1>
		<input type="hidden" name="rResCatWeekLimitB" value=168>
		<input type="hidden" name="rResCatWeekLimitException" value=24>

	</cfif>
	
	<cfif form.rAssessFines>

		<p>If not returned, how soon after item is due will the fine start?<br><br>
		<select class="#APP_style_inputAdmin#" name="rFineStart">
			<cfloop index="x" from="1" to="#ArrayLen(fineStart)#">
				<cfif rFineStart EQ fineStart[x][1]>
					<cfset isSelected = "selected">
				<cfelse>
					<cfset isSelected = "">
				</cfif>
				<option value="#fineStart[x][1]#" #isSelected#>#fineStart[x][2]# &nbsp;</option>
			</cfloop>
		</select>
		</p>	
		
		<p>Fine Schedule:<br><br>
		<input class="#APP_style_inputAdmin#" type="text" size="50" name="rFineSchedule" value="#rFineSchedule#"></p>								
		
		<p>Allow checkouts to users with outstanding fines?<br><br>
		<select class="#APP_style_inputAdmin#" name="rAllowCheckFine">
			<cfif rAllowCheckFine EQ "yes" or rAllowCheckFine EQ "">
				<option value="yes" Selected>Yes &nbsp;</option>
				<option value="no">No &nbsp;</option>
			<cfelse>
				<option value="no" Selected>No &nbsp;</option>
				<option value="yes">Yes &nbsp;</option>
			</cfif>
		</select> 
		</p>									
	
	<cfelse>

		<input type="hidden" name="rFineStart" value=60>
		<input type="hidden" name="rFineSchedule" value="0">
		<input type="hidden" name="rAllowCheckFine" value="no">

	</cfif>
	
	<cfif NOT form.rAssessFines AND NOT form.rOnline>
		<p>Based on your selections on the previous screen, no more information is required.  
		Please click the <i>Save and Continue</i> button.</p>
	</cfif>
	
	<cfif form.rResLengthException NEQ "" AND form.rResLengthExceptionDay NEQ "">
		<cfset newException = form.rResLengthExceptionDay & "," & form.rResLengthException>
	<cfelse>
		<cfset newException = "">
	</cfif>

	<input type="hidden" name="dName" value="#form.dName#">
	<input type="hidden" name="dEmail" value="#form.dEmail#">
	<input type="hidden" name="dIpAddress" value="#form.dIpAddress#">
	<input type="hidden" name="dNotes" value="#form.dNotes#">
	<input type="hidden" name="rScanner" value="#form.rScanner#">
	<input type="hidden" name="rOnline" value="#form.rOnline#">
	<input type="hidden" name="rResLength" value="#form.rResLength#">
	<input type="hidden" name="rResLengthException" value="#newException#">
	<input type="hidden" name="rReCheck" value="#form.rReCheck#">
	<input type="hidden" name="rAssessFines" value="#form.rAssessFines#">
	<input type="hidden" name="rCheckoutCatLimit" value="#form.rCheckoutCatLimit#">

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
