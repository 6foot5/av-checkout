
<cfoutput>

	<cfquery name="get_users" datasource="#APP_dsn#">
		select		FIRST_NAME, USER_ID, LAST_NAME
		from 		USERS 
		order by 	LAST_NAME
	</cfquery>
	
	<cfquery name="get_roles" datasource="#APP_dsn#">
		select		*
		from 		ROLES
		where		DEPT_ID = #requestingDept#
		order by	ROLE_NAME
	</cfquery>

	<cfquery name="check_org" datasource="#APP_dsn#">
		select		*
		from 		ROLES_USERS 
		where		ROLE_ID = #dbEditID#		
	</cfquery>			

	<p>Role:<br>
	<select class="#APP_style_inputAdmin#" name="oRole">
		<option value="">Select Role&nbsp;</option>
		<cfloop query="get_roles">
			<cfif ROLE_ID IS dbEditID>
				<cfset isSelected="selected">
			<cfelse>
				<cfset isSelected="">
			</cfif>									
			<option value="#ROLE_ID#" #isSelected#>#ROLE_NAME#&nbsp;</option>
		</cfloop>
	</select><br>
	</p>									

	<p>Users List:<br>
	<select class="#APP_style_inputAdmin#" name="oUsers" multiple size="15">
		<cfloop query="get_users">
			<cfset currUID = USER_ID>
			<cfset isSelected="">
			<cfloop query="check_org">
				<cfif currUID IS USER_ID>
					<cfset isSelected="selected">
				</cfif>												
			</cfloop>
			<option value="#USER_ID#" #isSelected#>#FIRST_NAME# #LAST_NAME#&nbsp;</option>
		</cfloop>
	</select><br>
	</p>									

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
