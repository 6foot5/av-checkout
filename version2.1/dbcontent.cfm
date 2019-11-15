<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

	<cfparam name="url.type" default="">
	<cfparam name="form.source" default="internal">
	<cfparam name="url.source" default="#form.source#">

	<cfif NOT (url.type EQ "users" AND url.source EQ "login")>
		<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						
	</cfif>

	<cfinclude template="#APP_webroot#/includes/dbcontent/general_header.cfm">						

	<cfset extraURL = "">
	<cfset innerTableWidth = 600>

	<cfif form.status eq "ready">	<!--- page is in input mode - either ADD NEW or EDIT EXISTING --->		
			
		<cfswitch expression="#contentType#">

			<cfcase value="equipment">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/equip_header.cfm">						
			</cfcase>

			<cfcase value="hours">				
				<cfif form.step EQ "one">
					<cfinclude template="#APP_webroot#/includes/dbcontent/hours_header_1.cfm">						
				<cfelseif form.step EQ "two">
					<cfinclude template="#APP_webroot#/includes/dbcontent/hours_header_2.cfm">						
				<cfelseif form.step EQ "three">
					<cfinclude template="#APP_webroot#/includes/dbcontent/hours_header_3.cfm">						
				</cfif>
			</cfcase>

			<cfcase value="dept">				
				<cfif form.step EQ "one">
					<cfinclude template="#APP_webroot#/includes/dbcontent/dept_header_1.cfm">						
				<cfelseif form.step EQ "two">
					<cfinclude template="#APP_webroot#/includes/dbcontent/dept_header_2.cfm">						
				<cfelseif form.step EQ "three">
					<cfinclude template="#APP_webroot#/includes/dbcontent/dept_header_3.cfm">						
				</cfif>
			</cfcase>

			<cfcase value="acc">				
				<cfif form.step EQ "one">
					<cfinclude template="#APP_webroot#/includes/dbcontent/acc_header_1.cfm">						
				<cfelseif form.step EQ "two">
					<cfinclude template="#APP_webroot#/includes/dbcontent/acc_header_2.cfm">						
				</cfif>
			</cfcase>

			<cfcase value="roles">				
				<cfif form.step EQ "one">
					<cfinclude template="#APP_webroot#/includes/dbcontent/role_header_1.cfm">						
				<cfelseif form.step EQ "two">
					<cfinclude template="#APP_webroot#/includes/dbcontent/role_header_2.cfm">						
				</cfif>
			</cfcase>

			<cfcase value="cats">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/cat_header.cfm">						
			</cfcase>

			<cfcase value="org">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/org_header.cfm">						
			</cfcase>

			<cfcase value="fines">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/fine_header.cfm">						
			</cfcase>

			<cfcase value="rolesE">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/roleE_header.cfm">						
			</cfcase>

			<cfcase value="rolesU">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/roleU_header.cfm">						
			</cfcase>

			<cfcase value="users">				
				<cfif form.step EQ "one">
					<cfinclude template="#APP_webroot#/includes/dbcontent/users_header_1.cfm">						
				<cfelseif form.step EQ "two">
					<cfinclude template="#APP_webroot#/includes/dbcontent/users_header_2.cfm">						
				</cfif>
				<cfif url.source EQ "login">
					<cfset innerTableWidth = 400>
				</cfif>
				<cfset extraURL = "?source=" & url.source>
			</cfcase>

			<cfcase value="usersA">				
				<cfinclude template="#APP_webroot#/includes/dbcontent/usersA_header.cfm">						
			</cfcase>

		</cfswitch>
	
	</cfif>
	
	<cfoutput>
		<title>#APP_title# | #pageTitle#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/validate.js"></script>
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/calendar2.js"></script>
	</cfoutput>
	
</head> 

<cfif form.status eq "ready">
	<cfoutput>
	<body bgcolor="#APP_page_bgcolor#" onLoad="setCursor();">
	</cfoutput>
<cfelse>
	<cfoutput>
	<body bgcolor="#APP_page_bgcolor#">
	</cfoutput>
</cfif>

	<div align="center">

	<cfif form.status eq "ready">
	
		<cfoutput>
		<table width="#APP_table_width#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
		</cfoutput>
		
			<tr>
				<td align="center" valign="top"> 
	
					&nbsp;<br>
				
					<cfoutput>
					<!--- #referringURL# <br><Br>--->
					<table width="#innerTableWidth#" cellpadding="15" cellspacing="0" border="1" bgcolor="#APP_table_bgcolorInset#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
						<tr>
							<td width="#innerTableWidth#" valign="top">
					</cfoutput>
			
								<cfoutput><h4>#pageTitle#</h4></cfoutput>
								
								<cfif form.error NEQ "">
									<p class="errorRed"><cfoutput>#form.error#</cfoutput></p>
								</cfif>
								
								<cfoutput>
								<form action="dbcontent.cfm#extraURL#" method="post" name="form1" onsubmit="return validateForm(this);">	
								</cfoutput>	
					
									<cfswitch expression="#contentType#">
								
										<cfcase value="equipment">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/equip_ready.cfm">						
										</cfcase>
											
										<cfcase value="hours">					
											<cfif form.step EQ "one">
												<cfinclude template="#APP_webroot#/includes/dbcontent/hours_ready_1.cfm">						
											<cfelseif form.step EQ "two">
												<cfinclude template="#APP_webroot#/includes/dbcontent/hours_ready_2.cfm">						
											<cfelseif form.step EQ "three">
												<cfinclude template="#APP_webroot#/includes/dbcontent/hours_ready_3.cfm">						
											</cfif>
										</cfcase>
											
										<cfcase value="dept">					
											<cfif form.step EQ "one">
												<cfinclude template="#APP_webroot#/includes/dbcontent/dept_ready_1.cfm">						
											<cfelseif form.step EQ "two">
												<cfinclude template="#APP_webroot#/includes/dbcontent/dept_ready_2.cfm">						
											<cfelseif form.step EQ "three">
												<cfinclude template="#APP_webroot#/includes/dbcontent/dept_ready_3.cfm">						
											</cfif>
										</cfcase>
											
										<cfcase value="acc">				
											<cfif form.step EQ "one">
												<cfinclude template="#APP_webroot#/includes/dbcontent/acc_ready_1.cfm">						
											<cfelseif form.step EQ "two">
												<cfinclude template="#APP_webroot#/includes/dbcontent/acc_ready_2.cfm">						
											</cfif>
										</cfcase>
							
										<cfcase value="roles">				
											<cfif form.step EQ "one">
												<cfinclude template="#APP_webroot#/includes/dbcontent/role_ready_1.cfm">						
											<cfelseif form.step EQ "two">
												<cfinclude template="#APP_webroot#/includes/dbcontent/role_ready_2.cfm">						
											</cfif>
										</cfcase>
							
										<cfcase value="cats">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/cat_ready.cfm">						
										</cfcase>
											
										<cfcase value="org">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/org_ready.cfm">						
										</cfcase>
											
										<cfcase value="fines">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/fine_ready.cfm">						
										</cfcase>
											
										<cfcase value="rolesE">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/roleE_ready.cfm">						
										</cfcase>
											
										<cfcase value="rolesU">					
											<cfinclude template="#APP_webroot#/includes/dbcontent/roleU_ready.cfm">						
										</cfcase>
											
										<cfcase value="users">				
											<cfif form.step EQ "one">
												<cfinclude template="#APP_webroot#/includes/dbcontent/users_ready_1.cfm">						
											<cfelseif form.step EQ "two">
												<cfinclude template="#APP_webroot#/includes/dbcontent/users_ready_2.cfm">						
											</cfif>
										</cfcase>
							
										<cfcase value="usersA">				
											<cfinclude template="#APP_webroot#/includes/dbcontent/usersA_ready.cfm">						
										</cfcase>
							
									</cfswitch>
															
									<cfoutput>
										<input type="hidden" name="source" value="#url.source#">
										<input type="hidden" name="URL" value="#referringURL#">
										<input class="#APP_style_inputAdmin#" type="submit" value="Save and Continue">
									</cfoutput>
			
								</form>						
									
								<cfif contentType EQ "hours" and form.step EQ "one">
									<script language="JavaScript">
									<!-- // create calendar object(s) just after form tag closed
										 // specify form element as the only parameter (document.forms['formname'].elements['inputname']);
										 // note: you can have as many calendar objects as you need for your application
										var cal1 = new calendar2(document.forms['form1'].elements['hDateOn']);
										cal1.year_scroll = true;
										cal1.time_comp = false;
										var cal2 = new calendar2(document.forms['form1'].elements['hDateOff']);
										cal2.year_scroll = true;
										cal2.time_comp = false;
									//-->
									</script>
								</cfif>
							</td>
						</tr>
					</table>
	
				</td>
			</tr>	
		</table>
	</div>

	<cfelseif form.status eq "save">
	
		<cfoutput>
		<table width="#APP_table_width#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
		</cfoutput>
		
			<tr>
				<td align="center" valign="top"> 

					<cfset loadReferringPage = "yes">
				
					<cfswitch expression="#form.contentType#">
					
						<cfcase value="equipment">
							<cfinclude template="#APP_webroot#/includes/dbcontent/equip_save.cfm">						
						</cfcase>
						
						<cfcase value="hours">
							<cfinclude template="#APP_webroot#/includes/dbcontent/hours_save.cfm">						
						</cfcase>
						
						<cfcase value="dept">
							<cfinclude template="#APP_webroot#/includes/dbcontent/dept_save.cfm">						
						</cfcase>
									
						<cfcase value="acc">
							<cfinclude template="#APP_webroot#/includes/dbcontent/acc_save.cfm">						
						</cfcase>
									
						<cfcase value="roles">
							<cfinclude template="#APP_webroot#/includes/dbcontent/role_save.cfm">						
						</cfcase>
									
						<cfcase value="cats">
							<cfinclude template="#APP_webroot#/includes/dbcontent/cat_save.cfm">						
						</cfcase>
									
						<cfcase value="org">
							<cfinclude template="#APP_webroot#/includes/dbcontent/org_save.cfm">						
						</cfcase>
									
						<cfcase value="fines">
							<cfinclude template="#APP_webroot#/includes/dbcontent/fine_save.cfm">						
						</cfcase>
									
						<cfcase value="rolesE">
							<cfinclude template="#APP_webroot#/includes/dbcontent/roleE_save.cfm">						
						</cfcase>
									
						<cfcase value="rolesU">
							<cfinclude template="#APP_webroot#/includes/dbcontent/roleU_save.cfm">						
						</cfcase>
									
						<cfcase value="users">
							<cfif url.source NEQ "internal">
								<cfset loadReferringPage = "no">							
							</cfif>
							<cfinclude template="#APP_webroot#/includes/dbcontent/users_save.cfm">													
							<!--- <cfif url.source EQ "login">
								<cfinclude template="#APP_webroot#/includes/dbcontent/users_save_echo.cfm">													
							</cfif> --->
						</cfcase>
									
					</cfswitch>
					
					<cfoutput>
						<form action="#referringURL#" method="post" name="editMade">
							<input type="hidden" name="dbcontentSource" value="yes">
						</form>
					</cfoutput>	
				
					<script language="JavaScript">
					<!--
						
						<cfif loadReferringPage>
							document.forms['editMade'].submit();
						</cfif>
						//window.location.replace('index.cfm');
					-->
					</script>
																
				</td>
			</tr>	
		</table>
	</cfif>
	
</body>
</html>
