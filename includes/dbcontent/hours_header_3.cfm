
	<cfparam name="form.hTag" default="Normal Operating Hours">
	<cfparam name="form.hType" default="normal">
	<cfparam name="form.hDateOn" default="01/01/2003">
	<cfparam name="form.hDateOff" default="12/31/2023">
	<cfparam name="form.hDOW" default="">
	<cfparam name="form.hDefineType" default="simple">

	<cfset pageTitle = "Define Operating Hours - Step 3 of 3">
	
	<cfset daysSelected = ListToArray(form.hDOW)>

	<script LANGUAGE="JavaScript">
	<!--

		function validateForm(theForm)    
		{
			<cfloop index="x" from="1" to="#ArrayLen(daysSelected)#">
				<cfoutput>
					if (!validRequired(theForm.hHoursDay#x#,"#daysSelected[x]# Hours"))
						return false;
				</cfoutput>
			</cfloop>

			<cfloop index="x" from="1" to="#ArrayLen(daysSelected)#">
				<cfoutput>
					var formatReminder = "You must enter time periods separated by commas, with hyphens separating the start and end times for each period.  \r\rAll times must be in military format.  \r\rFor example, to enter hours for a day when you are open from 8am - 11:30am and again from 2pm - 6pm, you would enter 8:00-11:30,14:00-18:00.  \r\rFor a day when you are open from 10am - 8pm, you would simply enter 10:00-20:00.";
					var commaSplit = theForm.hHoursDay#x#.value.split(",");
					var lastHour = 0;
					var lastMin = 0;
					for (i=0; i < commaSplit.length; i++)
					{
						var hyphenSplit = commaSplit[i].split("-");
						
						if (hyphenSplit.length != 2) 
						{
							alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + formatReminder);
							return false;
						}
						else
						{
							var colonSplitOne = hyphenSplit[0].split(":");
							var colonSplitTwo = hyphenSplit[1].split(":");

							if ((colonSplitOne.length != 2) || (colonSplitTwo.length != 2))
							{
								alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + formatReminder);
								return false;
							}
							else
							{
								var isBadNumber = (isNaN(colonSplitOne[0]) || isNaN(colonSplitOne[1]) || isNaN(colonSplitTwo[0]) || isNaN(colonSplitTwo[1]));
								
								if (isBadNumber)
								{
									alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + 'Invalid number in time.');
									return false;
								}
								
								var isBadTime = ( 	(parseInt(colonSplitOne[0]) > 23 || parseInt(colonSplitOne[0]) < 0) ||
													(parseInt(colonSplitTwo[0]) > 23 || parseInt(colonSplitTwo[0]) < 0) ||
													(parseInt(colonSplitOne[1]) > 59 || parseInt(colonSplitOne[1]) < 0) ||
													(parseInt(colonSplitTwo[1]) > 59 || parseInt(colonSplitTwo[1]) < 0)
												);

								if (isBadTime)
								{
									alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + 'Time entered is out of valid range.');
									return false;
								}
								
								var dummyYear = 2000;
								var dummyMonth = 1;
								var dummyDay = 1;
								
								var laterdate = new Date(dummyYear,dummyMonth,dummyDay,colonSplitTwo[0],colonSplitTwo[1],0,0);   
								var earlierdate = new Date(dummyYear,dummyMonth,dummyDay,colonSplitOne[0],colonSplitOne[1],0,0);

								if (!timeCompareOK(parseInt(colonSplitOne[0]), parseInt(colonSplitOne[1]), parseInt(colonSplitTwo[0]), parseInt(colonSplitTwo[1])))																
								{
									alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + 'Times are entered improperly - opening time (' + parseInt(colonSplitOne[0]) + ':' + colonSplitOne[1] + ') must be earlier than close time (' + parseInt(colonSplitTwo[0]) + ':' + colonSplitTwo[1] + ').');
									return false;
								}
								if (!timeCompareOK(parseInt(lastHour), parseInt(lastMin), parseInt(colonSplitOne[0]), parseInt(colonSplitOne[1])))																
								{
									alert('Incorrect format for #daysSelected[x]#!' + '\r\r' + 'Times are entered improperly - subsequent opening time (' + parseInt(colonSplitOne[0]) + ':' + colonSplitOne[1] + ') must be later than previous closing time (' + parseInt(lastHour) + ':' + lastMin +')');
									return false;
								} 
								lastHour = colonSplitTwo[0];
								lastMin = colonSplitTwo[1];
							} 
						} 
					} 
				</cfoutput>
			</cfloop>

		 	return true;
		}

		function setCursor() 
		{
			<cfif #ArrayLen(daysSelected)# GT 0>
				document.forms['form1'].hHoursDay1.focus();			
			</cfif>
			return true;	
		}

	//-->
	</script>

