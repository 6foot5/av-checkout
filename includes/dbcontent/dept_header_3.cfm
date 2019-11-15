
	<cfparam name="form.dName" default="no">
	<cfparam name="form.dNotes" default="no">
	<cfparam name="form.rScanner" default="no">
	<cfparam name="form.rOnline" default="no">
	<cfparam name="form.rResLength" default=24>
	<cfparam name="form.rReCheck" default="yes">
	<cfparam name="form.rAssessFines" default="no">
	<cfparam name="form.rCheckoutCatLimit" default=0>

	<cfif dbEditID eq 0>

		<cfset rAdvanceTime = 168>
		<cfset rResExpire = 60>
		<cfset rResCatWeekLimitA = 1>
		<cfset rResCatWeekLimitB = 168>
		<cfset rResCatWeekLimitException = 24>
		<cfset rFineStart = 60>
		<cfset rFineSchedule = "">
		<cfset rAllowCheckFine = "no">
		
		<cfset pageTitle = "Define System Preferences - Step 2 of 2">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	DEPARTMENTS
			where	DEPT_ID=#dbEditID#
		</cfquery>
	
		<cfset rAdvanceTime = get_content.RES_ADVANCE_TIME>
		<cfset rResExpire = get_content.RES_EXPIRE_TIME>
		<cfset rResCatWeekLimitA = get_content.RES_CATWEEK_LIMIT_A>
		<cfset rResCatWeekLimitB = get_content.RES_CATWEEK_LIMIT_B>
		<cfset rResCatWeekLimitException = get_content.RES_CATWEEK_LIMIT_EXCEPTION>
		<cfset rFineStart = get_content.FINE_START>
		<cfset rFineSchedule = Trim(get_content.FINE_SCHEDULE)>
		<cfset rAllowCheckFine = Trim(get_content.CHECKOUT_ALLOWED_WITH_FINE)>

		<cfset pageTitle = "Modify System Preferences - Step 2 of 2">

	</cfif>

	<cfset advanceTime = ArrayNew(2)>
	<cfset advanceTime[1][1] = 24>
	<cfset advanceTime[1][2] = "24 Hours">
	<cfset advanceTime[2][1] = 48>
	<cfset advanceTime[2][2] = "48 Hours">
	<cfset advanceTime[3][1] = 72>
	<cfset advanceTime[3][2] = "3 Days">
	<cfset advanceTime[4][1] = 96>
	<cfset advanceTime[4][2] = "4 Days">
	<cfset advanceTime[5][1] = 120>
	<cfset advanceTime[5][2] = "5 Days">
	<cfset advanceTime[6][1] = 144>
	<cfset advanceTime[6][2] = "6 Days">
	<cfset advanceTime[7][1] = 168>
	<cfset advanceTime[7][2] = "1 Week (default)">
	<cfset advanceTime[8][1] = 336>
	<cfset advanceTime[8][2] = "2 Weeks">
	<cfset advanceTime[9][1] = 504>
	<cfset advanceTime[9][2] = "3 Weeks">
	<cfset advanceTime[10][1] = 672>
	<cfset advanceTime[10][2] = "4 Weeks">
	<!--- <cfset advanceTime[11][1] = 0>
	<cfset advanceTime[11][2] = "Indefinite (not recommended)"> --->

	<cfset resExpire = ArrayNew(2)>
	<cfset resExpire[1][1] = 15>
	<cfset resExpire[1][2] = "15 Minutes">
	<cfset resExpire[2][1] = 30>
	<cfset resExpire[2][2] = "30 Minutes">
	<cfset resExpire[3][1] = 45>
	<cfset resExpire[3][2] = "45 Minutes">
	<cfset resExpire[4][1] = 60>
	<cfset resExpire[4][2] = "1 Hour (default)">
	<cfset resExpire[5][1] = 120>
	<cfset resExpire[5][2] = "2 Hours">
	<cfset resExpire[6][1] = 180>
	<cfset resExpire[6][2] = "3 Hours">
	<cfset resExpire[7][1] = 240>
	<cfset resExpire[7][2] = "4 Hours">

	<!--- <cfset resExpire[1][1] = 0>
	<cfset resExpire[1][2] = "No Expiration (not recommended)">
	<cfset resExpire[2][1] = 15>
	<cfset resExpire[2][2] = "15 Minutes">
	<cfset resExpire[3][1] = 30>
	<cfset resExpire[3][2] = "30 Minutes">
	<cfset resExpire[4][1] = 45>
	<cfset resExpire[4][2] = "45 Minutes">
	<cfset resExpire[5][1] = 60>
	<cfset resExpire[5][2] = "1 Hour (default)">
	<cfset resExpire[6][1] = 120>
	<cfset resExpire[6][2] = "2 Hours">
	<cfset resExpire[7][1] = 180>
	<cfset resExpire[7][2] = "3 Hours">
	<cfset resExpire[8][1] = 240>
	<cfset resExpire[8][2] = "4 Hours"> --->

	<cfset resCatWeekLimitA = ArrayNew(2)>
	<cfset resCatWeekLimitA[1][1] = 0>
	<cfset resCatWeekLimitA[1][2] = "No Limit">
	<cfset resCatWeekLimitA[2][1] = 1>
	<cfset resCatWeekLimitA[2][2] = "1 Reservation">	
	<cfloop index="x" from="3" to="11">
		<cfset resCatWeekLimitA[x][1] = x-1>
		<cfset resCatWeekLimitA[x][2] = resCatWeekLimitA[x][1] & " Reservations">	
	</cfloop>

	<cfset resCatWeekLimitB = ArrayNew(2)>
	<cfset resCatWeekLimitB[1][1] = 0>
	<cfset resCatWeekLimitB[1][2] = "No Limit">
	<cfset resCatWeekLimitB[2][1] = 24>
	<cfset resCatWeekLimitB[2][2] = "24 Hours">
	<cfset resCatWeekLimitB[3][1] = 48>
	<cfset resCatWeekLimitB[3][2] = "2 Days">
	<cfset resCatWeekLimitB[4][1] = 72>
	<cfset resCatWeekLimitB[4][2] = "3 Days">
	<cfset resCatWeekLimitB[5][1] = 96>
	<cfset resCatWeekLimitB[5][2] = "4 Days">
	<cfset resCatWeekLimitB[6][1] = 120>
	<cfset resCatWeekLimitB[6][2] = "5 Days">
	<cfset resCatWeekLimitB[7][1] = 144>
	<cfset resCatWeekLimitB[7][2] = "6 Days">
	<cfset resCatWeekLimitB[8][1] = 168>
	<cfset resCatWeekLimitB[8][2] = "1 Week">
	<cfset resCatWeekLimitB[9][1] = 336>
	<cfset resCatWeekLimitB[9][2] = "2 Weeks">
	<cfset resCatWeekLimitB[10][1] = 504>
	<cfset resCatWeekLimitB[10][2] = "3 Weeks">
	<cfset resCatWeekLimitB[11][1] = 672>
	<cfset resCatWeekLimitB[11][2] = "4 Weeks">

	<cfset resCatWeekLimitException = ArrayNew(2)>
	<cfset resCatWeekLimitException[1][1] = 0>
	<cfset resCatWeekLimitException[1][2] = "No Limit">
	<cfset resCatWeekLimitException[2][1] = 1>
	<cfset resCatWeekLimitException[2][2] = "1 Hour">
	<cfset resCatWeekLimitException[3][1] = 2>
	<cfset resCatWeekLimitException[3][2] = "2 Hours">
	<cfset resCatWeekLimitException[4][1] = 3>
	<cfset resCatWeekLimitException[4][2] = "3 Hours">
	<cfset resCatWeekLimitException[5][1] = 4>
	<cfset resCatWeekLimitException[5][2] = "4 Hours">
	<cfset resCatWeekLimitException[6][1] = 5>
	<cfset resCatWeekLimitException[6][2] = "5 Hours">
	<cfset resCatWeekLimitException[7][1] = 6>
	<cfset resCatWeekLimitException[7][2] = "6 Hours">
	<cfset resCatWeekLimitException[8][1] = 12>
	<cfset resCatWeekLimitException[8][2] = "12 Hours">
	<cfset resCatWeekLimitException[9][1] = 24>
	<cfset resCatWeekLimitException[9][2] = "24 Hours">

	<cfset fineStart = ArrayNew(2)>
	<cfset fineStart[1][1] = 0>
	<cfset fineStart[1][2] = "0 Minutes (immediately)">
	<cfset fineStart[2][1] = 5>
	<cfset fineStart[2][2] = "5 Minutes">
	<cfset fineStart[3][1] = 10>
	<cfset fineStart[3][2] = "10 Minutes">
	<cfset fineStart[4][1] = 15>
	<cfset fineStart[4][2] = "15 Minutes">
	<cfset fineStart[5][1] = 30>
	<cfset fineStart[5][2] = "30 Minutes">
	<cfset fineStart[6][1] = 45>
	<cfset fineStart[6][2] = "45 Minutes">
	<cfset fineStart[7][1] = 60>
	<cfset fineStart[7][2] = "1 Hour">
	<cfset fineStart[8][1] = 120>
	<cfset fineStart[8][2] = "2 Hours">
	<cfset fineStart[9][1] = 180>
	<cfset fineStart[9][2] = "3 Hours">
	<cfset fineStart[10][1] = 240>
	<cfset fineStart[10][2] = "4 Hours">
	<cfset fineStart[11][1] = 5>
	<cfset fineStart[11][2] = "5 Hours">
	<cfset fineStart[12][1] = 6>
	<cfset fineStart[12][2] = "6 Hours">
	<cfset fineStart[13][1] = 12>
	<cfset fineStart[13][2] = "12 Hours">
	<cfset fineStart[14][1] = 24>
	<cfset fineStart[14][2] = "24 Hours">

	<cfoutput>
	
		<cfif form.rOnline>
			<cfset resReq = 1>
		<cfelse>
			<cfset resReq = 0>
		</cfif>
		
		<cfif form.rAssessFines>
			<cfset fineReq = 1>
		<cfelse>
			<cfset fineReq = 0>
		</cfif>
	
	</cfoutput>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if ((theForm.rResCatWeekLimitA.selectedIndex == 0 ||
				theForm.rResCatWeekLimitB.selectedIndex == 0 ||	
				theForm.rResCatWeekLimitException.selectedIndex == 0) &&
				(theForm.rResCatWeekLimitA.selectedIndex != 0 ||
				theForm.rResCatWeekLimitB.selectedIndex != 0 ||
				theForm.rResCatWeekLimitException.selectedIndex != 0) )
			{
				alert('When defining a rule for limiting advance reservations per category, you must either select "No Limit" or define a complete rule.');
				theForm.rResCatWeekLimitA.focus();
				return false;
			}
				
		  	if (!validRequired(theForm.rFineSchedule,"Fine Schedule"))
				return false;
			
			/*
			if (!inValidCharSet(theForm.rFineSchedule, "0123456789., "))
			{
				alert('Please enter a valid Fine Schedule in the format "dollar_amount,dollar_amount" (e.g. 5,10,20).');
				return false;
			}
			*/
		  	return true;
		}

		function checkFieldsA() 
		{
			if (document.forms['form1'].rResCatWeekLimitA.selectedIndex == 0)
			{
				document.forms['form1'].rResCatWeekLimitB.selectedIndex=0;
				document.forms['form1'].rResCatWeekLimitException.selectedIndex=0;
			}
		}
		
		function checkFieldsB() 
		{
			if (document.forms['form1'].rResCatWeekLimitB.selectedIndex == 0)
			{
				document.forms['form1'].rResCatWeekLimitA.selectedIndex=0;
				document.forms['form1'].rResCatWeekLimitException.selectedIndex=0;
			}
		}
		
		function checkFieldsC() 
		{
			if (document.forms['form1'].rResCatWeekLimitException.selectedIndex == 0)
			{
				document.forms['form1'].rResCatWeekLimitB.selectedIndex=0;
				document.forms['form1'].rResCatWeekLimitA.selectedIndex=0;
			}
		}
		
		function setCursor() 
		{	
			
		}

	//-->
	</script>

