 
<cfoutput>

	<!--- <p>Department Owner:<br>
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
	</p> --->									

	<p>Select general interface for checkouts:<br><br>
	<select class="#APP_style_inputAdmin#" name="rScanner">
		<cfif rScanner EQ "no" or rScanner EQ "">
			<option value="no" Selected>Manual Management &nbsp;</option>
			<option value="yes">Barcode Scanner Friendly &nbsp;</option>
		<cfelse>
			<option value="yes" Selected>Barcode Scanner Friendly &nbsp;</option>
			<option value="no">Manual Management &nbsp;</option>
		</cfif>
	</select>
	</p>									

	<p>Allow in-advance online reservations:<br><br>
	<select class="#APP_style_inputAdmin#" name="rOnline">
		<cfif rOnline EQ "yes" or rOnline EQ "">
			<option value="yes" Selected>Yes &nbsp;</option>
			<option value="no">No &nbsp;</option>
		<cfelse>
			<option value="no" Selected>No &nbsp;</option>
			<option value="yes">Yes &nbsp;</option>
		</cfif>
	</select>
	</p>									

	<p>In general, how long are your checkouts?<br><br>
	<select class="#APP_style_inputAdmin#" name="rResLength">
		<cfloop index="x" from="1" to="#ArrayLen(resLength)#">
			<cfif rResLength EQ resLength[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLength[x][1]#" #isSelected#>#resLength[x][2]# &nbsp;</option>
		</cfloop>
	</select> &nbsp;<br><br>
	<select class="#APP_style_inputAdmin#" name="rResLengthExceptionDay">
		<option value="">&nbsp;</option>
		<cfloop index="x" from="1" to="#ArrayLen(resLengthException)#">
			<cfif Trim(rResLengthException) NEQ "" and Trim(GetToken(rResLengthException,1,",")) EQ resLengthException[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLengthException[x][1]#" #isSelected#>#resLengthException[x][2]#&nbsp;</option>
		</cfloop>
	</select>&nbsp;<br><br>
	<select class="#APP_style_inputAdmin#" name="rResLengthException">
		<option value="">&nbsp;</option>
		<cfloop index="x" from="1" to="#ArrayLen(resLength)#">
			<cfif Trim(rResLengthException) NEQ "" and Trim(GetToken(rResLengthException,2,",")) EQ resLength[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLength[x][1]#" #isSelected#>When checkouts last #resLength[x][2]#&nbsp;</option>
		</cfloop>
	</select>
	</p>	
	
	<p>Allow items to be re-checked out?<br><br>
	<select class="#APP_style_inputAdmin#" name="rReCheck">
		<cfif rReCheck EQ "yes" or rReCheck EQ "">
			<option value="yes" Selected>Yes &nbsp;</option>
			<option value="no">No &nbsp;</option>
		<cfelse>
			<option value="no" Selected>No &nbsp;</option>
			<option value="yes">Yes &nbsp;</option>
		</cfif>
	</select> 
	</p>									

	<p>Assess fines for late returns?<br><br>
	<select class="#APP_style_inputAdmin#" name="rAssessFines">
		<cfif rAssessFines EQ "no" or rAssessFines EQ "">
			<option value="no" Selected>No &nbsp;</option>
			<option value="yes">Yes &nbsp;</option>
		<cfelse>
			<option value="yes" Selected>Yes &nbsp;</option>
			<option value="no">No &nbsp;</option>
		</cfif>
	</select> 
	</p>									

	<p>Limit on the number of items in a category that can be checked out at one time:<br><br>
	<select class="#APP_style_inputAdmin#" name="rCheckoutCatLimit">
		<cfloop index="x" from="1" to="#ArrayLen(checkoutCatLimit)#">
			<cfif rCheckoutCatLimit EQ checkoutCatLimit[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#checkoutCatLimit[x][1]#" #isSelected#>#checkoutCatLimit[x][2]# &nbsp;</option>
		</cfloop>
	</select>
	</p>

	<input type="hidden" name="dName" value="#form.dName#">
	<input type="hidden" name="dEmail" value="#form.dEmail#">
	<input type="hidden" name="dIpAddress" value="#form.dIpAddress#">
	<input type="hidden" name="dNotes" value="#form.dNotes#">

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="step" value="three">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
