

	<cfparam name="url.sorter" default="BARCODE">
	<cfparam name="url.orderby" default="ASC">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	*
		from	EQUIPMENT E
		<cfif url.catID NEQ "-1">
				, EQUIP_ORG EO
		</cfif>
		where	STATUS <> 'deleted' 
		<cfif url.catID NEQ "-1">
				and	E.EQUIP_ID = EO.EQUIP_ID
				and EO.CAT_ID = #url.catID#
		</cfif>
				and E.DEPT_ID = #url.deptID#
				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Stock ID|Name|Availability|Res Length">
	<cfset columnSorters = "BARCODE|Upper(NAME)|Upper(AVAILABILITY)|RES_LENGTH">	
	<cfset alignment = "left|left|left|left">	
	<cfset widths = "100|175|100|125">	
	