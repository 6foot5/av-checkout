

	<cfinclude template="#APP_webroot#/includes/dbview/dept_choose.cfm">

	<cfoutput query="get_depts">
		<cfif url.deptID EQ DEPT_ID>
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<option value="dbview.cfm?type=#contentType#&deptID=#DEPT_ID#" #isSelected#>&nbsp;View Hours for #DEPT_NAME#&nbsp;&nbsp;</option>
	</cfoutput>
	
