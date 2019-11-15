
<cfoutput>

	<p>Accessory Name:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="aName" value="#aName#"></p>								
	
	<p>Notes:<br>
	<textarea class="#APP_style_inputAdmin#" name="aNotes" rows="5" cols="50">#aNotes#</textarea></p>
	<input type="hidden" name="aID" value="#aID#">
	
	<cfif form.editNow>
		<cfset editID = form.editAID>
	<cfelse>
		<cfset editID = 0>
	</cfif>
	
	<input class="#APP_style_inputAdmin#" type="submit" name="aSubmit" value="Add/Edit Accessory" onClick="JavaScript:document.forms['form1'].status.value='ready';document.forms['form1'].addA.value='yes';document.forms['form1'].aComplete.value='no';document.forms['form1'].editAID.value=#editID#;">
	
	<p>Accessories Currently in Package:<br><br>
	<table width="500" cellpadding="2" cellspacing="0" border="1" style="border-collapse: collapse">
		<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
			<td width="175">Name</td>
			<td width="225">Notes</td>
			<td width="100">&nbsp;</td>
		</tr>
		<cfif validAccs>
			<cfset rowcount = 0>
			<cfloop index="i" from="1" to="#accListLen#">
				<cfif accArray[i] NEQ deletedConstant>
					<cfif rowcount MOD 2 EQ 0>
						<cfset bgcolor=APP_rowColorEven>
					<cfelse>
						<cfset bgcolor=APP_rowColorOdd>
					</cfif>	
					<tr class="table" bgcolor="#bgcolor#">
						<td width="175">#GetToken(accArray[i],2,"|")#</td>
						<td width="225">#GetToken(accArray[i],3,"|")#</td>
						<td width="100" align="center">
							<a 	href="JavaScript:document.forms['form1'].submit();" 
								onClick="JavaScript:document.forms['form1'].removeAID.value='#i#';document.forms['form1'].status.value='ready';document.forms['form1'].aComplete.value='no';">
								Del</a>&nbsp;|&nbsp;
							<a 	href="JavaScript:document.forms['form1'].submit();" 
								onClick="JavaScript:document.forms['form1'].editAID.value='#i#';document.forms['form1'].status.value='ready';document.forms['form1'].aComplete.value='no';document.forms['form1'].editNow.value='yes';">
								Edit</a>						
						</td>
					</tr>					
					<cfset rowcount = rowcount + 1>
				</cfif>
			</cfloop>
		<cfelse>
			<tr class="table">
				<td width="500" align="center" colspan="3">&nbsp;<br> * * * No Accessories * * *<br>&nbsp;</td>
			</tr>					
		</cfif>
	</table>
	</p>
	
	<input type="hidden" name="addA" value="no">
	<input type="hidden" name="editNow" value="no">
	<!--- <input type="hidden" name="editA" value="no"> --->
	<input type="hidden" name="editAID" value=0>
	<input type="hidden" name="removeAID" value=0>
	<input type="hidden" name="aComplete" value="yes">
	<input type="hidden" name="from" value="two">
	<input type="hidden" name="pDept" value="#form.pDept#">
	<input type="hidden" name="pName" value="#form.pName#">
	<input type="hidden" name="pNotes" value="#form.pNotes#">
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="acc_list" value="#ArrayToList(accArray)#">
	<input type="hidden" name="deletedConstant" value="#deletedConstant#">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
