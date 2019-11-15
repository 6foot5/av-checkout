

	<cfparam name="url.sorter" default="Upper(DEPT_NAME)">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	DEPT_ID, DEPT_NAME
		from	DEPARTMENTS
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Department Name">
	<cfset columnSorters = "Upper(DEPT_NAME)">	
	<cfset alignment = "left">	
	<cfset widths = "500">	
	