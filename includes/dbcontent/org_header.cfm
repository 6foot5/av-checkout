

	<cfquery name="get_dept" datasource="#APP_dsn#">
		select	DEPT_ID
		from 	CATEGORIES
		where	CAT_ID=#dbEditID#
	</cfquery>
	
	<cfset requestingDept = get_dept.DEPT_ID>

	<!--- <cfif dbEditID eq 0>

		<cfset pageTitle = "Create Equipment / Category Relationships">

	<cfelse> --->
	
		<!--- <cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	CATEGORIES
			where	CAT_ID=#dbEditID#
		</cfquery>
	
		<cfset cDept = get_content.DEPT_ID>
		<cfset cName = get_content.CAT_NAME>
		<cfset cNotes = get_content.NOTES> --->

		<cfset pageTitle = "Modify Equipment / Category Relationships">

	<!--- </cfif> --->

	<script language="JavaScript" type="text/javascript">
	<!--
		function setCursor() {						
		}

		function validateForm(theForm)
		{
			if (!validRequired(theForm.oCat,"Category"))
				return false;
		
			if (!validRequired(theForm.oEquip,"Equipment"))
				return false;
		
			return true;
		}
		
	// -->
	</script>
