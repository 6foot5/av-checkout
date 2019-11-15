<html>
<head>
	<cfoutput>
		<title>Navigation</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
	</cfoutput>
	
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

<cfoutput>
<body bgcolor="#APP_head_bgcolor#" topmargin="2">
</cfoutput>

	<a 	href="javascript:parent.frames[1].history.back();">&lt;&lt;&lt; Go Back</a> 
	&nbsp;&nbsp;
	<cfoutput>
		<a href="#APP_webroot#/logoff.cfm">Logoff</a> 
	</cfoutput>

</body>

</html>
