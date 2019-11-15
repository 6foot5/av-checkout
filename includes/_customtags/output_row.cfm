
<cfparam name="attributes.hideLinks" default="no">
<cfparam name="attributes.type" default="">
<cfparam name="attributes.parent" default="dbview">
<cfparam name="attributes.isLate" default="no">
<cfparam name="attributes.status" default="open">
<cfparam name="attributes.psid" default="">
<cfparam name="attributes.dept" default="">
<cfparam name="attributes.sorters" default="">

<cfset isHeader = attributes.header>
<cfset colContent = ListToArray(attributes.content,"|")>
<cfset status = attributes.status>
<cfset type = attributes.type>
<cfset parent = attributes.parent>
<cfset itemID = attributes.ID>
<cfset alignment = ListToArray(attributes.align,"|")>
<cfset widths = ListToArray(attributes.widths,"|")>
<cfset bg = attributes.rowcolor>
<cfset sorters = ListToArray(attributes.sorters,"|")>

<cfif isHeader>
	<cfset rowClass = "tableHead">
	<cfif type EQ "res">
		<cfset termDelete = "cancel">
	<cfelse>
		<cfset termDelete = "delete">
	</cfif>
	<script LANGUAGE="JavaScript">
	<!--
		function confirmSubmit()
		{
		
			var agree=confirm("Are you sure you wish to <cfoutput>#termDelete#</cfoutput> the selected item?");
			if (agree)
				return true;
			else
				return false ;
		
		}
	// -->
	</script>	
<cfelse>
	<cfif parent EQ "res" AND Trim(status) EQ "cancelled">
		<cfset rowClass = "tableStrike">
	<cfelseif parent EQ "res" AND Trim(status) EQ "checked" AND attributes.isLate>	
		<cfset rowClass = "errorRed">
	<cfelseif parent EQ "res" AND Trim(status) EQ "closed">	
		<cfset rowClass = "tableFade">
	<cfelse>
		<cfset rowClass = "table">
	</cfif>
</cfif>

<cfoutput>

	<tr class="#rowClass#" bgcolor="#bg#">
		
		<cfloop index="x" from="1" to="#ArrayLen(colContent)#">

			<cfset cellBG = bg>

			<cfif (parent EQ "res" AND Trim(status) EQ "checked" AND NOT isHeader AND x EQ 2) OR (parent EQ "res" AND Trim(status) EQ "open" AND NOT isHeader AND x EQ 1)>
				<cfset cellBG = "FFFFCC">
			</cfif>

			
			<cfif ArrayLen(widths) GT 0 AND ArrayLen(alignment) GT 0>
				<td bgcolor="#cellBG#" valign="top" width="#widths[x]#" align="#alignment[x]#">
			<cfelseif ArrayLen(widths) GT 0 AND ArrayLen(alignment) EQ 0>
				<td bgcolor="#cellBG#" valign="top" width="#widths[x]#">
			<cfelseif ArrayLen(widths) EQ 0 AND ArrayLen(alignment) GT 0>
				<td bgcolor="#cellBG#" valign="top" align="#alignment[x]#">
			<cfelseif ArrayLen(widths) EQ 0 AND ArrayLen(alignment) EQ 0>
				<td bgcolor="#cellBG#" valign="top">
			</cfif>
					<cfset sortFocus = "">
					<cfif ArrayLen(sorters) EQ 0>
							#colContent[x]#&nbsp;
					<cfelse>
						<cfif Trim(sorters[x]) NEQ "none">
							<cfif Trim(caller.url.sorter) EQ Trim(sorters[x])>
								
								<cfif caller.url.orderby EQ "ASC">
									<cfset ob = "DESC">
								<cfelse>
									<cfset ob = "ASC">
								</cfif>
								<cfset sortFocus = " * ">
							<cfelse>
								<cfset ob="ASC">
							</cfif>
							<a 	class="TH" 
								href="dbview.cfm?type=#type#&late=#caller.url.late#&step=#caller.url.step#&sorter=#sorters[x]#&orderby=#ob#&catID=#caller.url.catID#&deptID=#caller.url.deptID#&psid=#caller.url.psid#&equipID=#caller.url.equipID#&upcoming=#caller.url.upcoming#&date=#caller.url.date#&pageMax=#caller.url.pageMax#">
								#colContent[x]#</a>#sortFocus#&nbsp;
						<cfelse>
							#colContent[x]#&nbsp;
						</cfif>
					</cfif>						
				</td>
		</cfloop>
		<cfif NOT attributes.hideLinks>
			<td valign="top" width="100" align="center">
				<cfif isHeader>
					Action
				<cfelse>
					<cfif parent EQ "dbview">
						<a href="dbviewdetails.cfm?type=#type#&itemID=#itemID#">V</a> | 
						<a href="dbcontent.cfm?type=#type#&editID=#itemID#">E</a>  
						<cfif Trim(type) NEQ "dept">
							| <a href="dbdelete.cfm?type=#type#&deleteID=#itemID#" onClick="return confirmSubmit();">D</a> 
						</cfif>
					<cfelseif parent EQ "res">
						<a href="dbviewdetails.cfm?type=res&itemID=#itemID#&source=#caller.url.source#">V</a> 
						<cfif Trim(status) EQ "checked">
							<!--- <a href="checkin.cfm?resID=#itemID#">Checkin</a> ---> 					
							<cfif caller.url.source EQ "internal" AND (ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"globalAdmin") OR ListContains(cookie.userAdminType,"PartTime") OR ListContains(cookie.userAdminType,"WorkStudy"))>
								| <a href="checkin.cfm?resID=#itemID#&deptID=#caller.url.deptID#" target="main" onClick="JavaScript:window.close(); return true;">Checkin</a> 					
							</cfif>
						<cfelseif Trim(status) EQ "open">
							<cfset thisDay = DateFormat(Now(),"m/d/yyyy")>
							<cfset thisTime = TimeFormat(Now(),"H:mm")>
							<!--- | <a href="walkin.cfm?resID=#itemID#&existing=yes&dept=#caller.get_content.DEPT_ID#&psid=#caller.get_content.PSID#&time=#thisTime#&date=#thisDay#&type=walkin&status=confirm" target="main" onClick="JavaScript:window.close();">Checkout</a>  --->					
							<cfif caller.url.source EQ "internal" AND (ListContains(cookie.userAdminType,"Admin") OR ListContains(cookie.userAdminType,"globalAdmin") OR ListContains(cookie.userAdminType,"PartTime") OR ListContains(cookie.userAdminType,"WorkStudy"))>
								| <a href="walkin.cfm?resID=#itemID#&existing=yes&dept=#attributes.dept#&psid=#Trim(attributes.psid)#&time=#thisTime#&date=#thisDay#&type=walkin&status=confirm" target="main" onClick="JavaScript:window.close();">Checkout</a> 					
							</cfif>
							| <a href="dbview.cfm?type=res&step=#caller.url.step#&sorter=#caller.url.sorter#&orderby=#caller.url.orderby#&catID=#caller.url.catID#&deptID=#caller.url.deptID#&psid=#caller.url.psid#&equipID=#caller.url.equipID#&upcoming=#caller.url.upcoming#&date=#caller.url.date#&pageMax=#caller.url.pageMax#&deleteID=#itemID#&source=#caller.url.source#" onClick="return confirmSubmit();">X</a>
							<!--- <a href="checkin.cfm?resID=#itemID#">Checkout</a> ---> 					
						</cfif>
					</cfif>
				</cfif>
			</td>
		</cfif>
	
	</tr>
	
</cfoutput>