

	<cfparam name="url.sorter" default="Upper(D.DEPT_NAME)">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	D.DEPT_ID, D.DEPT_NAME
		from	DEPARTMENTS D, DEPT_RULES R
		where	D.DEPT_ID = R.DEPT_ID
		<cfif url.deptID NEQ "all">
				and D.DEPT_ID = #url.deptID#
		</cfif>				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Department Name">
	<cfset columnSorters = "Upper(DEPT_NAME)">	
	<cfset alignment = "left">	
	<cfset widths = "500">	
	