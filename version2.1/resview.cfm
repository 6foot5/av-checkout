<html>
<head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/dbview/general_header.cfm">						

	<cfset extraURL = "">

	<cfinclude template="#APP_webroot#/includes/dbview/res_header.cfm">
	<cfset viewParent = "res">

	<cfoutput>
		<title>#APP_title# | #pageTitle#</title>
		<link rel="stylesheet" href="#APP_webroot#/#APP_path_css#/basic.css">
	</cfoutput>
	
</head>

<cfoutput>
<body bgcolor="#APP_page_bgcolor#">
</cfoutput>

	<div align="center">

	<cfoutput> <!--- #cgi.REMOTE_ADDR# --->
	<table width="90%" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
	</cfoutput>
		<tr>
			<td valign="top"> 
				
				<div align="center">
				
					<table width="750" border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td align="center" valign="top">
								<cfoutput>
									<img src="#APP_webroot#/#APP_path_images#/searchresults.jpg" border="0">
									<cfif Trim(url.date) NEQ "">
										<p>
										<form action="resview.cfm?type=res" name="dayview" method="post">
											<input type="hidden" name="dept" value="#form.dept#">
											<cfset nextDT = DateFormat(DateAdd("d",1,url.date),"m/d/yyyy")>
											<cfset prevDT = DateFormat(DateAdd("d",-1,url.date),"m/d/yyyy")>
											<input type="hidden" name="date" value="">
											<input type="submit" name="submit" value="Previous Day" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].date.value='#prevDT#';"> 
											&nbsp;<b>#DateFormat(url.date,"dddd, mmm d, yyyy")#</b>&nbsp;
											<input type="submit" name="submit" value="Next Day" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['dayview'].date.value='#nextDT#';">
										</form>
										</p>
									</cfif>
								</cfoutput>							
							</td>
						</tr>
					</table>
	
					<cfoutput>
						<p>Found <b>#get_content.RecordCount#</b> 
						Result<cfif get_content.RecordCount NEQ 1>s<cfelse></cfif></p>
						
					</cfoutput>
					
					<cfoutput>
					<table width="750" border="1" cellpadding="2" cellspacing="0" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
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

							<cfinclude template="#APP_webroot#/includes/dbview/res_row.cfm">
							<cfset resStatus = STATUS>						

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
								content="#tableContent#"
								align="#alignment#"
								widths="#widths#"
								rowcolor="#bgcolor#">		

							<cfset rowcount = rowcount + 1>
							<!--- <cfset index=index+1> --->
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
					
				</div>

			</td>
		</tr>	
	</table>
	

	</div>

</body>
</html>
