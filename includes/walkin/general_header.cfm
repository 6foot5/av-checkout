
	<cfif form.status EQ "ready">
		<cfif form.type EQ "walkin">
			<cfset buttonName = "Confirm Checkout">
		<cfelse>	
			<cfset buttonName = "Confirm Reservation">
		</cfif>
		<cfset setStatus = "confirm">
	<cfelseif form.status EQ "date">
		<cfif form.type EQ "walkin">
			<cfset buttonName = "Finalize Checkout">
		<cfelse>	
			<cfset buttonName = "Continue">
		</cfif>	
		<cfset setStatus = "time">
	<cfelseif form.status EQ "time">
		<cfif form.type EQ "walkin">
			<cfset buttonName = "Finalize Checkout">
		<cfelse>	
			<cfset buttonName = "Continue">
		</cfif>	
		<cfset setStatus = "ready">
	<cfelseif form.status EQ "confirm">
		<cfif form.type EQ "walkin">
			<cfset buttonName = "Finalize Checkout">
		<cfelse>	
			<cfset buttonName = "Finalize Reservation">
		</cfif>	
		<cfset setStatus = "save">
	</cfif>
	
	<cfset thisPage="walkin">
		
	<script LANGUAGE="JavaScript">
	<!--

		function validateForm(theForm) 
		{
			
		<cfif form.status EQ "ready">
			if (theForm.add.value == "yes")
			{
				if (!validRequired(theForm.equipID,"Valid Equipment ID"))
					return false;
			}
		<cfelseif form.status EQ "confirm">
			if (theForm.initial_req.value == "yes")
			{
				if (!validRequired(theForm.initials,"Employee Initials"))
					return false;
			}
		</cfif>
			
			return true;
		}
		
		function setCursor() 
		{	
			<cfif form.status EQ "ready">
				document.forms['walkinBuild'].equipID.focus();
			</cfif>
		}

	//-->
	</script>

	<cfif form.status NEQ "ready">		
		<cfif form.type EQ "walkin">
			<cfset setResStatus = "checked">
		<cfelse>
			<cfset setResStatus = "open">
		</cfif>
	</cfif>

	<cfmodule 
		template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
		deptID="#form.dept#">

	<cfif form.updateStatus>
		<cfset updateDept = form.dept>
		<cfinclude template="#APP_webroot#/includes/shared/res_status_update.cfm">	
	</cfif>

<!--- <cfoutput>
	#useScanner#<br>
	#resOnline#<br>
	#resAdvanceTime#<br>
	#resLengthGen#<br>
	#resLengthException#<br>
	#resLengthExceptionDay#<br>
	#resExpireTime# <br>
	#resCatWeekLimitA#<br>
	#resCatWeekLimitB#<br>
	#resCatWeekLimitException#<br>
	#allowRecheck#<br>
	#assessFines#<br>
	#fineStart#<br>
	#fineSchedule#<br>
	#checkoutAllowedWithFine#<br>
	#checkoutMaxPerCat#<br>
</cfoutput> --->
