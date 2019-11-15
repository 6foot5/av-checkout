

	<cfif dbEditID eq 0>

		<cfset eDept = url.deptID>
		<cfset eAcc = 0>
		<cfset eBarcode = "">
		<cfset eName = "">
		<cfset eSerial = "">
		<cfset eFine = "">
		<cfset eNotes = "">
		<cfset eAvail = "">

		<cfmodule 
			template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
			deptID="#eDept#">

		<cfset eResLength = resLengthGen>
		<cfset eResLengthException = resLengthException>
		<cfset eResLengthExceptionDay = resLengthExceptionDay>

		<cfset pageTitle = "Create Equipment Entry">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	EQUIPMENT
			where	EQUIP_ID=#dbEditID#
		</cfquery>
	
		<cfset eDept = get_content.DEPT_ID>
		<cfset eAcc = get_content.ACC_PKG>
		<cfset eBarcode = get_content.BARCODE>
		<cfset eName = Trim(get_content.NAME)>
		<cfset eSerial = Trim(get_content.SERIAL)>
		<cfset eFine = Trim(get_content.FINE_SCHEDULE)>
		<cfset eNotes = get_content.NOTES>
		<cfset eAvail = Trim(get_content.AVAILABILITY)>
		<cfset eResLength = get_content.RES_LENGTH>
		<cfset eResLengthException = Trim(GetToken(get_content.RES_LENGTH_EXCEPTION,2,","))>
		<cfset eResLengthExceptionDay = Trim(GetToken(get_content.RES_LENGTH_EXCEPTION,1,","))>

		<cfset pageTitle = "Modify Equipment Entry">

	</cfif>

	<cfset resLength = ArrayNew(2)>
	<cfset resLength[1][1] = 0>
	<cfset resLength[1][2] = "Same Day, at Closing">
	<cfset resLength[2][1] = 1>
	<cfset resLength[2][2] = "1 Hour">
	<cfset resLength[3][1] = 2>
	<cfset resLength[3][2] = "2 Hours">
	<cfset resLength[4][1] = 3>
	<cfset resLength[4][2] = "3 Hours">
	<cfset resLength[5][1] = 4>
	<cfset resLength[5][2] = "4 Hours">
	<cfset resLength[6][1] = 5>
	<cfset resLength[6][2] = "5 Hours">
	<cfset resLength[7][1] = 6>
	<cfset resLength[7][2] = "6 Hours">
	<cfset resLength[8][1] = 8>
	<cfset resLength[8][2] = "8 Hours">
	<cfset resLength[9][1] = 24>
	<cfset resLength[9][2] = "24 Hours">
	<cfset resLength[10][1] = 48>
	<cfset resLength[10][2] = "2 Days">
	<cfset resLength[11][1] = 72>
	<cfset resLength[11][2] = "3 Days">
	<cfset resLength[12][1] = 96>
	<cfset resLength[12][2] = "4 Days">
	<cfset resLength[13][1] = 120>
	<cfset resLength[13][2] = "5 Days">
	<cfset resLength[14][1] = 144>
	<cfset resLength[14][2] = "6 Days">
	<cfset resLength[15][1] = 168>
	<cfset resLength[15][2] = "1 Week">
	<cfset resLength[16][1] = 336>
	<cfset resLength[16][2] = "2 Weeks">
	<cfset resLength[17][1] = 504>
	<cfset resLength[17][2] = "3 Weeks">
	<cfset resLength[18][1] = 672>
	<cfset resLength[18][2] = "4 Weeks">

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

		  if (!validRequired(theForm.eName,"Name"))
			return false;
					
		  if (!validRequired(theForm.eBarcode,"Barcode"))
			return false;

		  if (!validRequired(theForm.eAvail,"Availability"))
			return false;
					
		  if (!validRequired(theForm.eResLength,"Reservation Length"))
			return false;
					
			if (theForm.eResLengthExceptionDay.value != "" || theForm.eResLengthException.value != "")
			{
				if (!validRequired(theForm.eResLengthExceptionDay,"Reservation Length Exception Day"))
					return false;
	
				if (!validRequired(theForm.eResLengthException,"Reservation Length Exception Length"))
					return false;
			} 

		  if (theForm.eFine.value != "")
		  {
			var formatReminder = "The format for fine schedule is '$$,$$,$$' where the $$ is a valid dollar value.  \r\rCommas separate days, and the last value in the series represents 'each additional day'.  \r\rFor example, if you charge $20 a day, simply enter '20'.  If you charge $5 for the first day, $10 for the second, and $20 for each additional day, enter '5,10,20'.";
			var commaSplit = theForm.eFine.value.split(",");
			
			for (i=0; i < commaSplit.length; i++)
			{
				numStr = new String(commaSplit[i]);
				if (!allDigits(commaSplit[i]) || (numStr.indexOf(".") != numStr.lastIndexOf(".")))
				{
					alert(formatReminder);
					theForm.eFine.focus();		
					return false;
				}
				//alert(validNum(commaSplit[i]));
				//if (!validNum(commaSplit[i]))
			}
		  			
		  }
					
		  return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].eName.focus();
		}

	//-->
	</script>

