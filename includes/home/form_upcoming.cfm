


<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 AND ListContains(cookie.userAdminType,"globalAdmin") EQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0>
	<cfoutput>
		<p><b>View Reservations</b></p>
		<form action="dbview.cfm?type=res" name="upcoming" method="post">
			<p>Department:<br>
			<select class="#APP_style_inputAdmin#" name="dept">
				<cfset compareDept = "">
				<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
					<cfset dList="">
					<cfset showAll = "yes">
				<cfelse>
					<cfset showAll = "no">
					<cfset dList = cookie.userAdminDepts>
				</cfif>
				<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
			</select><br><br><br>
			<input type="hidden" name="upcoming" value="">
			<input type="hidden" name="updateStatus" value="yes">
			<input type="submit" name="submit" value="Upcoming Checkouts" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['upcoming'].upcoming.value='checkouts';"><br><br><br>
			<input type="submit" name="submit" value="Upcoming Checkins" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['upcoming'].upcoming.value='checkins';"></p>
		</form>
	</cfoutput>
<cfelse>
	<p>no view access
</cfif>
