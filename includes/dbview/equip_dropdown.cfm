

	<cfinclude template="#APP_webroot#/includes/dbview/dept_choose.cfm">

	<cfoutput query="get_depts">
		<cfset deptName = DEPT_NAME>
		<cfset deptID = DEPT_ID>
		<option value="JavaScript:void(0);">&nbsp;- - - - - &nbsp;&nbsp;&nbsp;</option>
		<cfif url.deptID EQ DEPT_ID>
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<option value="dbview.cfm?type=#contentType#&deptID=#deptID#" #isSelected#>&nbsp;#deptName# - View all Equipment&nbsp;&nbsp;</option>
		<cfquery name="get_cats" datasource="#APP_dsn#">
			select	CAT_ID, CAT_NAME
			from 	CATEGORIES
			where	DEPT_ID = #DEPT_ID#
			order by CAT_NAME
		</cfquery>
		<cfloop query="get_cats">
			<cfif url.catID EQ CAT_ID>
				<cfset isSelected = "selected">
			<cfelse>
				<cfset isSelected = "">
			</cfif>
			<option value="dbview.cfm?type=#contentType#&deptID=#deptID#&catID=#CAT_ID#" #isSelected#>&nbsp;#deptName# - #CAT_NAME#&nbsp;&nbsp;</option>			
		</cfloop>		
	</cfoutput>
	
