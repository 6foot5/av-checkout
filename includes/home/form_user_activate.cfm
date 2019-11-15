

<!---  commented out 11/3/03 - global admin cannot see res lookup form??
<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 AND ListContains(cookie.userAdminType,"globalAdmin") EQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
<!--- <cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
	<cfoutput>
		<!--- <form action="dbview.cfm?type=res" name="lookup" method="post" onSubmit="return validateLookupForm(this);"> --->

		<form action="dbcontent.cfm?type=usersA" name="lookup" method="post" onSubmit="return validateUsersForm(this);">
			<p><b>Edit / (De)activate User</b><br><br>

			<a href="dbcontent.cfm?type=users">Add New User</a><br><br>
			
			Department:<br>
			<select class="#APP_style_inputAdmin#" name="dept">
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				<cfset compareDept = "">
				<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
					<cfset dList="">
					<cfset showAll = "yes">
				<cfelse>
					<cfset showAll = "no">
					<cfset dList = cookie.userAdminDepts>
				</cfif>
				<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
				<!--- <cfloop query="get_depts">
					<option value="#DEPT_ID#">#DEPT_NAME#</option>
				</cfloop> --->
			</select><br><br>
			[ORG-NAME] ID / Last Name<br>
			<input type="text" name="user" size="15" class="#APP_style_inputAdmin#" value=""><br><br><!--- OR<br><br> --->

			<input type="hidden" name="updateStatus" value="yes">

			<input type="submit" name="submit" value="Continue" class="#APP_style_inputAdmin#">
			</p>
		</form>
	</cfoutput>
<!--- <cfelse>
	<p>no user edit access
</cfif> --->
