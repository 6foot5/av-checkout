<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/dbdelete/general_header.cfm">						
	
	<cfoutput>
		<title>#APP_title# | Deleting Item...</title>
	</cfoutput>
	
</head> 

<cfoutput>
<body bgcolor="#APP_page_bgcolor#">
</cfoutput>

	<cfswitch expression="#contentType#">
	
		<cfcase value="equipment">
			<cfinclude template="#APP_webroot#/includes/dbdelete/equipment.cfm">						
		</cfcase>
		
		<cfcase value="hours">
			<cfinclude template="#APP_webroot#/includes/dbdelete/hours.cfm">						
		</cfcase>
		
		<cfcase value="dept">
			<cfinclude template="#APP_webroot#/includes/dbdelete/department.cfm">						
		</cfcase>
					
		<cfcase value="cats">
			<cfinclude template="#APP_webroot#/includes/dbdelete/category.cfm">						
		</cfcase>
					
		<cfcase value="fines">
			<cfinclude template="#APP_webroot#/includes/dbdelete/fine.cfm">						
		</cfcase>
					
		<cfcase value="res">
			<cfinclude template="#APP_webroot#/includes/dbdelete/reservation.cfm">						
		</cfcase>
					
		<cfcase value="acc">
			<cfinclude template="#APP_webroot#/includes/dbdelete/accessory.cfm">						
		</cfcase>
					
		<cfcase value="roles">
			<cfinclude template="#APP_webroot#/includes/dbdelete/role.cfm">						
		</cfcase>
					
	</cfswitch>
	
	<cfoutput>
		<form action="#referringURL#" method="post" name="deleteMade">
			<input type="hidden" name="dbdeleteSource" value="yes">
		</form>
		#referringURL#
	</cfoutput>	
		
	<script language="JavaScript">
	<!--
		document.forms['deleteMade'].submit();
		//window.location.replace('index.cfm');
	-->
	</script>											
	
</body>
</html>
