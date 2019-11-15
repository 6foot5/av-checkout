
	<cfif form.specialResType EQ "normal">
	
		<cfset selectedOutDates = form.date>
	
	<cfelseif form.specialResType EQ "longterm">
		
		<cfset selectedOutDates = form.specialStartDate>		
			
	<cfelse>
		
		<cfset selectedOutDates = "">
		<cfset index = form.specialStartDate>
		<cfloop condition="#index# LTE #form.specialEndDate#">
			<cfif DateFormat(index,"dddd") EQ form.specialResType>
				<cfset selectedOutDates = ListAppend(selectedOutDates,DateFormat(index,"mm/dd/yyyy"),",")>
			</cfif>
			<cfset index = DateAdd("d",1,index)>
		</cfloop>
	
	</cfif>

	<!--- <cfoutput>+#form.specialResType#+#selectedOutDates#</cfoutput> --->
	<cfset selectedOutDates = ListToArray(selectedOutDates)>
	
	<p><b>Walkin Checkouts and<br>Advance Reservations</b><br><br>Select Desired Pickup Times</p>

	<table width="300" border="0" cellspacing="0" cellpadding="2">

		<cfloop from="1" to="#ArrayLen(selectedOutDates)#" index="j">
			
			<p>
			<cfset chosenDate = DateFormat(selectedOutDates[j],"m/d/yyyy")>
			
				<cfmodule 
					template="#APP_webroot#/#APP_path_customtags#/get_hours_list.cfm"
					deptID="#form.dept#"
					date="#chosenDate#">
					
				<cfset numTimes = ListLen(timesList)>
			
			<cfif numTimes>
			
				  <tr>
					<td align="right"><cfoutput><b>#DateFormat(chosenDate,"dddd, mmm d")#</b></cfoutput>:</td>
					<td>
						<select name="DT" class="small">
							
							<cfloop list="#timesList#" index="oneTime">
								<cfoutput>
									<!--- <cfset thisDate = GetToken(advanceDays,x,",")> --->
									<option value="#chosenDate#|#oneTime#">#TimeFormat(oneTime,"h:mm tt")#</option>
								</cfoutput>		
							</cfloop>
							
						</select>
					</td>
				  </tr>
				
			<cfelse>
	
				  <tr>
					<td align="right"><cfoutput><b>#DateFormat(chosenDate,"dddd, mmm d")#</b></cfoutput>:</td>
					<td>
						There are no available times on this date (checkout is closed).
						Please select a different date.
					</td>
				  </tr>				
			
			</cfif>
			</p>	
	
		</cfloop>
	
	</table><br><br>
	
	
	
