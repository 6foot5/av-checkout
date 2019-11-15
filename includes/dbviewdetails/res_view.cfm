

<cfoutput query="get_content">

	<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
		<td colspan="2">
			Reservation Details
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Department Owner
		</td>
		<td valign="top" width="67%">
			#DEPT_NAME#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			User Info
		</td>
		<td valign="top" width="67%">
			#FIRST_NAME# #LAST_NAME#<br>
			<a href="mailto:#EMAIL#">#EMAIL#</a><br>
			#PHONE1#.#PHONE2#.#PHONE3#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Reservation Date
		</td>
		<td valign="top" width="67%">
			<cfif Trim(RES_DT) NEQ "">
				#DateFormat(RES_DT,"dddd, m/d/yyy")# at #TimeFormat(RES_DT,"h:mm tt")#
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Pickup Date
		</td>
		<td valign="top" width="67%">
			<cfif Trim(OUT_DT) NEQ "">
				#DateFormat(OUT_DT,"dddd, m/d/yyy")# at #TimeFormat(OUT_DT,"h:mm tt")#
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Due Date
		</td>
		<td valign="top" width="67%">
			<cfif Trim(DUE_DT) NEQ "">
				#DateFormat(DUE_DT,"dddd, m/d/yyy")# at #TimeFormat(DUE_DT,"h:mm tt")#
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Date Returned
		</td>
		<td valign="top" width="67%">
			<cfif Trim(RETURN_DT) NEQ "">
				#DateFormat(RETURN_DT,"dddd, m/d/yyy")# at #TimeFormat(RETURN_DT,"h:mm tt")#
			</cfif>
		</td>
	</tr>
	
	<tr class="table">
		<td valign="top" width="33%">
			Included Equipment
		</td>
		<td valign="top" width="67%">
			<cfif get_equip.recordcount>
				<cfif get_equip.recordcount GT 25>
					<cfloop query="get_equip" startrow="1" endrow="10">
						<cfinclude template="#APP_webroot#/includes/dbviewdetails/res_equip_view.cfm">												
					</cfloop>.<br>.<br>.<br>
					<cfloop query="get_equip" startrow="#get_equip.recordcount#-10" endrow="#get_equip.recordcount#">
						<cfinclude template="#APP_webroot#/includes/dbviewdetails/res_equip_view.cfm">												
					</cfloop>
				<cfelse>
					<cfloop query="get_equip">
						<cfinclude template="#APP_webroot#/includes/dbviewdetails/res_equip_view.cfm">												
					</cfloop>
				</cfif>
			<cfelse>
				None
			</cfif>
		</td>
	</tr>

	<!--- <tr class="table">
		<td valign="top" width="33%">
			Manually Included Users (in addition to those included by virtue of classes taken/taught)
		</td>
		<td valign="top" width="67%">
			<cfif get_users.recordcount>
				<cfif get_users.recordcount GT 25>
					<cfloop query="get_users" startrow="1" endrow="10">
						#FIRST_NAME# #LAST_NAME#<br>				
					</cfloop>.<br>.<br>.<br>
					<cfloop query="get_users" startrow="#get_users.recordcount#-10" endrow="#get_users.recordcount#">
						#FIRST_NAME# #LAST_NAME#<br>				
					</cfloop>
				<cfelse>
					<cfloop query="get_users">
						#FIRST_NAME# #LAST_NAME#<br>				
					</cfloop>
				</cfif>
			<cfelse>
				None
			</cfif>
		</td>
	</tr> --->

	<tr class="table">
		<td valign="top" width="33%">
			Notes
		</td>
		<td valign="top" width="67%">
			#NOTES#
		</td>
	</tr>

	<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
		<td colspan="2">
			Options
		</td>
	</tr>

	<tr class="table">
		<form action="JavaScript:void(0);" method="post" name="getHist">
			<td colspan="2">
				<table width="100%" border="0">
					<tr class="table">			
						<td align="left" valign="bottom">
							&nbsp;<br>
							<!--- <a href="dbcontent.cfm?type=rolesE&editID=#url.itemID#">Modify Equipment Items Tied to Role</a><br><br>
							<a href="dbcontent.cfm?type=rolesU&editID=#url.itemID#">Modify Users Tied to Role</a><br><br> --->
						</td>
						<td align="right" valign="top">
							&nbsp;<br>
							<!--- <a href="dbcontent.cfm?type=roles&editID=#url.itemID#">Edit This Role</a><br><br> --->
						</td>
					</tr>			
				</table>
			</td>
		</form>
	</tr>

</cfoutput>
