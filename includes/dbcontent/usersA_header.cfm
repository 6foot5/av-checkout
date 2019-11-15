
	<cfquery name="get_user" datasource="#APP_dsn#">
		select	*
		from	USERS U
		where	RTRIM(LTRIM(U.PSID)) = '#Trim(form.user)#' OR Upper(RTRIM(LTRIM(U.LAST_NAME))) LIKE '#UCase(Trim(form.user))#%'
	</cfquery>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if (!validRequired(theForm.editID,"User"))
				return false;
			
		  return true;
		}

		function setCursor() 
		{	return true; }

	//-->
	</script>

