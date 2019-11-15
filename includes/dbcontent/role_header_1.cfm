

	<cfif dbEditID eq 0>

		<cfset rDept = url.deptID>
		<cfset rName = "">
		<cfset rNotes = "">

		<cfset pageTitle = "Create Role">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	ROLES
			where	ROLE_ID=#dbEditID#
		</cfquery>
	
		<cfset rDept = get_content.DEPT_ID>
		<cfset rName = get_content.ROLE_NAME>
		<cfset rNotes = get_content.NOTES>
		
		<cfset pageTitle = "Modify Role">

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if (!validRequired(theForm.rName,"Role Name"))
				return false;
					
			return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].rName.focus();
		}

	//-->
	</script>

