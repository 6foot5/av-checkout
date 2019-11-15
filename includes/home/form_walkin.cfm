

<!---  commented out 11/3/03 - global admin cannot see walkin res form??
<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 AND ListContains(cookie.userAdminType,"globalAdmin") EQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
	<cfoutput>
		<form action="walkin.cfm" name="#pageType#" method="post" onSubmit="return validateWalkinForm(this);">
			
			<cfif pageType EQ "walkin">
				<h4>Walkin Checkouts</h4>
			<cfelse>
				<h4>Make Reservation</h4>
			</cfif>
		    
			<p>Department:<br>
      		<select class="#APP_style_inputAdmin#" name="dept">
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				<cfset compareDept = "">
				<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0>
				  <cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
					<cfset dList="">
					<cfset showAll = "yes">
					<cfelse>
					<cfset showAll = "no">
					<cfset dList = cookie.userAdminDepts>
				  </cfif>
				  <cfelse>
				  <cfset dList="">
				  <cfset showAll = "yes">
				</cfif>
				<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
				<!--- <cfloop query="get_depts">
							<option value="#DEPT_ID#">#DEPT_NAME#</option>
						</cfloop> --->
			</select>

			  <br>
			  <br>

			  <cfif resUser EQ "">
				Enter a valid [ORG-NAME] ID to begin.<br>
				<br>
				[ORG-NAME] ID<br>
				<input type="hidden" name="adminUser" value="yes">
				<input type="text" name="psid" size="15" class="#APP_style_inputAdmin#" value="">
				<br>
				<br>
				<cfif pageType NEQ "walkin" and ListContains(cookie.userAdminType,"Admin")>
				  <select class="#APP_style_inputAdmin#" name="specialResType">
					<option value="normal">Normal Reservation</option>
					<option value="normal">------------------</option>
					<option value="longterm">Long Term Reservation</option>
					<option value="normal">------------------</option>
					<option value="Monday">Recurring on Mondays</option>
					<option value="Tuesday">Recurring on Tuesdays</option>
					<option value="Wednesday">Recurring on Wednesdays</option>
					<option value="Thursday">Recurring on Thursdays</option>
					<option value="Friday">Recurring on Fridays</option>
					<option value="Saturday">Recurring on Saturdays</option>
					<option value="Sunday">Recurring on Sundays</option>
				  </select>
				  <br><br>
				<cfelse>
				  <input type="hidden" name="specialResType" value="normal">
				</cfif>
			  <cfelse>
				<input type="hidden" name="specialResType" value="normal">
				<input type="hidden" name="adminUser" value="no">
				<input type="hidden" name="psid" value="#resUser#">
			  </cfif>
			  <input type="hidden" name="source" value="admin">
			  <cfset today = DateFormat(Now(),"m/d/yyyy")>
			  <cfset currentTime=TimeFormat(Now(), "H:mm")>
			  <input type="hidden" name="updateStatus" value="yes">
			  <input type="hidden" name="status" value="#pageStatus#">
			  <input type="hidden" name="time" value="#currentTime#">
			  <input type="hidden" name="date" value="#today#">
			  <input type="hidden" name="type" value="#pageType#">
			  <input type="submit" name="submit" value="Continue" class="#APP_style_inputAdmin#">
			  <!--- &nbsp;
					<input type="submit" name="submit" value="Reserve" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkin'].type.value='reserve';"> --->
			</p>
		</form>
		
	</cfoutput>
