

	<cfparam name="url.sorter" default="Upper(C.CAT_NAME)">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	C.CAT_ID, C.CAT_NAME, D.DEPT_NAME
		from	CATEGORIES C, DEPARTMENTS D
		where	C.DEPT_ID = D.DEPT_ID	
		<cfif url.deptID NEQ "all">
			and C.DEPT_ID=#url.deptID#
		</cfif>
				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Category Name|Department Owner">
	<cfset columnSorters = "Upper(C.CAT_NAME)|Upper(D.DEPT_NAME)">	
	<cfset alignment = "left|left">	
	<cfset widths = "250|250">	
	