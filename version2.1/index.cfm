<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<cfset pageTitle = "Version 2.0">
	<cfoutput>
		<title>#APP_title# | #pageTitle#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
	</cfoutput>
	
	<script language="JavaScript" type="text/JavaScript">
	<!-- 
		window.name="appWindow"; 
	-->
	</script>

	
</head>

<cfoutput>
	<!--- <frameset rows="#APP_topHeightF#, *" border="0" frameborder="no" framespacing="0">
		<frame src="top.cfm" name="top" scrolling="no"> --->
		<frameset cols="#APP_leftWidthF#,*" border="0" frameborder="no" framespacing="0">
			<frame src="navigation.cfm" name="side" scrolling="auto">
			<frame src="home.cfm" name="main">
		</frameset>
	<!--- </frameset> --->
</cfoutput>

<noframes>
</noframes>

</html>
