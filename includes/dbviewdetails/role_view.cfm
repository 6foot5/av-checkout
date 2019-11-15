

<cfoutput query="get_content">

	<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
		<td colspan="2">
			Role Details
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
			Role Name
		</td>
		<td valign="top" width="67%">
			#ROLE_NAME#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Included Classes
		</td>
		<td valign="top" width="67%">
			<cfif get_classes.recordcount>
				<cfif get_classes.recordcount GT 25>
					<cfloop query="get_classes" startrow="1" endrow="10">
						#PS_CLASS_NAME#<br>				
					</cfloop>.<br>.<br>.<br>
					<cfloop query="get_classes" startrow="#get_classes.recordcount#-10" endrow="#get_classes.recordcount#">
						#PS_CLASS_NAME#<br>				
					</cfloop>
				<cfelse>
					<cfloop query="get_classes">
						#PS_CLASS_NAME#<br>				
					</cfloop>
				</cfif>
			<cfelse>
				None
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
						#NAME# (#BARCODE#)<br>				
					</cfloop>.<br>.<br>.<br>
					<cfset stRow = get_equip.recordcount - 10>
					<cfloop query="get_equip" startrow="#stRow#" endrow="#get_equip.recordcount#">
						#NAME# (#BARCODE#)<br>				
					</cfloop>
				<cfelse>
					<cfloop query="get_equip">
						#NAME# (#BARCODE#)<br>				
					</cfloop>
				</cfif>
			<cfelse>
				None
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Manually Included Users (in addition to those included by virtue of classes taken/taught)
		</td>
		<td valign="top" width="67%">
			<cfif get_users.recordcount>
				<cfif get_users.recordcount GT 25>
					<cfloop query="get_users" startrow="1" endrow="10">
						#FIRST_NAME# #LAST_NAME#<br>				
					</cfloop>.<br>.<br>.<br>
					<cfset startHere = get_users.recordcount-10>
					<cfloop query="get_users" startrow="#startHere#" endrow="#get_users.recordcount#">
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
	</tr>

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
							<a href="dbcontent.cfm?type=rolesE&editID=#url.itemID#">Modify Equipment Items Tied to Role</a><br><br>
							<a href="dbcontent.cfm?type=rolesU&editID=#url.itemID#">Modify Users Tied to Role</a><br><br>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="Add Items to Category" onClick="JavaScript:location.replace('dbcontent.cfm?type=org&editID=#url.itemID#');"><br>&nbsp; --->
							<!--- Search From date:<br> 
							<input class="#APP_style_inputAdmin#" type="text" size="15" value="" name="startDate">
							<input class="#APP_style_inputAdmin#" type="submit" value="View Item History" name="submit"> --->
						</td>
						<td align="right" valign="top">
							&nbsp;<br>
							<a href="dbcontent.cfm?type=roles&editID=#url.itemID#">Edit This Role</a><br><br>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="Edit Item" onClick="JavaScript:location.replace('dbcontent.cfm?type=equipment&editID=#url.itemID#');"><br>&nbsp; --->
						</td>
					</tr>			
				</table>
			</td>
		</form>
	</tr>

</cfoutput>
