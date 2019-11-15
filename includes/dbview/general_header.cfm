
	<cfparam name="form.dept" default="-1">

	<cfif ListLen(cookie.userAdminDepts) EQ 1>
		<cfset deptVal = cookie.userAdminDepts>
	<cfelse>
		<cfset deptVal = form.dept>
	</cfif>

	<cfparam name="url.type" default="">
	<cfparam name="url.pageMax" default=15>
	<cfparam name="form.psid" default="">
	<cfparam name="form.date" default="">
	<cfparam name="form.late" default="no">
	<cfparam name="form.equipID" default="">
	<cfparam name="form.upcoming" default="all">
	<cfparam name="url.upcoming" default="#form.upcoming#">
	<cfparam name="url.psid" default="#form.psid#">
	<cfparam name="url.late" default="#form.late#">
	<cfparam name="url.date" default="#form.date#">
	<cfparam name="url.equipID" default="#form.equipID#">
	<cfparam name="url.deleteID" default=0>
	<cfparam name="url.deptID" default="#deptVal#">
	<cfparam name="url.catID" default="-1">
	<cfparam name="url.source" default="internal">
	<cfparam name="url.step" default=1>
	<cfparam name="url.createExcelFile" default="no">
	
	<cfset contentType = url.type>
	
	<cfset referringURL = ListLast(HTTP_REFERER, "/")>
	<cfif referringURL EQ "">
		<cfset referringURL = "dbview.cfm?type=" & contentType>
	</cfif>
	
	<cfset pageTitle = "View Item List">
	
	<!--- <cfmodule 
		template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
		deptID="#form.dept#"> --->



