

	<cfif dbEditID eq 0>

		<cfset cDept = url.deptID>
		<cfset cName = "">
		<cfset cEnforceLimit = "yes">
		<cfset cNotes = "">

		<cfset pageTitle = "Create Category Entry">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	CATEGORIES
			where	CAT_ID=#dbEditID#
		</cfquery>
	
		<cfset cDept = get_content.DEPT_ID>
		<cfset cName = get_content.CAT_NAME>
		<cfset cEnforceLimit = get_content.ENFORCE_LIMIT>
		<cfset cNotes = get_content.NOTES>

		<cfset pageTitle = "Modify Category Entry">

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

		  if (!validRequired(theForm.cName,"Category Name"))
			return false;
					
		  return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].cName.focus();
		}

	//-->
	</script>

