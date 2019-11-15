
	<cfparam name="form.hTag" default="Normal Operating Hours">
	<cfparam name="form.hType" default="normal">
	<cfparam name="form.hDateOn" default="01/01/2003">
	<cfparam name="form.hDateOff" default="12/31/2023">

	<cfset pageTitle = "Define Operating Hours - Step 2 of 3">
	
	<cfset dayDiff = DateDiff("d",form.hDateOn, hDateOff)>

	<cfset dow = ArrayNew(1)>
		<cfset dow[1] = "Sunday">
		<cfset dow[2] = "Monday">
		<cfset dow[3] = "Tuesday">
		<cfset dow[4] = "Wednesday">
		<cfset dow[5] = "Thursday">
		<cfset dow[6] = "Friday">
		<cfset dow[7] = "Saturday">

	<cfif dayDiff GTE 7>
		<cfset loopLimit = 7>
	<cfelse>
		<cfset loopLimit = dayDiff+1>
	</cfif>

	<cfset availDays = "">
	<cfset incDate = form.hDateOn>
	<cfloop index="i" from="1" to="#loopLimit#">
		<cfset availDays = ListAppend(availDays,DateFormat(incDate, "dddd"))>
		<cfset incDate = DateAdd("d",1,incDate)>
	</cfloop>
	
	<script LANGUAGE="JavaScript">
	<!--

		function validateForm(theForm)    
		{
		 	return true;
		}

		function setCursor() 
		{	
		}

	//-->
	</script>

