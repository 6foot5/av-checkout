<html>
<head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/dbview/general_header.cfm">						

	<cfset extraURL = "">
	<cfset viewParent = "dbview">
	<cfset mainWidth = APP_table_width>
	<cfset subWidth = "600">

	<cfswitch expression="#contentType#">

		<cfcase value="equipment">				
			<cfinclude template="#APP_webroot#/includes/dbview/equip_header.cfm">
		</cfcase>

		<cfcase value="hours">				
			<cfinclude template="#APP_webroot#/includes/dbview/hours_header.cfm">
		</cfcase>

		<cfcase value="cats">				
			<cfinclude template="#APP_webroot#/includes/dbview/cat_header.cfm">
		</cfcase>

		<cfcase value="roles">				
			<cfinclude template="#APP_webroot#/includes/dbview/roles_header.cfm">
		</cfcase>

		<cfcase value="dept">				
			<cfinclude template="#APP_webroot#/includes/dbview/dept_header.cfm">
		</cfcase>

		<cfcase value="acc">				
			<cfinclude template="#APP_webroot#/includes/dbview/acc_header.cfm">
		</cfcase>

		<cfcase value="fines">				
			<cfinclude template="#APP_webroot#/includes/dbview/fine_header.cfm">
		</cfcase>

		<cfcase value="res">				
			<cfinclude template="#APP_webroot#/includes/dbview/res_header.cfm">
			<cfset viewParent = "res">
			<cfset mainWidth = "90%">
			<cfset subWidth = "750">
			<!---  purpose is to solve referring url problem on res cancel....
			<cfif url.deleteID>
				<cfoutput>
					<form action="dbdelete.cfm?type=res&deleteID=#url.deleteID#" method="post" name="deleteMade">
						<input type="hidden" name="dbdeleteSource" value="yes">
					</form>
				</cfoutput>						
				<script language="JavaScript">
				<!--
					//document.forms['deleteMade'].submit();
				-->
				</script>															
			</cfif> --->
		</cfcase>

		<cfcase value="users">				
			<cfinclude template="#APP_webroot#/includes/dbview/users_header.cfm">
			<cfset extraURL = "&source=" & url.source>
		</cfcase>

	</cfswitch>

	<cfoutput>
		<title>#APP_title# | #pageTitle#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
	</cfoutput>
	
</head>

<cfoutput>
<body bgcolor="#APP_page_bgcolor#">
</cfoutput>

	<div align="center">

	<cfoutput> 
	<table width="#mainWidth#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
	</cfoutput>
		<tr>
			<td valign="top"> 
				
				<div align="center"><!--- <cfoutput>#cgi.REMOTE_ADDR# #cgi.REMOTE_IDENT#</cfoutput> ---> 
				
					<table width="#subWidth#" border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td align="left" valign="top">
								<cfoutput>
									<img src="#APP_webroot#/#APP_path_images#/searchresults.jpg" border="0">
								</cfoutput>
								
								<cfif contentType NEQ "res">
									<cfset pageMax = url.pageMax>
									<cfset total = get_content.RecordCount>
									<cfset lastPage = (total MOD pageMax)>
									<cfif lastPage IS 0>
										<cfset steps = Int(total / pageMax) - 1>
									<cfelse>
										<cfset steps = Int(total / pageMax)>
									</cfif>
									<cfset totalSteps = steps+1>
									
									<cfset start = ((url.step-1)*pageMax)+1>
									<cfset end = url.step*pageMax>
									<cfset index = 1>
								<cfelse>
									<cfif Trim(url.date) NEQ "">
										<cfoutput>
										<p>
										<form action="dbview.cfm?type=res&sorter=#url.sorter#&orderby=#url.orderby#&deptID=#url.deptID#&late=#url.late#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#" name="dayview" method="post">
											<input type="hidden" name="dept" value="#form.dept#">
											<cfset nextDT = DateFormat(DateAdd("d",1,url.date),"m/d/yyyy")>
											<cfset prevDT = DateFormat(DateAdd("d",-1,url.date),"m/d/yyyy")>
											<input type="hidden" name="date" value="">
											<input type="submit" name="submit" value="Previous Day" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].date.value='#prevDT#';"> 
											&nbsp;<b>#DateFormat(url.date,"dddd, mmm d, yyyy")#</b>&nbsp;
											<input type="submit" name="submit" value="Next Day" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].date.value='#nextDT#';">
										</form><br>
										</p>
										</cfoutput>
									</cfif>
								</cfif>
							</td>
							<td align="right" valign="top">
								<!--- <cfoutput><input class="#APP_style_inputAdmin#" type="button" value="Add New Item" onClick="javascript:parent.frames[2].location='dbcontent.cfm?type=#contentType#';"></cfoutput> ---> <!--- <br>&nbsp; --->
								<cfif contentType NEQ "rules" AND contentType NEQ "res" AND contentType NEQ "fines">
									<cfoutput><a href="dbcontent.cfm?type=#contentType#&catID=#url.catID#&deptID=#url.deptID##extraURL#">Add New</a></cfoutput>
								</cfif>
							</td>
						</tr>
					</table>
	
					<cfif contentType NEQ "res">

						<cfoutput>
							<p>Listing <cfif get_content.RecordCount GT 0>#start#<cfelse>0</cfif> - 
							<cfif get_content.RecordCount LT end>#get_content.RecordCount#<cfelse>#end#</cfif> of #total# 
							result<cfif get_content.RecordCount NEQ 1>s<cfelse></cfif></p>
							
						<select name="go_search" 
								class="#APP_style_inputAdmin#"
								onChange="if(this.options[this.selectedIndex].value != '') document.location = this.options[this.selectedIndex].value">
						</cfoutput>
	
							<cfswitch expression="#contentType#">
							
								<cfcase value="equipment">				
									<cfinclude template="#APP_webroot#/includes/dbview/equip_dropdown.cfm">
								</cfcase>
							
								<cfcase value="hours">				
									<cfinclude template="#APP_webroot#/includes/dbview/hours_dropdown.cfm">
								</cfcase>
							
								<cfcase value="cats">				
									<cfinclude template="#APP_webroot#/includes/dbview/cat_dropdown.cfm">
								</cfcase>
							
								<cfcase value="roles">				
									<cfinclude template="#APP_webroot#/includes/dbview/roles_dropdown.cfm">
								</cfcase>
							
								<cfcase value="dept">				
									<cfinclude template="#APP_webroot#/includes/dbview/dept_dropdown.cfm">
								</cfcase>
							
								<cfcase value="acc">				
									<cfinclude template="#APP_webroot#/includes/dbview/acc_dropdown.cfm">
								</cfcase>
							
								<cfcase value="res">				
									<cfinclude template="#APP_webroot#/includes/dbview/res_dropdown.cfm">
								</cfcase>
							
								<cfcase value="fines">				
									<cfinclude template="#APP_webroot#/includes/dbview/fine_dropdown.cfm">
								</cfcase>
							
								<cfcase value="users">				
									<cfinclude template="#APP_webroot#/includes/dbview/users_dropdown.cfm">
								</cfcase>
							
							</cfswitch>
						</select>
						
						<cfoutput>
						<select name="go_search" 
								class="#APP_style_inputAdmin#"
								onChange="if(this.options[this.selectedIndex].value != '') document.location = this.options[this.selectedIndex].value">
	
							<option value="JavaScript:void(0);">&nbsp;Items Per Page&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=5">&nbsp;5 Items&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=10">&nbsp;10 Items&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=15">&nbsp;15 Items&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=20">&nbsp;20 Items&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=25">&nbsp;25 Items&nbsp;&nbsp;</option>
							<option value="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=50">&nbsp;50 Items&nbsp;&nbsp;</option>
						</select>&nbsp;
						<cfif url.type EQ "equipment" AND url.deptID GT 0>
							<cfif url.createExcelFile>
								<a href="#APP_webroot#/csv/#url.deptID#.csv">Download Excel File</a>
							<cfelse>
								<a href="dbview.cfm?type=#contentType#&step=#url.step#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=#url.pageMax#&createExcelFile=yes">Create Excel File</a>
							</cfif>
						</cfif>
						</cfoutput>
						<br><br>

					</cfif>
					
					<cfoutput>
					<table width="#subWidth#" border="1" cellpadding="2" cellspacing="0" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
					</cfoutput>
					
						<cfmodule 
							template="#APP_webroot#/#APP_path_customtags#/output_row.cfm"
							header="yes"
							ID="0"
							type="#contentType#"
							parent="#viewParent#"
							content="#headerContent#"
							sorters="#columnSorters#"
							align="#alignment#"
							widths="#widths#"
							rowcolor="#APP_table_head_bgcolor#">
						
						<cfset rowcount = 0>
						<cfoutput query="get_content">

							<cfif contentType EQ "res">
								<cfset displayRecord = "yes">
							<cfelse>
								<cfset displayRecord = (index GTE start) and (index LTE end)>
							</cfif>

							<cfif contentType EQ "equipment" AND url.createExcelFile>
								<cfinclude template="#APP_webroot#/includes/dbview/equip_row_excel.cfm">						
							</cfif>

							<cfif displayRecord>
								<cfset resStatus = "">
								<cfset resPSID = "">						
								<cfset resDept = "">						
								<cfset isResLate = "no">
								<cfswitch expression="#contentType#">
							
									<cfcase value="equipment">				
										<cfinclude template="#APP_webroot#/includes/dbview/equip_row.cfm">
									</cfcase>
							
									<cfcase value="hours">				
										<cfinclude template="#APP_webroot#/includes/dbview/hours_row.cfm">						
									</cfcase>
							
									<cfcase value="cats">				
										<cfinclude template="#APP_webroot#/includes/dbview/cat_row.cfm">						
									</cfcase>
							
									<cfcase value="roles">				
										<cfinclude template="#APP_webroot#/includes/dbview/roles_row.cfm">						
									</cfcase>
							
									<cfcase value="dept">				
										<cfinclude template="#APP_webroot#/includes/dbview/dept_row.cfm">						
									</cfcase>
							
									<cfcase value="acc">				
										<cfinclude template="#APP_webroot#/includes/dbview/acc_row.cfm">						
									</cfcase>
							
									<cfcase value="fines">				
										<cfinclude template="#APP_webroot#/includes/dbview/fine_row.cfm">						
									</cfcase>
							
									<cfcase value="res">				
										<cfinclude template="#APP_webroot#/includes/dbview/res_row.cfm">
										<cfset resStatus = STATUS>						
										<cfset resPSID = PSID>						
										<cfset resDept = DEPT_ID>						
									</cfcase>
							
									<cfcase value="users">				
										<cfinclude template="#APP_webroot#/includes/dbview/users_row.cfm">						
									</cfcase>
							
								</cfswitch>
	
								<cfif rowcount MOD 2 EQ 0>
									<cfset bgcolor=APP_rowColorEven>
								<cfelse>
									<cfset bgcolor=APP_rowColorOdd>
								</cfif>

								<cfmodule 
									template="#APP_webroot#/#APP_path_customtags#/output_row.cfm"
									header="no"
									type="#contentType#"
									parent="#viewParent#"
									ID="#rowID#"
									status="#resStatus#"
									psid="#resPSID#"
									dept="#resDept#"
									isLate="#isResLate#"
									content="#tableContent#"
									align="#alignment#"
									widths="#widths#"
									rowcolor="#bgcolor#">		
	
								<cfset rowcount = rowcount + 1>
							</cfif>
							<cfif contentType NEQ "res">
								<cfset index=index+1>
							</cfif>
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
						
					</table>	
					
					<cfif contentType NEQ "res">
						<p>
						<cfoutput>
							<cfset prev = url.step - 1>
							<cfset next = url.step + 1>
							<cfif url.step GT 1>
								<a href="dbview.cfm?step=#prev#&type=#type#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=#url.pageMax#">Prev</a>
							<cfelse>
								<!--- <a href="JavaScript:void(0);">Prev</a> --->
								<font class="table">Prev</font>
							</cfif>&nbsp;
							<cfloop index="x" from="1" to="#totalSteps#">
								<cfif x IS url.step>
									<font class="errorRed">#x#</font>
									<!--- <a href="view_all_po.cfm?sort=#url.sort#&order=#url.order#&step=#x#&sorter=#sorter#"><font color="Red">#x#</font></a> --->
								<cfelse>
									<a href="dbview.cfm?step=#x#&type=#type#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=#url.pageMax#">#x#</a>
								</cfif>
							</cfloop>&nbsp;
							<cfif url.step LT totalSteps>
								<a href="dbview.cfm?step=#next#&type=#type#&sorter=#url.sorter#&orderby=#url.orderby#&catID=#url.catID#&deptID=#url.deptID#&psid=#url.psid#&equipID=#url.equipID#&upcoming=#url.upcoming#&pageMax=#url.pageMax#">Next</a>
							<cfelse>
								<font class="table">Next</font>
								<!--- <a href="JavaScript:void(0);">Next</a> --->
							</cfif>
	
						</cfoutput>
						</p>
					</cfif>
					
					<!--- <cfoutput>#url.upcoming# - #url.date# - #url.deptID#</cfoutput> --->

				</div>

			</td>
		</tr>	
	</table>
	

	</div>

</body>
</html>
