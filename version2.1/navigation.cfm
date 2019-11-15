<html>
<head>
	<cfoutput>
		<title>Navigation</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/validate.js"></script>
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/calendar2.js"></script>
	</cfoutput>
	
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

<cfoutput>
<body bgcolor="#APP_page_bgcolor#">
</cfoutput>
	
	<div align="center">
	
		<cfoutput>
		<table width="125" height="#APP_table_height#" border="#APP_mainTableBorder#" cellpadding="5" cellspacing="0" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
		</cfoutput>	
			<tr>		
				<td valign="top"><p>
					<b>Navigation</b><br><br>
					<a href="home.cfm" target="main">Home</a><br><br>
					<cfoutput>
						<a href="dbview.cfm?source=self&type=res&psid=#Trim(cookie.userPSID)#&deptID=all" target="main">Your Reservations</a><br><br>
						<cfset currUserID = GetToken(cookie.userID,1,",")>
						<a href="dbcontent.cfm?type=users&source=self&editID=#currUserID#" target="main">Your Profile</a><br><br>
					</cfoutput>
					<cfif ListContains(cookie.userAdminType,"globalAdmin")>
						<a href="dbview.cfm?type=dept" target="main">Departments</a><br><br>
					</cfif>
					<cfif ListContains(cookie.userAdminType,"FineMaster") OR ListContains(cookie.userAdminType,"globalAdmin")>
						<a href="dbview.cfm?type=fines" target="main">Fines</a><br><br>
					</cfif>
					<cfif ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"globalAdmin") OR ListContains(cookie.userAdminType,"PartTime")>
						<a href="dbview.cfm?type=equipment" target="main">Inventory</a><br><br>
						<a href="dbview.cfm?type=acc" target="main">Accessories</a><br><br>
						<!--- <a href="dbview.cfm?type=users" target="main">Manage Users</a><br><br> --->
						<a href="dbview.cfm?type=hours" target="main">Hours</a><br><br>
						<!--- <a href="dbview.cfm?type=rules" target="main">Preferences</a><br><br> --->
						<a href="dbview.cfm?type=cats" target="main">Categories</a><br><br>
						<cfif ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"globalAdmin")>
							<a href="dbview.cfm?type=roles" target="main">Roles</a><br><br>
						</cfif>
					</cfif>
					<cfoutput>
						<a href="#APP_webroot#/logoff.cfm">Logoff</a> 
					</cfoutput>
					<!--- <cfif (ListContains(cookie.userAdminType,"fineMaster") NEQ 0) OR (ListContains(cookie.userAdminType,"globalAdmin") NEQ 0)>
						<a href="JavaScript:void(0);" target="main">Fines</a><br><br>
					</cfif> --->
					</p>				
				</td>
			</tr>	
		</table>
	
	</div>

</body>
</html>
