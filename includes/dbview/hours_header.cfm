

	<cfparam name="url.sorter" default="DATE_ON">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	*
		from	HOURS_DEF
		where	DEPT_ID=#url.deptID# 
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Label|Type|Date On|Date Off">
	<cfset columnSorters = "Upper(HOURS_TAG)|Upper(TYPE)|DATE_ON|DATE_OFF">	
	<cfset alignment = "left|left|left|left">	
	<cfset widths = "200|100|100|100">	
	