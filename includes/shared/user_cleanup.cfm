
	<cfquery name="get_ldap_users" datasource="#APP_dsn#">
		select	*
		from	USERS
		where	
				(
					RTRIM(LTRIM('|'+DEPT_OWNER+'|')) LIKE '|0,%' OR
					RTRIM(LTRIM(DEPT_OWNER)) LIKE '%,0,%' OR
					RTRIM(LTRIM('|'+DEPT_OWNER+'|')) LIKE '%,0|' OR
					RTRIM(LTRIM(DEPT_OWNER)) = '0'
				) 
	</cfquery>
	
	<!--- 
	
	this include defines the following:
	
	LDAP_root
	LDAP_server
	LDAP_port
	LDAP_username
	LDAP_password 
	
	--->								
	<cfinclude template="#APP_webroot#/includes/shared/ldap_variables.cfm">

	<cfloop query="get_ldap_users">	
	
		<cfset userfilter = "(physicalDeliveryOfficeName=#Trim(get_ldap_users.PSID)#)">
		
		<cfset UserSearchFailed = 0>
	
		<cftry>
		
			<cfldap action="QUERY"
					name="auth"
					attributes="cn,mail,description,title,physicalDeliveryOfficeName,sAMAccountName,memberof"
					start="#LDAP_root#"
					server="#LDAP_server#"
					port="#LDAP_port#"
					filter="#userfilter#"
					username="#LDAP_username#"
					password="#LDAP_password#"> 
			
			<cfcatch type="Any">				
				<cfset UserSearchFailed = 1>
				<cfoutput><p>ERROR: #cfcatch.message#</p></cfoutput>				
			</cfcatch>
			
		</cftry>
	
		<cfif (NOT auth.recordcount) OR UserSearchFailed>
		
			<cfoutput><p>#get_ldap_users.PSID# #get_ldap_users.LAST_NAME# #get_ldap_users.FIRST_NAME#</p></cfoutput>

			<cfquery name="deactivate_user" datasource="#APP_dsn#">
				update	USERS
				set 	USERNAME = PSID, PASSWORD = 'temp', DEPT_OWNER = NULL<!--- , ACTIVATED = NULL --->	
				where	USER_ID = #get_ldap_users.USER_ID#
			</cfquery>
		
		</cfif>

	</cfloop>
	
