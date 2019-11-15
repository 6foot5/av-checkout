

	<cfparam name="url.sorter" default="Upper(LAST_NAME)">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	*
		from	USERS
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "PSID|Name|Phone|Email">
	<cfset columnSorters = "Upper(PSID)|Upper(LAST_NAME)|none|Upper(EMAIL)">	
	<cfset alignment = "left|left|left|left">	
	<cfset widths = "100|175|100|125">	
	