
	
	<cfset todaysDate = DateFormat(Now(),"m/d/yyyy")>	
	
	<cfif form.specialResType NEQ "normal">
		<script LANGUAGE="JavaScript">
		<!--	
			function validateForm(theForm)    
			{
				if (!validDate(theForm.specialStartDate,"Start Date", true))
					return false;
	
				if (!validDate(theForm.specialEndDate,"End Date", true))
					return false;

				if (compareTwoValidDates(theForm.specialStartDate.value,theForm.specialEndDate.value) < 0)
				{
					alert('Start Date must be equal to or earlier than the end date!');
					return false;
				}	

				if (compareTwoValidDates("<cfoutput>#todaysDate#</cfoutput>",theForm.specialStartDate.value) < 0)
				{
					alert('Start Date cannot be earlier than today!');
					return false;
				}	
				
				return true;
			}
	
		//-->
		</script>
	</cfif>

