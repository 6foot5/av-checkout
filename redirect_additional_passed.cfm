
<!--- 

additional code for authenticated user here 

--->

	<cfquery name="get_user" datasource="#APP_dsn#">
		select	USER_ID
		from	USERS
		where	PSID='#Trim(form.psid)#'
	</cfquery>

	<cfif get_user.RecordCount>
	
		<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_classes.cfm"
					psid="#form.psid#">			
		
		<!--- OUTPUT: classList --->
		
		<cfmodule 	template="#APP_webroot#/#APP_path_customtags#/get_user_roles.cfm"
					classList="#classList#"
					userID="#get_user.USER_ID#">			
		
		<!--- OUTPUT: roleList, adminDepts, adminType --->			
		
		<cfcookie name="userID" value="#get_user.USER_ID#">
		<cfcookie name="userPSID" value="#Trim(form.psid)#">
		<cfcookie name="userRoles" value="#roleList#">
		<cfcookie name="userAdminType" value="#adminType#">
		<cfcookie name="userAdminDepts" value="#adminDepts#">
	
	<cfelse>

		<cfoutput>
			<form action="#APP_webroot#/#APP_homePage#/dbcontent.cfm" method="post" name="notRegistered">
				<input type="hidden" name="uPSID" value="#Trim(form.psid)#">
				<input type="hidden" name="source" value="login">
				<input type="hidden" name="contentType" value="users">
				<input type="hidden" name="editID" value="0">
				<input type="hidden" name="step" value="two">
				<input type="hidden" name="status" value="ready">
			</form>
		</cfoutput>	
		
		<script language="JavaScript">
		<!--
			//alert('Please register for this program by contacting the checkout department.');
			document.forms['notRegistered'].submit();
		-->
		</script>

	</cfif>
	