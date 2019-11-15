
<!--- 

additional code for non-authenticated user here 

--->

	<cfset foundPSID = "no">

	<cfif NOT foundPSID>

		<cfquery name="login_checkO" datasource="#APP_dsn#">
			SELECT 	PSID
			FROM 	USERS
			WHERE 	RTRIM(LTRIM(USERNAME)) = '#Trim(form.username)#' AND 
					RTRIM(LTRIM(PASSWORD)) = '#Trim(form.password)#' AND
					(
						(
							LEFT(LTRIM(DEPT_OWNER),1) <> '0' AND
							RTRIM(LTRIM(DEPT_OWNER)) NOT LIKE '%,0,%' AND
							RIGHT(RTRIM(DEPT_OWNER),2) <> ',0'
						) 
						OR
						DEPT_OWNER IS NULL
					) 
					<!--- (DEPT_OWNER <> 0 OR DEPT_OWNER IS NULL) --->
		</cfquery>
		
		<cfif login_checkO.RecordCount GT 0 and Trim(form.username) NEQ "">
			<cfset foundPSID = "yes">
			<cfset valuePSID = login_checkO.PSID>
		</cfif>

	</cfif>
	
	<cfif foundPSID>

		<cfquery name="get_user" datasource="#APP_dsn#">
			select	USER_ID
			from	USERS
			where	PSID='#Trim(valuePSID)#'
		</cfquery>
		
		<cfif get_user.RecordCount>
	
			<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_classes.cfm"
						psid="#valuePSID#">			
			
			<!--- OUTPUT: classList --->
			
			<!--- <cfoutput>#classList#</cfoutput> --->			
		
			<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_user_roles.cfm"
						classList="#classList#"
						userID="#get_user.USER_ID#">			
			
			<!--- OUTPUT: roleList, adminDepts, adminType --->			
			
			<cfcookie name="userID" value="#get_user.USER_ID#">
			<cfcookie name="userPSID" value="#Trim(valuePSID)#">
			<cfcookie name="userRoles" value="#roleList#">
			<cfcookie name="userAdminType" value="#adminType#">
			<cfcookie name="userAdminDepts" value="#adminDepts#">
	
			<cfoutput>
				<script language="JavaScript">
				<!--
					window.location.replace('#APP_homePage#');
				-->
				</script>
			</cfoutput>
		
		</cfif>
			
	</cfif>
