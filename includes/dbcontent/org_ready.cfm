
<cfoutput>

	<cfquery name="get_equip" datasource="#APP_dsn#">
		select		E.NAME, E.EQUIP_ID, E.BARCODE
		from 		EQUIPMENT E<!--- , EQUIP_ORG O --->
		where		E.DEPT_ID = #requestingDept# and
					E.STATUS <> 'deleted'		
		order by 	NAME
	</cfquery>
	
	<cfquery name="get_cats" datasource="#APP_dsn#">
		select		*
		from 		CATEGORIES
		where		DEPT_ID = #requestingDept#
		order by	CAT_NAME
	</cfquery>

	<cfquery name="check_org" datasource="#APP_dsn#">
		select		*
		from 		EQUIP_ORG O
		where		CAT_ID = #dbEditID#		
	</cfquery>			

	<p>Category:<br>
	<select class="#APP_style_inputAdmin#" name="oCat">
		<option value="">Select Category&nbsp;</option>
		<cfloop query="get_cats">
			<cfif CAT_ID IS dbEditID>
				<cfset isSelected="selected">
			<cfelse>
				<cfset isSelected="">
			</cfif>									
			<option value="#CAT_ID#" #isSelected#>#CAT_NAME#&nbsp;</option>
		</cfloop>
	</select><br>
	</p>									

	<p>Equipment List:<br>
	<select class="#APP_style_inputAdmin#" name="oEquip" multiple size="15">
		<cfloop query="get_equip">
			<cfset currEID = EQUIP_ID>
			<cfset isSelected="">
			<cfloop query="check_org">
				<cfif currEID IS EQUIP_ID>
					<cfset isSelected="selected">
				</cfif>												
			</cfloop>
			<option value="#EQUIP_ID#" #isSelected#>#NAME# (#BARCODE#)&nbsp;</option>
		</cfloop>
	</select><br>
	</p>									

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
