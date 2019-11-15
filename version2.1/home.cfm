<html>
<head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/home/general_header.cfm">						

	<cfoutput>
		<title>#APP_title#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/validate.js"></script>
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/calendar2.js"></script>
	</cfoutput>
	
</head>

<cfoutput>
<body bgcolor="#APP_page_bgcolor#" onLoad="setCursor();">
</cfoutput>

	<div align="center">

	<cfoutput>
	<table width="#APP_table_width#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
	</cfoutput>
		<tr>
			<td valign="top">&nbsp;<br> 
				
				<table width="600">
					<tr>
						<td width="300" align="center">
							<cfif ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"WorkStudy") OR ListContains(cookie.userAdminType,"PartTime")>
								<cfset pageStatus="ready">
								<cfset pageType="walkin">
								<cfset resUser="">
								<cfset resOnly="no">
							<cfelse>
								<cfset pageStatus="date">
								<cfset pageType="res">
								<cfset resOnly="yes">
								<cfset resUser = cookie.userPSID>
							</cfif>
							<cfoutput>
							<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#" bgcolor="#APP_table_bgcolorInset#">
							</cfoutput>	
							<tr>
									<td align="center" valign="top">
										<cfinclude template="#APP_webroot#/includes/home/form_walkin.cfm">																
									</td>
								</tr>
							</table>
						</td>
						<td width="300" align="center">
							<cfif ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"WorkStudy") OR ListContains(cookie.userAdminType,"PartTime")>
								<cfoutput>
								<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#" bgcolor="#APP_table_bgcolorInset#">
								</cfoutput>	
									<tr>
										<td align="center" valign="top">
											<cfset pageStatus="date">
											<cfset pageType="res">
											<cfset resOnly="yes">
											<cfset resUser="">
											<cfinclude template="#APP_webroot#/includes/home/form_walkin.cfm">																
										</td>
									</tr>
								</table>							
							<cfelse>
								&nbsp;
							</cfif>
						</td>
					</tr>
					<tr><td>&nbsp;<br></td><td>&nbsp;<br></td></tr>
					<cfif ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"WorkStudy") OR ListContains(cookie.userAdminType,"PartTime")>
						<tr>
							<td width="300" align="center" valign="top">
								<cfoutput>
								<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#" bgcolor="#APP_table_bgcolorInset#">
								</cfoutput>	
									<tr>
										<td align="center" valign="top">
											<cfinclude template="#APP_webroot#/includes/home/form_dayview.cfm">																
										</td>
									</tr>
								</table>
							</td>
							<td width="300" align="center" valign="top">
								<cfoutput>
								<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#" bgcolor="#APP_table_bgcolorInset#">
								</cfoutput>	
									<tr>
										<td align="center" valign="top">
											<cfinclude template="#APP_webroot#/includes/home/form_lookup.cfm">																																																														
										</td>
									</tr>
								</table>							
								<br><br>
								<cfoutput>
								<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#" bgcolor="#APP_table_bgcolorInset#">
								</cfoutput>	
									<tr>
										<td align="center" valign="top">
											<cfinclude template="#APP_webroot#/includes/home/form_user_activate.cfm">																																																														
										</td>
									</tr>
								</table>							
							</td>
						</tr>
					</cfif>
					<!--- <tr>
						<td width="300" align="center">&nbsp;<br>
							<table width="200" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="333333" bgcolor="F5F5F5">
								<tr>
									<td align="center" valign="top">										
										<cfinclude template="#APP_webroot#/includes/home/form_upcoming.cfm">																										
									</td>
								</tr>
							</table>
						</td>
						<td width="300" align="center">&nbsp;
						</td>
					</tr> --->
				</table>
				
				<div align="center">
				
					 <!--- <cfoutput>#cgi.Remote_Addr#</cfoutput> ---> 
					<!--- <p>Home page</p> --->

					<!--- <cfmodule 
						template="#APP_webroot#/#APP_path_customtags#/get_hours.cfm"
						date="07/21/03">
						
					<cfmodule 
						template="#APP_webroot#/#APP_path_customtags#/set_due_date.cfm"
						deptID="12"
						resLength="0"
						resOut="10/22/03 7:00">
						
						<cfset testing = 10 LT 5> --->

					<!---<cfoutput> #dueDate# #testing#<br>#isOpen# - #hoursString#<br> #cookie.userRoles# - #cookie.userAdminDepts# - #cookie.userAdminType#</cfoutput> --->
					<!--- <cfoutput>#cookie.userID# - #cookie.userRoles# - #cookie.userAdminDepts# - #cookie.userAdminType#</cfoutput>  --->
									
					
					<!--- <cfset homePage = "yes">
					<cfset topCode = "TOP 20 ">
					<cfset subWidth = "750">
					<cfset url.psid = cookie.userPSID>
					
					<cfinclude template="#APP_webroot#/includes/dbview/res_header.cfm">
	
					<cfoutput>
					<table width="#subWidth#" border="1" cellpadding="2" cellspacing="0" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
					</cfoutput>
					
						<cfmodule 
							template="#APP_webroot#/#APP_path_customtags#/output_row.cfm"
							header="yes"
							ID="0"
							type="res"
							parent="res"
							content="#headerContent#"
							sorters="#columnSorters#"
							align="#alignment#"
							widths="#widths#"
							rowcolor="#APP_table_head_bgcolor#">
						
						<cfset rowcount = 0>
						<cfoutput query="get_content">
	
							<cfset resStatus = "">
							<cfset isResLate = "no">
							<cfset resStatus = STATUS>						
	
							<cfinclude template="#APP_webroot#/includes/dbview/res_row.cfm">
	
							<cfif rowcount MOD 2 EQ 0>
								<cfset bgcolor=APP_rowColorEven>
							<cfelse>
								<cfset bgcolor=APP_rowColorOdd>
							</cfif>
	
							<cfmodule 
								template="#APP_webroot#/#APP_path_customtags#/output_row.cfm"
								header="no"
								type="res"
								parent="res"
								ID="#rowID#"
								status="#resStatus#"
								isLate="#isResLate#"
								content="#tableContent#"
								align="#alignment#"
								widths="#widths#"
								rowcolor="#bgcolor#">		
	
							<cfset rowcount = rowcount + 1>
	
						</cfoutput>
						
						<cfif get_content.RecordCount EQ 0>
							<cfset cSpan = ListLen(headerContent, "|") + 1>
							<cfoutput>
								<tr bgcolor="#APP_rowColorOdd#">
									<td colspan="#cSpan#" align="center">
										<p>&nbsp;<br>There are no items that match your search criteria...<br>&nbsp;</p>
									</td>
								</tr>
							</cfoutput>
						</cfif>
						
					</table> --->	
	
				</div>
			</td>
		</tr>	
	</table>
	

	</div>

</body>
</html>
