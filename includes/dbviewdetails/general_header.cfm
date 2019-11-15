

	<cfparam name="url.type" default="">
	<cfparam name="url.itemID" default=0>

	<cfif url.type NEQ "">
		<cfset contentType = url.type>
	<cfelse>
		<cfset contentType = "">
	</cfif>
	
	<cfset referringURL = ListLast(HTTP_REFERER, "/")>
	<cfif referringURL EQ "">
		<cfset referringURL = "dbview.cfm?type=" & contentType>
	</cfif>
	
	<cfset pageTitle = "View Item Details">

