

<cfparam name="cookie.userID" default="0">
<cfparam name="cookie.userRoles" default="">
<cfparam name="cookie.userAdminType" default="">
<cfparam name="cookie.userAdminDepts" default="">

<cfif cookie.userID EQ "" OR cookie.userID EQ 0>	

	<cfoutput>
		<form action="#APP_webroot#/login.cfm" method="post" target="_top" name="notAuthorized">
			<input type="hidden" name="noAuth" value="yes">
		</form>
	</cfoutput>	
	
	<script language="JavaScript">
	<!--
		document.forms['notAuthorized'].submit();
	-->
	</script>

</cfif>
