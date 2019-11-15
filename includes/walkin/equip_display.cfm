

<cfoutput>
	<cfif form.specialResType NEQ "normal" and form.specialResType NEQ "longterm" and form.status EQ "ready">
		<b>Pickup: #DateFormat(GetToken(form.date,ed,","),"ddd, m/d/yyyy")# at #TimeFormat(GetToken(form.time,ed,","),"h:mm tt")#</b><br><br>
	</cfif>
	<table width="500" cellpadding="2" cellspacing="0" border="1" style="border-collapse: collapse">
		<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
			<cfif form.status EQ "ready">
				<td width="100">Equip ID</td>
				<td width="300">Equip Name</td>
				<td width="100">&nbsp;</td>
			<cfelseif form.status EQ "confirm">
				<td width="100">Equip ID</td>
				<td width="300">Equip Name</td>
				<td width="100">&nbsp;</td>
			</cfif>
		</tr> 
		<cfif validEquips>
			<cfset rowcount = 0>
			<cfloop index="i" from="1" to="#ArrayLen(equipArray[ed])#">
				<cfif equipArray[ed][i] NEQ deletedConstant AND (form.status EQ "ready" OR (form.status EQ "confirm" AND GetToken(GetToken(equipArray[ed][i],1,"|"),4,"_") EQ GetToken(resLengths[ed][d],1,"|")))>
					<cfif rowcount MOD 2 EQ 0>
						<cfset bgcolor=APP_rowColorEven>
					<cfelse>
						<cfset bgcolor=APP_rowColorOdd>
					</cfif>
					
					<cfset currEID = GetToken(GetToken(equipArray[ed][i],1,"|"),1,"_")>
					<cfset currDue = GetToken(GetToken(equipArray[ed][i],1,"|"),5,"_")>
					
					<tr class="table" bgcolor="#bgcolor#">
						<cfif form.status EQ "ready">
							<td width="100">
								<!--- <cfif GetToken(GetToken(equipArray[i],1,"|"),6,"_") NEQ "" and GetToken(GetToken(equipArray[i],1,"|"),6,"_") NEQ 0> --->
								<cfif GetToken(GetToken(equipArray[ed][i],1,"|"),6,"_")>
									<cfset truncateRes = GetToken(GetToken(equipArray[ed][i],1,"|"),6,"_")>
									<cfquery name="get_conflict_info" datasource="#APP_dsn#">
										select 	OUT_DT
										from	RESERVATIONS
										where	RES_ID = #truncateRes#
									</cfquery>
									<cfset resConflictMessage = "Due to a conflict, this piece of equipment will be due on " & DateFormat(get_conflict_info.OUT_DT,"ddd, m/d/yyyy") & " at " & TimeFormat(get_conflict_info.OUT_DT,"h:mm tt")>
									&nbsp;<a href="JavaScript:void(0);" title="#truncateRes#" onClick="JavaSript:alert('#resConflictMessage#');"><b class="errorRed">X</b></a>&nbsp;
									<script LANGUAGE="JavaScript">
									<!--
										alert('#resConflictMessage#');
									-->
									</script>
								</cfif>
								#GetToken(GetToken(equipArray[ed][i],1,"|"),2,"_")#<!--- <br>+#fine#+ --->
							</td>
							<td width="300">#GetToken(GetToken(equipArray[ed][i],1,"|"),3,"_")#</td>
							<td width="100" align="center">
								<!--- <a 	href="JavaScript:document.forms['walkinBuild'].submit();" 
									onClick="JavaScript:document.forms['walkinBuild'].removeID.value='#i#';">
									Remove</a> --->
								<cfif thisPage EQ "walkin">
									<input 	type="submit" 
											name="submitR" 
											value="Remove" 
											class="#APP_style_inputAdmin#" 
											onClick="JavaScript:document.forms['walkinBuild'].removeID.value='#i#';">
								<cfelseif thisPage EQ "checkin">
									<cfif GetToken(GetToken(equipArray[ed][i],1,"|"),7,"_") EQ "out">
										<input 	type="submit" 
												name="submitC" 
												value="Checkin" 
												class="#APP_style_inputAdmin#" 
												onClick="JavaScript:document.forms['checkinBuild'].removeID.value='#i#';">								
									<cfelse>
										<b>Returned</b>
									</cfif>
								<cfelse>
									&nbsp;
								</cfif>
							</td>
						<cfelseif form.status EQ "confirm">
							<td width="100">#GetToken(GetToken(equipArray[ed][i],1,"|"),2,"_")#</td>
							<td colspan="2" width="400">#GetToken(GetToken(equipArray[ed][i],1,"|"),3,"_")#</td>
						</cfif>
						
					</tr>

					<cfset rowcount = rowcount + 1>

					<cfif GetToken(equipArray[ed][i],2,"|")	NEQ "empty">
					
						<cfset accArray = ListToArray(GetToken(equipArray[ed][i],2,"|"),"~")>
					
						<cfloop index="x" from="1" to="#ArrayLen(accArray)#">
							<cfif accArray[x] NEQ deletedConstant>
								<cfif rowcount MOD 2 EQ 0>
									<cfset bgcolor=APP_rowColorEven>
								<cfelse>
									<cfset bgcolor=APP_rowColorOdd>
								</cfif>	
								<tr class="table" bgcolor="#bgcolor#">
									<cfif form.status EQ "ready">
										<td width="100">&nbsp;</td>
										<td width="300"><i>ACC - #GetToken(accArray[x],2,"_")#</i></td>
										<td width="100" align="center">
											<cfset accID = GetToken(accArray[x],1,"_")>
											<!--- <a 	href="JavaScript:document.forms['walkinBuild'].submit();" 
												onClick="JavaScript:document.forms['walkinBuild'].removeID.value='#i#|#accID#';">
												Remove</a> --->
											<cfif thisPage EQ "walkin">
												<input 	type="submit" 
														name="submit" 
														value="Remove" 
														class="#APP_style_inputAdmin#" 
														onClick="JavaScript:document.forms['walkinBuild'].removeID.value='#i#|#accID#';">
											</cfif>
										</td>
									<cfelseif form.status EQ "confirm">
										<td width="100">&nbsp;</td>
										<td colspan="2" width="400"><i>ACC - #GetToken(accArray[x],2,"_")#</i></td>
									</cfif>
								</tr>
								<cfset rowcount = rowcount + 1>
							</cfif>
						</cfloop>
					
					</cfif>
				</cfif>
			</cfloop>
		<cfelse> 
			<tr class="table">
				<td width="500" align="center" colspan="3">&nbsp;<br> * * * No Items in Cart * * *<br>&nbsp;</td>
			</tr>					
		</cfif>
	</table><br><br>
</cfoutput>
