<html>
<head>

	<cfoutput>
		<title>#APP_title#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
	</cfoutput>
	
	<cfinclude template="#APP_webroot#/includes/browse/form_params.cfm">
	
	<!--- <cfinclude template="#APP_webroot#/includes/browse/general_header.cfm"> --->
		
	<cfif form.status EQ "cat">
	
		<cfinclude template="#APP_webroot#/includes/browse/cat_header.cfm">

	<cfelseif form.status EQ "equip">
	
		<cfinclude template="#APP_webroot#/includes/browse/equip_header.cfm">

	</cfif>


</head>

<cfoutput>
<body bgcolor="#APP_table_bgcolor#">
</cfoutput>

	<div align="center">
	
		<!--- <cfoutput>
		roles: #form.roleList# + #roleIDs# user: #form.userID# + #form.date# + #form.time# + dept: #form.dept# + st: #form.status# + type: #form.type#
		</cfoutput>  ---> 
		<!--- <a href="JavaScript:opener.walkinBuild.equipID.value='321';window.close();">Insert Value</a> --->
	
		<cfif form.status EQ "cat">
			<cfinclude template="#APP_webroot#/includes/browse/cat_ready.cfm">
		<cfelseif form.status EQ "equip">
			<cfinclude template="#APP_webroot#/includes/browse/equip_ready.cfm">
		</cfif>
		
	</div>
	
</body>
</html>
