
<cfoutput>

	<p>Hours for Department:<br>
	<cfquery name="get_dept" datasource="#APP_dsn#">
		select	DEPT_NAME
		from	DEPARTMENTS
		where	DEPT_ID = #hDept#
	</cfquery>
	
	<b>#get_dept.DEPT_NAME#</b>
	
	<input type="hidden" name="hDept" value="#hDept#"></p>
									
	<!--- <select class="#APP_style_inputAdmin#" name="hDept">
		<cfset compareDept = hDept>
		<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
			<cfset dList="">
			<cfset showAll = "yes">
		<cfelse>
			<cfset showAll = "no">
			<cfset dList = cookie.userAdminDepts>
		</cfif>
		<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
	</select> --->
	</p>									

	<p>Name for hours (e.g. <i>Normal Hours</i> or <i>Winter Break Hours</i>, etc.):<br><br>
	
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="hTag" value="#hTag#"></p>								

	<p>Below, please select the type of hours you are currently defining.  <i>Normal</i> hours will be in effect by default over the dates 
	you specify.  <i>Override</i> hours will temporarily override any normal operating hours for the dates you specify.  
	You should first set up normal operating hours as a baseline and then, as necessary, overrride them by defining new sets of hours 
	to temporarily override normal hours for the dates you specify.</p>
	<p>These hours will...<br><br>
	<cfif dbEditID EQ 0>
		<select class="#APP_style_inputAdmin#" name="hType">
			<cfif hType EQ "normal" or hType EQ "">
				<option value="normal" Selected>Define Normal Operating Hours &nbsp;</option>
				<option value="override">Temporarily Override Normal Operating Hours &nbsp;</option>
			<cfelse>
				<option value="override" Selected>Override Normal Operating Hours &nbsp;</option>
				<option value="normal">Temporarily Define Normal Operating Hours &nbsp;</option>
			</cfif>
		</select>
	<cfelse>
		<input type="hidden" name="hType" value="#hType#">
		#typeDescr#
	</cfif>
	</p>									

	<p>These hours will be in effect from:<br><br>
	<input class="#APP_style_inputAdmin#" type="text" size="12" name="hDateOn" value="#hDateOn#">
	<a href="javascript:cal1.popup();"><img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a>
	To:
	<input class="#APP_style_inputAdmin#" type="text" size="12" name="hDateOff" value="#hDateOff#">
	<a href="javascript:cal2.popup();"><img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a>	
	</p>								
	
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="status" value="ready">
									
</cfoutput>
