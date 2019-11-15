<html>
<head>

	<cfinclude template="#APP_webroot#/includes/shared/cookie_check.cfm">						

	<cfinclude template="#APP_webroot#/includes/dbviewdetails/general_header.cfm">						

	<cfswitch expression="#contentType#">

		<cfcase value="equipment">				
			<cfinclude template="#APP_webroot#/includes/dbviewdetails/equip_header.cfm">
		</cfcase>

		<cfcase value="cats">				
			<cfinclude template="#APP_webroot#/includes/dbviewdetails/cat_header.cfm">
		</cfcase>

		<cfcase value="roles">				
			<cfinclude template="#APP_webroot#/includes/dbviewdetails/role_header.cfm">
		</cfcase>

		<cfcase value="res">				
			<cfinclude template="#APP_webroot#/includes/dbviewdetails/res_header.cfm">
		</cfcase>

		<cfcase value="fines">				
			<cfinclude template="#APP_webroot#/includes/dbviewdetails/fine_header.cfm">
		</cfcase>

		<cfcase value="hours">				
			<!--- <cfinclude template="#APP_webroot#/includes/dbviewdetails/hours_header.cfm"> --->
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
	<table width="#APP_table_width#" height="#APP_table_height#" cellpadding="#APP_table_cellpad#" cellspacing="0" border="#APP_mainTableBorder#" bgcolor="#APP_table_bgcolor#" style="border-collapse: collapse" bordercolor="#APP_table_bordercolor#">
	</cfoutput>
		<tr>
			<td valign="top"> &nbsp;<br> &nbsp;<br>
				
				<div align="center">
				
						<table width="400" cellpadding="5" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="333333" bgcolor="F5F5F5">		

							<cfswitch expression="#contentType#">
						
								<cfcase value="equipment">				
									<cfinclude template="#APP_webroot#/includes/dbviewdetails/equip_view.cfm">						
								</cfcase>
						
								<cfcase value="cats">				
									<cfinclude template="#APP_webroot#/includes/dbviewdetails/cat_view.cfm">						
								</cfcase>
						
								<cfcase value="roles">				
									<cfinclude template="#APP_webroot#/includes/dbviewdetails/role_view.cfm">						
								</cfcase>
						
								<cfcase value="res">				
									<cfinclude template="#APP_webroot#/includes/dbviewdetails/res_view.cfm">						
								</cfcase>
						
								<cfcase value="fines">				
									<cfinclude template="#APP_webroot#/includes/dbviewdetails/fine_view.cfm">						
								</cfcase>
						
								<cfcase value="hours">				
									<!--- <cfinclude template="#APP_webroot#/includes/dbviewdetails/hours_view.cfm"> --->						
								</cfcase>
						
							</cfswitch>

						</table>
	
				</div>				

			</td>
		</tr>	
	</table>
	

	</div>

</body>
</html>
