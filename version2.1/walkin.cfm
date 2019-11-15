<html>
<head>

	<cfoutput>
		<title>#APP_title#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/validate.js"></script>
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/calendar2.js"></script>
	</cfoutput>
	
	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/walkin/form_params.cfm">
	
	<cfinclude template="#APP_webroot#/includes/walkin/general_header.cfm">
		
	<cfif (form.status EQ "ready" AND form.from EQ "home") OR (form.status EQ "confirm" AND form.existing)>
		<cfinclude template="#APP_webroot#/includes/walkin/get_user.cfm">	
	</cfif>

	<cfif form.status EQ "ready">
	
		<cfinclude template="#APP_webroot#/includes/walkin/equip_process.cfm">	

	<cfelseif form.status EQ "save">
	
	</cfif>


</head>

<cfif form.status EQ "ready">
	<cfoutput>
	<body bgcolor="#APP_page_bgcolor#" onLoad="setCursor();">
	</cfoutput>
<cfelse>
	<cfoutput>
	<body bgcolor="#APP_page_bgcolor#">
	</cfoutput>
</cfif>

	<div align="center">
	
	<cfoutput>
	<table width="#APP_table_width#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
	</cfoutput>
		<tr>
			<td align="center" valign="top"><br>
			
			<!--- <cfoutput>
			#form.date#, #form.time#, #form.psid#, #form.dept#
			</cfoutput> --->
		
				<cfif form.status EQ "ready" or form.status EQ "confirm">
					<!--- <cfinclude template="#APP_webroot#/includes/walkin/form_browse.cfm"> --->								

					<form action="walkin.cfm" name="walkinBuild" method="post" onSubmit="return validateForm(this);">
		
						<table width="600" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="333333" bgcolor="F5F5F5">
							<cfif form.status EQ "ready">
								<tr class="table">
									<td width="200" valign="middle">
										<cfinclude template="#APP_webroot#/includes/walkin/user_display_info.cfm">
									</td>
									<td width="200" align="center" valign="middle">
										<cfinclude template="#APP_webroot#/includes/walkin/form_equip_id.cfm">								
									</td>
									<td width="200" align="center" valign="middle">
										<cfinclude template="#APP_webroot#/includes/walkin/form_datetime.cfm">
									</td>
								</tr>
							<cfelseif form.status EQ "confirm">
								<tr class="table">
									<td width="600" valign="middle" align="left" colspan="2">
										<cfinclude template="#APP_webroot#/includes/walkin/user_display_info.cfm">
									</td>
									<td width="200" align="center" valign="middle">
										<cfinclude template="#APP_webroot#/includes/walkin/form_datetime.cfm">
									</td>
									<!--- <td width="200" align="center" valign="middle">
										<cfinclude template="#APP_webroot#/includes/walkin/form_datetime.cfm">
									</td> --->
								</tr>
							</cfif>
							<tr class="table">
								<td width="600" align="center" colspan="3"><br>
									<cfif form.status EQ "ready">
										<cfoutput>
										<table bgcolor="FFFFFF" border="1" cellspacing="0" cellpadding="5" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
										  <tr>
											<td align="center">&nbsp;&nbsp;Equipment Items Currently in Cart: <b>#validEquips#</b>&nbsp;&nbsp;</td>
										  </tr>
										</table><br><br>
										</cfoutput>

										<cfloop index="ed" from="1" to="#ListLen(form.date)#">
											<cfinclude template="#APP_webroot#/includes/walkin/equip_display.cfm"><br>&nbsp;
										</cfloop>
									
									<cfelseif form.status EQ "confirm">
									
										<cfinclude template="#APP_webroot#/includes/walkin/res_confirm_process.cfm">
										
										<cfloop index="ed" from="1" to="#ListLen(form.date)#">
										
											<cfloop index="d" from="1" to="#ArrayLen(resLengths[ed])#">
												
												<cfif d GT 1>
													<hr width="400" align="center" size="1" noshade>
												</cfif>
		
												<cfoutput>
													<p><b>The following equipment is due on #DateFormat(GetToken(resLengths[ed][d],2,"|"),"ddd m/d/yyyy")#
													at #TimeFormat(GetToken(resLengths[ed][d],3,"|"),"h:mm tt")#</b><!--- <br>#resLengths[d]# ---></p><!--- #form.adminUser# --->
												</cfoutput>
		
												<cfinclude template="#APP_webroot#/includes/walkin/equip_display.cfm">
												
												<cfset noteName = "notes" & GetToken(resLengths[ed][d],1,"|") & ed>
												<cfset miscName = "misc" & GetToken(resLengths[ed][d],1,"|") & ed>
												<!--- <cfset initialName = "initial" & GetToken(resLengths[d],1,"|")> --->
												
												<cfif form.adminUser>
													
													<cfoutput>
														<p><b>Miscellaneous Items:</b><br>
														<textarea class="#APP_style_inputAdmin#" name="#miscName#" rows="2" cols="50">#form.notes#</textarea></p>
														<p><b>Reservation Notes:</b><br>
														<textarea class="#APP_style_inputAdmin#" name="#noteName#" rows="2" cols="50">#form.resNotes#</textarea></p>
													</cfoutput>
												<cfelse>
													<cfoutput>
														<input type="hidden" name="#miscName#" value="">
														<input type="hidden" name="#noteName#" value="">
													</cfoutput>
												</cfif>
												
											</cfloop><br>&nbsp;

										</cfloop>
								
									
									</cfif>
								</td>
							</tr>
							<tr class="table">
								<!--- <td width="400" align="center" valign="middle" colspan="2">
									<cfoutput>
										<p><b>Notes (Put Uncatalogued Items Here):</b><br>
										<textarea class="#APP_style_inputAdmin#" name="notes" rows="4" cols="50">#form.notes#</textarea><br>&nbsp;</p>
									</cfoutput>
								</td> --->
								<td width="600" align="center" valign="middle" colspan="3">
									<cfif form.adminUser AND (form.status EQ "confirm" OR form.existing) AND form.type NEQ "res">
										<cfoutput>
										<p><b>Employee Initials:</b><br><br>
										<input class="#APP_style_inputAdmin#" type="text" name="initials" value="#Trim(form.initials)#" size="10"></p>
										</cfoutput>
										<input type="hidden" name="initial_req" value="yes">
									<cfelse>
										<input type="hidden" name="initial_req" value="no">
										<input type="hidden" name="initials" value="">
									</cfif>
								
									<cfoutput><br>
										<cfif form.status EQ "confirm" AND NOT form.existing>
											<input type="submit" name="submit" value="Go Back" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].status.value='ready';">								
										</cfif>
										<input type="submit" name="submit" value="#buttonName#" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].status.value='#setStatus#';">								
									</cfoutput><br>&nbsp;
								</td>
							</tr>
						</table>

						<cfinclude template="#APP_webroot#/includes/walkin/form_hidden.cfm">
				
					</form>
					
				<cfelseif form.status EQ "date">
				
					<cfinclude template="#APP_webroot#/includes/walkin/get_date_header.cfm">
					
					<form action="walkin.cfm" name="walkinBuild" method="post" onSubmit="return validateForm(this);">
						<cfinclude template="#APP_webroot#/includes/walkin/form_hidden.cfm">						
						<cfinclude template="#APP_webroot#/includes/walkin/get_date.cfm">
						<cfoutput>
							<input type="submit" name="submit" value="#buttonName#" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].status.value='#setStatus#';">								
						</cfoutput>						
					</form>
		
					<cfinclude template="#APP_webroot#/includes/walkin/get_date_footer.cfm">

				<cfelseif form.status EQ "time">
					
					<form action="walkin.cfm" name="walkinBuild" method="post">
						<cfinclude template="#APP_webroot#/includes/walkin/form_hidden.cfm">						
						<cfinclude template="#APP_webroot#/includes/walkin/get_time.cfm">
						<cfif numTimes>
							<cfoutput>
								<input type="hidden" name="formatDT" value="yes">
								<input type="submit" name="submit" value="#buttonName#" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].status.value='#setStatus#';">								
							</cfoutput>
						<cfelse>						
							<cfoutput>
								<input type="submit" name="submit" value="Go Back" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].status.value='date';">								
							</cfoutput>
						</cfif>						
					</form>
		
				<!--- <cfelseif form.status EQ "confirm">
					
					<cfinclude template="#APP_webroot#/includes/walkin/res_confirm.cfm">
					
					<p>You're a-confirmin'</p> --->
					
				<cfelseif form.status EQ "save">
					
					<cfinclude template="#APP_webroot#/includes/walkin/res_save.cfm">
					
					<p>Processing Request...  Please Wait...</p>
					
					<!--- <EMBED SRC="#APP_webroot#/images/success.wav" AUTOSTART="true" HIDDEN="true" LOOP="1"> --->
					
					<cfoutput>
						<form action="home.cfm" method="post" name="checkMade">
							<input type="hidden" name="walkinSource" value="yes">
						</form>
					</cfoutput>	
				
					<script language="JavaScript">
					<!--
						document.forms['checkMade'].submit();
					-->
					</script>

				</cfif>

			</td>
		</tr>	
	</table>

	</div>
	
</body>
</html>
