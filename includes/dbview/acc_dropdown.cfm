
	<cfinclude template="#APP_webroot#/includes/dbview/dept_choose.cfm">

	<cfif ListContains(cookie.userAdminType,"globalAdmin") NEQ 0>
		<cfif url.deptID EQ "all">
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<cfoutput>
		<option value="dbview.cfm?type=#contentType#&deptID=all" #isSelected#>&nbsp;View Accessories for All Departments&nbsp;&nbsp;</option>
		</cfoutput>
	</cfif>

	<cfoutput query="get_depts">
		<cfif url.deptID EQ DEPT_ID>
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<option value="dbview.cfm?type=#contentType#&deptID=#DEPT_ID#" #isSelected#>&nbsp;View Accessories for #DEPT_NAME#&nbsp;&nbsp;</option>
	</cfoutput>
	
