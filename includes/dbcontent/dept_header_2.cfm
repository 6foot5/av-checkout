

	<cfif dbEditID eq 0>

		<cfset rScanner = "yes">
		<cfset rOnline = "no">
		<cfset rResLength = 24>
		<cfset rResLengthException = "">
		<cfset rReCheck = "yes">
		<cfset rAssessFines = "no">
		<cfset rCheckoutCatLimit = 0>
		
		<cfset pageTitle = "Define System Preferences - Step 1 of 2">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	DEPARTMENTS
			where	DEPT_ID=#dbEditID#
		</cfquery>
	
		<cfset rScanner = Trim(get_content.USE_SCANNER)>
		<cfset rOnline = Trim(get_content.RES_ONLINE)>
		<cfset rResLength = get_content.RES_LENGTH_GEN>
		<cfset rResLengthException = get_content.RES_LENGTH_EXCEPTION>
		<cfset rReCheck = Trim(get_content.ALLOW_RECHECK)>
		<cfset rAssessFines = Trim(get_content.ASSESS_FINES)>
		<cfset rCheckoutCatLimit = get_content.CHECKOUT_MAX_PER_CAT>

		<cfset pageTitle = "Modify System Preferences - Step 1 of 2">

	</cfif>

	<cfset resLength = ArrayNew(2)>
	<cfset resLength[1][1] = 0>
	<cfset resLength[1][2] = "Same Day, at Closing">
	<cfset resLength[2][1] = 24>
	<cfset resLength[2][2] = "24 Hours (default)">
	<cfset resLength[3][1] = 48>
	<cfset resLength[3][2] = "48 Hours">
	<cfset resLength[4][1] = 72>
	<cfset resLength[4][2] = "3 Days">
	<cfset resLength[5][1] = 96>
	<cfset resLength[5][2] = "4 Days">
	<cfset resLength[6][1] = 120>
	<cfset resLength[6][2] = "5 Days">
	<cfset resLength[7][1] = 144>
	<cfset resLength[7][2] = "6 Days">
	<cfset resLength[8][1] = 168>
	<cfset resLength[8][2] = "1 Week">
	<cfset resLength[9][1] = 336>
	<cfset resLength[9][2] = "2 Weeks">
	<cfset resLength[10][1] = 504>
	<cfset resLength[10][2] = "3 Weeks">
	<cfset resLength[11][1] = 672>
	<cfset resLength[11][2] = "4 Weeks">

	<cfset checkoutCatLimit = ArrayNew(2)>
	<cfset checkoutCatLimit[1][1] = 0>
	<cfset checkoutCatLimit[1][2] = "No Limit on Items per Category per Checkout">
	<cfset checkoutCatLimit[2][1] = 1>
	<cfset checkoutCatLimit[2][2] = "1 Item per Category per Checkout">	
	<cfloop index="x" from="3" to="11">
		<cfset checkoutCatLimit[x][1] = x-1>
		<cfset checkoutCatLimit[x][2] = checkoutCatLimit[x][1] & " Items per Category per Checkout">	
	</cfloop>

	<cfset resLengthException = ArrayNew(2)>
	<cfset resLengthException[1][1] = "Sunday">
	<cfset resLengthException[1][2] = "Except on Sunday">
	<cfset resLengthException[2][1] = "Monday">
	<cfset resLengthException[2][2] = "Except on Monday">
	<cfset resLengthException[3][1] = "Tuesday">
	<cfset resLengthException[3][2] = "Except on Tuesday">
	<cfset resLengthException[4][1] = "Wednesday">
	<cfset resLengthException[4][2] = "Except on Wednesday">
	<cfset resLengthException[5][1] = "Thursday">
	<cfset resLengthException[5][2] = "Except on Thursday">
	<cfset resLengthException[6][1] = "Friday">
	<cfset resLengthException[6][2] = "Except on Friday">
	<cfset resLengthException[7][1] = "Saturday">
	<cfset resLengthException[7][2] = "Except on Saturday">

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{
		
			if (theForm.rResLengthExceptionDay.value != "" || theForm.rResLengthException.value != "")
			{
				if (!validRequired(theForm.rResLengthExceptionDay,"Reservation Length Exception Day"))
					return false;
	
				if (!validRequired(theForm.rResLengthException,"Reservation Length Exception Length"))
					return false;
			} 

			return true;
		}

		function setCursor() 
		{	
			
		}

	//-->
	</script>

