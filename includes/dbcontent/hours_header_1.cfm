

	<cfif dbEditID eq 0>

		<cfset hDept = url.deptID>
		<cfset hTag = "">
		<cfset hType = "">
		<cfset hDateOn = "">
		<cfset hDateOff = "">
		
		<cfset pageTitle = "Define Operating Hours - Step 1 of 3">

	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	HOURS_DEF
			where	HOURS_ID=#dbEditID#
		</cfquery>
	
		<cfset hDept = get_content.DEPT_ID>
		<cfset hTag = get_content.HOURS_TAG>
		<cfset hType = Trim(get_content.TYPE)>
		<cfset hDateOn = DateFormat("#get_content.DATE_ON#", "m/d/yyyy")>
		<cfset hDateOff = DateFormat("#get_content.DATE_OFF#", "m/d/yyyy")>
		
		<cfset pageTitle = "Modify Operating Hours - Step 1 of 3">

		<cfif Trim(hType) EQ "normal">
			<cfset typeDescr = "Define Normal Operating Hours">
		<cfelse>
			<cfset typeDescr = "Temporarily Override Normal Operating Hours">
		</cfif>
	
	</cfif>

	<cfquery name="get_normaldates" datasource="#APP_dsn#">
		select	DATE_ON, DATE_OFF, HOURS_TAG
		from 	HOURS_DEF
		where	DEPT_ID = #url.deptID# and 
				TYPE = 'normal' and
				HOURS_ID <> #dbEditID#
	</cfquery>
	
	<cfquery name="get_overridedates" datasource="#APP_dsn#">
		select	DATE_ON, DATE_OFF, HOURS_TAG
		from 	HOURS_DEF
		where	DEPT_ID = #url.deptID# and 
				TYPE = 'override' and
				HOURS_ID <> #dbEditID#
	</cfquery>
	
	<script LANGUAGE="JavaScript">
	<!--

		function validateForm(theForm)    
		{
		  	if (!validRequired(theForm.hTag,"Name for Hours"))
				return false;

		  	if (!validDate(theForm.hDateOn,"Start Date", true))
				return false;

		  	if (!validDate(theForm.hDateOff,"End Date", true))
				return false;
				
			if (compareTwoValidDates(theForm.hDateOn.value,theForm.hDateOff.value) < 0)
			{
				alert('Start Date must be equal to or earlier than the end date!');
				return false;
			}	
			
			if (theForm.hType.value == "normal")
			{
				<cfoutput query="get_normaldates">
	
					<cfset d1 = DateFormat(DATE_ON, "m/d/yyyy")>
					<cfset d2 = DateFormat(DATE_OFF, "m/d/yyyy")>
	
					if ((compareTwoValidDates(theForm.hDateOn.value,"#d1#") <= 0 && compareTwoValidDates(theForm.hDateOn.value,"#d2#") >= 0) || (compareTwoValidDates(theForm.hDateOff.value,"#d1#") <= 0 && compareTwoValidDates(theForm.hDateOff.value,"#d2#") >= 0))
					{
						alert('Dates for normal hours must not conflict with other normal hours you have previously defined! \r\rYour existing #HOURS_TAG# run(s) from #d1# to #d2# and you have just tried to define new hours that run from ' + theForm.hDateOn.value + ' to ' + theForm.hDateOff.value +'. No overlap allowed! \r\rIf you wish to override #HOURS_TAG# for the dates you specified, please select the appropriate date type (under "These hours will...") on this screen.');
						return false;
					}	
					if ((compareTwoValidDates("#d1#",theForm.hDateOn.value) <= 0 && compareTwoValidDates("#d2#",theForm.hDateOff.value) >= 0))
					{
						alert('Dates for normal hours must not conflict with other normal hours you have previously defined! \r\rYour existing #HOURS_TAG# run(s) from #d1# to #d2# and you have just tried to define new hours that run from ' + theForm.hDateOn.value + ' to ' + theForm.hDateOff.value +'. No overlap allowed! \r\rIf you wish to override #HOURS_TAG# for the dates you specified, please select the appropriate date type (under "These hours will...") on this screen.');
						return false;
					}
	
				</cfoutput>
			}
			else
			{
				<cfoutput query="get_overridedates">
	
					<cfset d1 = DateFormat(DATE_ON, "m/d/yyyy")>
					<cfset d2 = DateFormat(DATE_OFF, "m/d/yyyy")>
	
					if ((compareTwoValidDates(theForm.hDateOn.value,"#d1#") <= 0 && compareTwoValidDates(theForm.hDateOn.value,"#d2#") >= 0) || (compareTwoValidDates(theForm.hDateOff.value,"#d1#") <= 0 && compareTwoValidDates(theForm.hDateOff.value,"#d2#") >= 0))
					{
						alert('Dates for override hours must not conflict with other override hours you have previously defined! \r\rYour existing #HOURS_TAG# run(s) from #d1# to #d2# and you have just tried to define new hours that run from ' + theForm.hDateOn.value + ' to ' + theForm.hDateOff.value +'. No overlap allowed!');
						return false;
					}	
					if ((compareTwoValidDates("#d1#",theForm.hDateOn.value) <= 0 && compareTwoValidDates("#d2#",theForm.hDateOff.value) >= 0))
					{
						alert('Dates for override hours must not conflict with other override hours you have previously defined! \r\rYour existing #HOURS_TAG# run(s) from #d1# to #d2# and you have just tried to define new hours that run from ' + theForm.hDateOn.value + ' to ' + theForm.hDateOff.value +'. No overlap allowed!');
						return false;
					}
	
				</cfoutput>
			}
					
		 	return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].hTag.focus();			
		}

	//-->
	</script>

