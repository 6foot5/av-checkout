<html>
<head>

	<cfoutput>
		<title>#APP_title#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
		<script language="JavaScript" src="#APP_webroot#/#APP_path_js#/validate.js"></script>
	</cfoutput>
	
	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/checkin/form_params.cfm">
	
	<cfset thisPage="checkin">
	
	<cfif form.status EQ "ready">
	
		<cfinclude template="#APP_webroot#/includes/checkin/equip_process.cfm">	

	<cfelseif form.status EQ "save">
	
	</cfif>


</head>

<cfif form.status EQ "ready">
	<cfoutput>
	<body bgcolor="#APP_page_bgcolor#">
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
		
				<cfif form.status EQ "ready">

					<cfoutput>
					<form action="checkin.cfm?deptID=#url.deptID#" name="checkinBuild" method="post" onSubmit="return validateForm(this);">
					</cfoutput>
		
						<table width="600" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="333333" bgcolor="F5F5F5">
							<tr class="table">
								<td width="600" align="center" colspan="3"><br>
									<cfif form.status EQ "ready">
									
										<p><b>Equipment Items to Checkin: </b><br><br></p>
										
										<cfset displayTable = "no">
										<cfset checkedEquips = validEquips - form.alreadyChecked>
										<cfif NOT form.somethingChecked AND (form.somethingChecked NEQ checkedEquips)>
											<cfset displayTable = "yes">
											<cfset tableColor = "FF0000">
											<cfset tdClass = "errorRed">
											<cfset headAlert = "STOP!">
											<cfset msgText = "You have not yet checked any items in!  Before you continue, you must check in each returned item by clicking its <b>Checkin</b> button.  Once you have checked in all items that are being returned, click on the <b>Complete Checkin</b> button.">
										<cfelseif form.somethingChecked AND (form.somethingChecked LT checkedEquips)>
											<cfset displayTable = "yes">
											<cfset tableColor = "FF9900">
											<cfset tdClass = "errorOrange">
											<cfset headAlert = "Warning!">
											<cfset msgText = "There are still items that have not been checked in.  It may be that they are not being returned at this time.  But before you continue, make sure to check in each returned item by clicking its <b>Checkin</b> button.  Once you have checked in all items that are being returned, click on the <b>Complete Checkin</b> button.">
										<cfelseif form.somethingChecked AND (form.somethingChecked EQ checkedEquips)>
											<cfset displayTable = "yes">
											<cfset tableColor = "009900">
											<cfset tdClass = "errorGreen">
											<cfset headAlert = "All Clear!">
											<cfset msgText = "You have checked in all catalogued items!  If there are no miscellaneous items to be returned, then click the <b>Complete Checkin</b> button to finalize (this action is required to process all returned items).">
										</cfif>
										
										<cfif displayTable>
											<cfoutput>
												<table width="500" cellpadding="10" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#tableColor#">
													<tr>
														<td>
															<h4 class="#tdClass#" align="center">#headAlert#</h4>
															<p class="#tdClass#">#msgText#<br></p>
														</td>
													</tr>
												</table><br><br>
											</cfoutput>
										</cfif>
																				
										<table width="500" cellpadding="10" cellspacing="0" border="1" style="border-collapse: collapse">
											<tr>
												<td align="center">
													<p><b>Reservation Notes</b>:<br><br> <cfoutput>#resNotes#</cfoutput><br></p>
												</td>
											</tr>
										</table><br><br>
										
										<cfloop index="ed" from="1" to="1">  <!--- to work with equipdisplay (tuned for recurring) --->
											<cfinclude template="#APP_webroot#/includes/walkin/equip_display.cfm"><br>&nbsp;										
										</cfloop>
										

										<br>
										
										<cfif (form.somethingChecked EQ checkedEquips) AND (miscNotes NEQ "None")>

											<cfset tableColor = "FF0000">
											<cfset tdClass = "errorRed">
											<cfset headAlert = "STOP!">
											<cfset msgText = "There are miscellaneous items included with this reservation.  Check the box below to check them in.">
											
											<cfoutput>
												<table width="500" cellpadding="10" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#tableColor#">
													<tr>
														<td class="#tdClass#">
															<h4 align="center">#headAlert#</h4>
															<p>#msgText#<br></p>
														</td>
													</tr>
												</table><br><br>
											</cfoutput>
											
											<b>Miscellaneous Items</b>:<br><br> <cfoutput>#miscNotes#</cfoutput></p>
										
											<input type="checkbox" name="miscOutstanding"> Check-in Miscellaneous item(s)<br><br>
										
										<cfelse>

											<b>Miscellaneous Items</b>:<br><br> <cfoutput>#miscNotes#</cfoutput></p>
										
											<input type="hidden" name="miscOutstanding" value="on">
										
										</cfif>
										
										<!--- <cfif form.adminUser> --->
											<cfoutput>
											<p><b>Employee Initials:</b><br><br>
											<input class="#APP_style_inputAdmin#" type="text" name="initials" value="#Trim(form.initials)#" size="10"></p>
											</cfoutput>
											<input type="hidden" name="initial_req" value="no">
										<!--- <cfelse>
											<input type="hidden" name="initial_req" value="no">
											<input type="hidden" name="initials" value="">
										</cfif> --->
										
										<cfmodule 
											template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
											deptID="#url.deptID#">
										
										<cfset timesUpFocker = CreateODBCDateTime(DateAdd("n",(fineStart*-1),Now()))>
										<!--- this variable below is now set in form_params.cfm with value from query - RESERVATIONS.DUE_DT 
										<cfset resDue = CreateODBCDateTime(GetToken(GetToken(equipArray[1],1,"|"),5,"_"))> --->

										<cfif timesUpFocker GT resDue>
											<cfset resIsLate = "yes">
											<cfset resFine = 0>
										<cfelse>
											<cfset resIsLate = "no">
										</cfif>
										
										<cfif resIsLate>
										
											<cfif validEquips EQ 1>
												
												<cfset equipArray[1] = ArrayToList(equipArray[1])>
												<cfset eID = GetToken(GetToken(equipArray[1],1,"|"),1,"_")>
												<cfset equipArray[1] = ListToArray(equipArray[1])>
												
												<cfmodule 
													template="#APP_webroot#/#APP_path_customtags#/fine_calculator.cfm"
													equipID="#eID#"
													deptID="#url.deptID#"
													dueDT="#resDue#">
													
												<cfset resFine = fine>

											<cfelseif validEquips GT 1>
											
												<cfmodule 
													template="#APP_webroot#/#APP_path_customtags#/fine_calculator.cfm"
													deptID="#url.deptID#"
													dueDT="#resDue#">
													
												<cfset resFine = fine>

											<cfelse>
											
												<cfset resFine = 0>
												
											</cfif>
										
										<cfelse>

											<cfset resFine = 0>
											
										</cfif>
																			
									</cfif>
								</td>
							</tr>
							<tr class="table">
								<td width="600" align="center" valign="middle" colspan="3">
									<cfoutput><br>
										<input type="submit" name="submit" value="Complete Checkin" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['checkinBuild'].status.value='save';document.forms['checkinBuild'].initial_req.value='yes';">								
										<cfif resFine GT 0>
											<br>
											<p><b>(with a $#resFine# fine)</b><br>&nbsp;</p>
										<cfelse>
											<br>&nbsp;
										</cfif>
									</cfoutput>
								</td>
							</tr>
						</table>

						<cfinclude template="#APP_webroot#/includes/checkin/form_hidden.cfm">
				
					</form>
					
				<cfelseif form.status EQ "save">
					
					<cfinclude template="#APP_webroot#/includes/checkin/checkin_save.cfm">
					
					<p>You're a-savin'</p>
					
					<cfoutput>
						<form action="home.cfm" method="post" name="checkinMade">
							<input type="hidden" name="checkinSource" value="yes">
						</form>
					</cfoutput>	
				
					<script language="JavaScript">
					<!--
						document.forms['checkinMade'].submit();
					-->
					</script>

				</cfif>

			</td>
		</tr>	
	</table>

	</div>
	
</body>
</html>
