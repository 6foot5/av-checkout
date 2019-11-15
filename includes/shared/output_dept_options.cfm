
	<cfparam name="compareDept" default="">
	<cfparam name="dList" default="">
	<cfparam name="showAll" default="no">
	<cfparam name="resOnly" default="no">

	<cfquery name="get_depts" datasource="#APP_dsn#">
		select 	DEPT_NAME, DEPT_ID
		from 	DEPARTMENTS
		where	1 = 1
		<cfif NOT showAll>
			and DEPT_ID in (#dList#)
		</cfif>
		<cfif resOnly>
			and	RTRIM(LTRIM(RES_ONLINE)) = 'yes'
		</cfif>
		order by
				DEPT_NAME
	</cfquery>

	<cfoutput query="get_depts">
		<cfif compareDept EQ DEPT_ID>
			<cfset isSelected = "selected">
		<cfelse>
			<cfset isSelected = "">
		</cfif>
		<option value="#DEPT_ID#" #isSelected#>#DEPT_NAME# &nbsp;</option>
	</cfoutput>
	
	<cfif NOT get_depts.recordcount>
		<option value="0">No Departments Available&nbsp;</option>	
	</cfif>	

