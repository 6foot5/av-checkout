

<cfoutput query="get_content">

	<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
		<td colspan="2">
			Item Details
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
			Stock ID
		</td>
		<td valign="top" width="67%">
			#BARCODE#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Item Name
		</td>
		<td valign="top" width="67%">
			#NAME#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Accessories
		</td>
		<td valign="top" width="67%">
			<cfif accExists>
				<cfquery name="get_acc2" datasource="#APP_dsn#">
					select	ACC_NAME
					from	ACCESSORIES
					where	PKG_ID = '#ACC_PKG#'
				</cfquery>
				<u>#pName#:</u><br>
				<cfloop query="get_acc2">
					#ACC_NAME#<br>				
				</cfloop>
			<cfelse>
				None
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Categories
		</td>
		<td valign="top" width="67%">
			<cfif get_cats.recordcount>
				<cfloop query="get_cats">
					#CAT_NAME#<br>				
				</cfloop>
			<cfelse>
				None
			</cfif>
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Serial Number
		</td>
		<td valign="top" width="67%">
			#SERIAL#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Item Availabile?
		</td>
		<td valign="top" width="67%">
			#AVAILABILITY#
		</td>
	</tr>

	<tr class="table">
		<td valign="top" width="33%">
			Max Res Length
		</td>
		<td valign="top" width="67%">
			<cfif RES_LENGTH EQ 0>
				<cfset lengthString = "Same Day at Close">
			<cfelseif RES_LENGTH GT 0 AND RES_LENGTH LTE 48>
				<cfset lengthString = RES_LENGTH & " Hours">
			<cfelseif RES_LENGTH GT 48 and RES_LENGTH LT 168>
				<cfset lengthString = RES_LENGTH/24 & " Day(s)">
			<cfelse>
				<cfset lengthString = RES_LENGTH/168 & " Week(s)">
			</cfif>
			#lengthString#
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
							<a href="JavaScript:void(0);">View Item History</a>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="View Item History"><br>&nbsp; --->
							<!--- Search From date:<br> 
							<input class="#APP_style_inputAdmin#" type="text" size="15" value="" name="startDate">
							<input class="#APP_style_inputAdmin#" type="submit" value="View Item History" name="submit"> --->
						</td>
						<td align="right" valign="top">
							&nbsp;<br>
							<a href="dbcontent.cfm?type=equipment&editID=#url.itemID#">Edit Item</a>
							<!--- <input class="#APP_style_inputAdmin#" type="button" value="Edit Item" onClick="JavaScript:location.replace('dbcontent.cfm?type=equipment&editID=#url.itemID#');"><br>&nbsp; --->
						</td>
					</tr>			
				</table>
			</td>
		</form>
	</tr>

</cfoutput>
