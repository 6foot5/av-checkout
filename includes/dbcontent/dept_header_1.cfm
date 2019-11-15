

	<cfif dbEditID eq 0>

		<cfset dName = "">
		<cfset dEmail = "">
		<cfset dIpAddress = "">
		<cfset dNotes = "">

		<cfset pageTitle = "Create Department Entry">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	DEPARTMENTS
			where	DEPT_ID=#dbEditID#
		</cfquery>
	
		<cfset dName = get_content.DEPT_NAME>
		<cfset dEmail = get_content.DEPT_EMAIL>
		<cfset dIpAddress = get_content.IP_ADDRESS>
		<cfset dNotes = get_content.NOTES>

		<cfset pageTitle = "Modify Department Entry">

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

		  if (!validRequired(theForm.dName,"Department Name"))
			return false;
					
		  if (!validRequired(theForm.dEmail,"Department Email"))
			return false;
					
		  return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].dName.focus();
		}

	//-->
	</script>

