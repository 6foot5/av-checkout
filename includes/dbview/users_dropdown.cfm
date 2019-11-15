

	<cfif ListContains(cookie.userAdminType,"globalAdmin") NEQ 0>
		<cfif url.deptID EQ "all">
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<cfoutput>
		<option value="dbview.cfm?type=cats&deptID=all" #isSelected#>&nbsp;View All Users&nbsp;&nbsp;</option>
		</cfoutput>
	</cfif>
	
