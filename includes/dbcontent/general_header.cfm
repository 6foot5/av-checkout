

	<cfif ListLen(cookie.userAdminDepts) EQ 1>
		<cfset deptVal = cookie.userAdminDepts>
	<cfelse>
		<cfset deptVal = "-1">
	</cfif>

	<cfparam name="url.editID" default=0>
	<cfparam name="url.deptID" default="#deptVal#">
	<cfparam name="url.catID" default=-1>
	<!--- <cfparam name="url.type" default="">  NOW included at very top of dbcontent page
	<cfparam name="url.source" default="internal"> --->

	<cfparam name="form.contentType" default="">
	<cfparam name="form.status" default="ready">
	<cfparam name="form.step" default="one">
	<cfparam name="form.editID" default=0>
	<cfparam name="form.URL" default="">
	<cfparam name="form.error" default="">
	<cfparam name="form.user" default="">

	
	<cfif form.URL EQ "">
		<cfset referringURL = ListLast(HTTP_REFERER, "/")>
		<cfif referringURL EQ "">
			<cfset referringURL = "home.cfm">
		</cfif>
	<cfelse>
		<cfset referringURL = form.URL>
	</cfif>
	
	<cfif url.editID NEQ 0>
		<cfset dbEditID = url.editID>
	<cfelseif form.editID NEQ 0>
		<cfset dbEditID = form.editID>
	<cfelse>
		<cfset dbEditID = 0>
	</cfif>

	<cfif url.type NEQ "">
		<cfset contentType = url.type>
	<cfelseif form.contentType NEQ "">
		<cfset contentType = form.contentType>
	<cfelse>
		<cfset contentType = "">
	</cfif>
	
	<cfif contentType EQ "users">
		<cfset referringURL = "home.cfm">
	</cfif>

	<cfif dbEditID EQ 0>
		<cfset title = "Add">
	<cfelse>
		<cfset title = "Edit">
	</cfif>
	
	<cfset pageTitle = "No Mode Selected">

