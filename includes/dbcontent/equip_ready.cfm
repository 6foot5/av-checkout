
<cfoutput>

	<p>Department Owner: <span class="errorRed">*</span><br>
	<select class="#APP_style_inputAdmin#" name="eDept">
		<cfset compareDept = eDept>
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

	<p>Equipment Name: <span class="errorRed">*</span><br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="eName" value="#eName#"></p>								
	
	<p>Stock ID (Or Barcode) Number: <span class="errorRed">*</span><br>
	<input class="#APP_style_inputAdmin#" type="text" size="20" name="eBarcode" value="#eBarcode#"></p>								
	
	<p>Make Equipment Availabe for Checkout? <span class="errorRed">*</span><br>
	<select class="#APP_style_inputAdmin#" name="eAvail">
		<cfif eAvail EQ "yes" or eAvail EQ "">
			<option value="yes" Selected>Yes &nbsp;</option>
			<option value="no">No &nbsp;</option>
		<cfelse>
			<option value="no" Selected>No &nbsp;</option>
			<option value="yes">Yes &nbsp;</option>
		</cfif>
	</select>
	</p>									

	<p>Select Max Reservation Length: <span class="errorRed">*</span><br>
	<select class="#APP_style_inputAdmin#" name="eResLength">
		<cfloop index="x" from="1" to="#ArrayLen(resLength)#">
			<cfif eResLength EQ resLength[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLength[x][1]#" #isSelected#>#resLength[x][2]# &nbsp;</option>
		</cfloop>
	</select>&nbsp;<br><br>
	<select class="#APP_style_inputAdmin#" name="eResLengthExceptionDay">
		<option value="">&nbsp;</option>
		<cfloop index="x" from="1" to="#ArrayLen(resLengthException)#">
			<cfif Trim(eResLengthException) NEQ "" and eResLengthExceptionDay EQ resLengthException[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLengthException[x][1]#" #isSelected#>#resLengthException[x][2]#&nbsp;</option>
		</cfloop>
	</select>&nbsp;<br><br>
	<select class="#APP_style_inputAdmin#" name="eResLengthException">
		<option value="">&nbsp;</option>
		<cfloop index="x" from="1" to="#ArrayLen(resLength)#">
			<cfif Trim(eResLengthException) NEQ "" and eResLengthException EQ resLength[x][1]>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#resLength[x][1]#" #isSelected#>When checkouts last #resLength[x][2]#&nbsp;</option>
		</cfloop>
	</select>
	</p>	
	
	<p>Accessory Package (if applicable):<br>
	<select class="#APP_style_inputAdmin#" name="eAcc">
	
		<option value="">Select Accessory Package Below&nbsp;&nbsp;</option>			
		<option value="">----------&nbsp;&nbsp;</option>			

		<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
			<cfset dList="">
			<cfset showAll = "yes">
		<cfelse>
			<cfset showAll = "no">
			<cfset dList = cookie.userAdminDepts>
		</cfif>
	
		<cfquery name="get_accs" datasource="#APP_dsn#">
			select 	A.PKG_ID, A.PKG_NAME, D.DEPT_NAME
			from 	DEPARTMENTS D, ACCESSORY_PKG A
			where	D.DEPT_ID = A.DEPT_ID and
					RTRIM(LTRIM(A.STATUS)) = 'current'
			<cfif NOT showAll>
				and		D.DEPT_ID in (#dList#)
			</cfif>
			order by
					DEPT_NAME, PKG_NAME
		</cfquery>
		
		<cfloop query="get_accs">
			<cfif eAcc EQ PKG_ID>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="#PKG_ID#" #isSelected#>#DEPT_NAME# - #PKG_NAME#&nbsp;&nbsp;</option>			
		</cfloop>
	
	</select>
	</p>									

	<p>Serial Number:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="20" name="eSerial" value="#eSerial#"></p>								
	
	<p>Equipment-Specific Fine Schedule (will override any global fine schedule):<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="eFine" value="#eFine#"></p>								
	
	<p>Notes:<br>
	<textarea class="#APP_style_inputAdmin#" name="eNotes" rows="5" cols="50">#eNotes#</textarea></p>
	
	<input type="hidden" name="catID" value="#url.catID#">
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
