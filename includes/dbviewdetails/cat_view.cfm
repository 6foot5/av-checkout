

<cfoutput query="get_content">

	<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
		<td colspan="2">
			Category Details
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
			Category Name
		</td>
		<td valign="top" width="67%">
			#CAT_NAME#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Included Items
		</td>
		<td valign="top" width="67%">
			<cfif get_equip.recordcount>
				<cfloop query="get_equip">
					#NAME# (#BARCODE#)<br>				
				</cfloop>
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
							<a href="dbcontent.cfm?type=org&editID=#url.itemID#">Add Items to Category</a>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="Add Items to Category" onClick="JavaScript:location.replace('dbcontent.cfm?type=org&editID=#url.itemID#');"><br>&nbsp; --->
							<!--- Search From date:<br> 
							<input class="#APP_style_inputAdmin#" type="text" size="15" value="" name="startDate">
							<input class="#APP_style_inputAdmin#" type="submit" value="View Item History" name="submit"> --->
						</td>
						<td align="right" valign="top">
							&nbsp;<br>
							<a href="dbcontent.cfm?type=cats&editID=#url.itemID#">Edit Item</a>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="Edit Item" onClick="JavaScript:location.replace('dbcontent.cfm?type=equipment&editID=#url.itemID#');"><br>&nbsp; --->
						</td>
					</tr>			
				</table>
			</td>
		</form>
	</tr>

</cfoutput>
