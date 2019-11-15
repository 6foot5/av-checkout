

<cfoutput>
	<p><b><u>User Details:</u></b><br><br>
	<b>Name</b>: #userName#<br>						
	<b>Email</b>: <a href="mailto:#userEmail#">#userEmail#</a><br>						
	<b>Phone</b>: #userPhone#<br>
	<b>Roles</b>: 
	<cfloop index="x" from="1" to="#ListLen(roleList)#">
		#GetToken(ListGetAt(roleList,x),2,"|")#<cfif x NEQ ListLen(roleList)>,</cfif>
	</cfloop><br><br>						
	</p>							
</cfoutput>
