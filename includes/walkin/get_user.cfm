
	<cfset valuePSID = form.psid>
	<cfset userID = 0>

	<cfquery name="get_user" datasource="#APP_dsn#">
		select	USER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE1, PHONE2, PHONE3
		from	USERS
		where	PSID = '#Trim(valuePSID)#'
	</cfquery>
	
	<cfset userFound = "no">

	<cfif get_user.RecordCount>
	
		<cfset userID = get_user.USER_ID>
		<cfset userName = get_user.FIRST_NAME & " " & get_user.LAST_NAME>
		<cfset userEmail = get_user.EMAIL>
		<cfset userPhone = get_user.PHONE1 & "." & get_user.PHONE2 & "." & get_user.PHONE3>
		
		<cfif NOT Trim(checkoutAllowedWithFine)>
			<cfinclude template="#APP_webroot#/includes/walkin/fine_check.cfm">	
		</cfif>

		<cfif form.type EQ "walkin">
			<cfinclude template="#APP_webroot#/includes/walkin/overdue_check.cfm">	
		</cfif>

		<cfset userFound = "yes">
	
		<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_classes.cfm"
					psid="#valuePSID#">
					
		<!--- OUTPUT: classList --->			
		
		<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_user_roles.cfm"
					classList="#classList#"
					userID="#userID#">										
		
		<!--- OUTPUT: roleList, adminDepts, adminType --->
		
		<!---
		
		if department assesses fines and disallows checkouts to outstanding fined users, then:
		
		<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_user_fines.cfm"
					userID="#userID#">
					
		if the fines list returned by this module contains active fines, then proceed as follows:
		
		if workstudy, deny checkout to user
		if full admin, warn and allow checkout if desired.												
		
		--->
		
		<!--- <cfset roleArray = ListToArray(roleList)>
		<cfset adminTypeArray = ListToArray(adminType)>
		<cfset adminDeptsArray = ListToArray(adminDepts)> --->

	<cfelse>
		
		<cfoutput>
			<form action="dbcontent.cfm?type=users" method="post" name="notRegistered">
				<input type="hidden" name="URL" value="home.cfm">
				<input type="hidden" name="primePSID" value="#valuePSID#">
				<input type="hidden" name="userNotFound" value="yes">
			</form>
		</cfoutput>	
		
		<script language="JavaScript">
		<!--
			document.forms['notRegistered'].submit();
		-->
		</script>
					
	</cfif>

