

	<cfparam name="url.deleteID" default=0>
	<cfparam name="url.type" default="">
	<cfparam name="url.refer" default="">

	<cfset referringURL = ListLast(HTTP_REFERER, "/")>
	<cfif referringURL EQ "">
		<cfset referringURL = "#APP_webroot#/version2.0/">
	</cfif>
	
	<cfif url.refer NEQ "">
		<cfset referringURL = "#APP_webroot#/version2.0/" & url.refer>
	</cfif>
	
	<cfif url.deleteID NEQ 0>
		<cfset dbDeleteID = url.deleteID>
	<cfelse>
		<cfset dbDeleteID = 0>
	</cfif>

	<cfif url.type NEQ "">
		<cfset contentType = url.type>
	<cfelse>
		<cfset contentType = "">
	</cfif>
	

