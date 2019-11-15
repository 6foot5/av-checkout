
	<cfparam name="form.primePSID" default="">
	<cfparam name="form.userNotFound" default="no">

	<cfif dbEditID eq 0>
		
		<cfset uPSID = form.primePSID>

		<cfset pageTitle = "User Registration">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	USERS
			where	USER_ID=#dbEditID#
		</cfquery>
	
		<cfset uPSID = Trim(get_content.PSID)>

		<cfset pageTitle = "Modify User Entry">

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if (!validNum(theForm.uPSID,"PSID",true))
				return false;
				
			if (allDigits(theForm.uPSID.value))
			{
				var doneParsing = 0;
				while (!doneParsing)
				{
					if (theForm.uPSID.value.charAt(0) == "0")
						theForm.uPSID.value = theForm.uPSID.value.substring(1,theForm.uPSID.value.length);
					if (theForm.uPSID.value.charAt(0) != "0")
						doneParsing = 1;
				}
				
				if (theForm.uPSID.value.charAt(0) == "1" || theForm.uPSID.value.charAt(0) == "2")
					theForm.uPSID.value = "00" + theForm.uPSID.value;
				else
					theForm.uPSID.value = "0" + theForm.uPSID.value;				
				if (theForm.uPSID.value.length < 6 || theForm.uPSID.value.length > 8)
				{
					alert('Please provide a valid [ORG-NAME] ID.');
					theForm.uPSID.focus();
					return false;		
				}
			}

			return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].uPSID.focus();
		}

	//-->
	</script>

	<cfif dbEditID NEQ 0>
		<cfoutput>
			<form action="dbcontent.cfm?source=#url.source#" method="post" name="proceed">
				<!--- <input type="hidden" name="uPSID" value="#uPSID#"> --->								
				<input type="hidden" name="URL" value="#referringURL#">
				<input type="hidden" name="contentType" value="#contentType#">
				<input type="hidden" name="editID" value="#dbEditID#">
				<input type="hidden" name="step" value="two">
				<input type="hidden" name="status" value="ready">
			</form>
			<script language="JavaScript">
			<!--
				document.forms['proceed'].submit();
			-->
			</script>
		</cfoutput>
	</cfif>
	
	<cfif form.userNotFound>
		<script language="JavaScript">
		<!--
			alert("The user you have selected is not registered.  Please take a moment to register him/her.");
		-->
		</script>	
	</cfif>
