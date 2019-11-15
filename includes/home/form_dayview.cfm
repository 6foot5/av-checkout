

<!---  commented out 11/3/03 - global admin cannot see res lookup form??
<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 AND ListContains(cookie.userAdminType,"globalAdmin") EQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
<!--- <cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
	<cfoutput>
		<form action="dbview.cfm?type=res" name="dayview" method="post" target="resView" onSubmit="return validateDayviewForm(this);">
			<p><b>Daily View</b><br><br>
			Department:<br>
			<select class="#APP_style_inputAdmin#" name="dept">
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				
				<!--- <cfset extraSQL = "and R.ROLE_NAME = 'Admin'"> --->
				<cfset compareDept = "">
				<cfif (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
					<cfset dList="">
					<cfset showAll = "yes">
				<cfelse>
					<cfset showAll = "no">
					<cfset dList = cookie.userAdminDepts>
				</cfif>
				<cfinclude template="#APP_webroot#/includes/shared/output_dept_options.cfm">
				<!--- <cfloop query="get_depts">
					<option value="#DEPT_ID#">#DEPT_NAME#</option>
				</cfloop> --->
			</select><br><br>

			<cfset todayDT = DateFormat(Now(),"m/d/yyyy")>
			Select Date Below:<br>
			<input type="text" name="date" size="15" class="#APP_style_inputAdmin#" value="#todayDT#">
			<a href="javascript:cal1.popup();"><img src="img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a>
			<br><br>
			
			<input type="hidden" name="upcoming" value="all">
			<input type="hidden" name="late" value="no">
			<input type="hidden" name="updateStatus" value="yes">

			<input type="submit" name="bydate" value="Lookup by Date" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].late.value='no';document.forms['dayview'].upcoming.value='all';">
			
			<br><br><hr width="90%" size="1" noshade><br>
			
			<input type="submit" name="bycheckin" value="Late Equipment" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].upcoming.value='checkins';document.forms['dayview'].late.value='yes';document.forms['dayview'].date.value='';"><br><br>
			<input type="submit" name="bycheckin" value="Upcoming Drop-Offs" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].upcoming.value='checkins';document.forms['dayview'].late.value='no';document.forms['dayview'].date.value='';"><br><br>
			<input type="submit" name="bycheckout" value="Upcoming Pickups" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].upcoming.value='checkouts';document.forms['dayview'].late.value='no';document.forms['dayview'].date.value='';">

			</p>
		</form>
		<script language="JavaScript">
		<!-- // create calendar object(s) just after form tag closed
			 // specify form element as the only parameter (document.forms['formname'].elements['inputname']);
			 // note: you can have as many calendar objects as you need for your application
			var cal1 = new calendar2(document.forms['dayview'].elements['date']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
		//-->
		</script>
	</cfoutput>
<!--- <cfelse>
	<p>no lookup access
</cfif> --->
