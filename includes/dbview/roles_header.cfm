

	<cfparam name="url.sorter" default="Upper(R.ROLE_NAME)">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	R.ROLE_ID, R.ROLE_NAME, R.NOTES, D.DEPT_NAME
		from	ROLES R, DEPARTMENTS D
		where	R.DEPT_ID = D.DEPT_ID	
		<cfif url.deptID NEQ "all">
			and R.DEPT_ID=#url.deptID#
		</cfif>
				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Role Name|Department Owner">
	<cfset columnSorters = "Upper(R.ROLE_NAME)|Upper(D.DEPT_NAME)">	
	<cfset alignment = "left|left">	
	<cfset widths = "250|250">	
	