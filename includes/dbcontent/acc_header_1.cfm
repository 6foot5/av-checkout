

	<cfif dbEditID eq 0>

		<cfset pDept = url.deptID>
		<cfset pName = "">
		<cfset pNotes = "">

		<cfset pageTitle = "Create Accessory Package">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	ACCESSORY_PKG
			where	PKG_ID=#dbEditID#
		</cfquery>
	
		<cfset pDept = get_content.DEPT_ID>
		<cfset pName = get_content.PKG_NAME>
		<cfset pNotes = get_content.NOTES>
		
		<cfset pageTitle = "Modify Accessory Package">

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if (!validRequired(theForm.pName,"Package Name"))
				return false;
					
			return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].pName.focus();
		}

	//-->
	</script>

