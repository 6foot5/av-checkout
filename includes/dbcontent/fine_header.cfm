

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	U.FIRST_NAME, U.LAST_NAME, F.AMOUNT, F.STATUS
		from	RESERVATIONS R, USERS U, FINES F
		where	F.FINE_ID = #url.editID# and
				F.RES_ID = R.RES_ID and
				R.USER_ID = U.USER_ID
	</cfquery>

	<cfset fUser = get_content.FIRST_NAME & " " & get_content.LAST_NAME>
	<cfset fAmount = get_content.AMOUNT>
	<cfset fStatus = get_content.STATUS>

	<cfset pageTitle = "Modify Fine Entry">

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

		  if (!validRequired(theForm.fAmount,"Fine Amount"))
			return false;
					
		  return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].fAmount.focus();
		}

	//-->
	</script>

