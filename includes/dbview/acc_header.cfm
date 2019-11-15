

	<cfparam name="url.sorter" default="Upper(PKG_NAME)">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	PKG_ID, PKG_NAME
		from	ACCESSORY_PKG
		where 	RTRIM(LTRIM(STATUS)) = 'current'
		<cfif url.deptID NEQ "all">
			and DEPT_ID=#url.deptID#
		</cfif>
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Package Name">
	<cfset columnSorters = "Upper(PKG_NAME)">	
	<cfset alignment = "left">	
	<cfset widths = "500">	
	