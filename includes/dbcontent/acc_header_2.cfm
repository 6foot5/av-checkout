

	<cfparam name="form.addA" default="no">
	<cfparam name="form.editNow" default="no">
	<cfparam name="form.editAID" default=0>
	<cfparam name="form.removeAID" default=0>
	<cfparam name="form.from" default="start">
	
	<cfset pageTitle = "Modify Accessory Package">

	<cfset deletedConstant = "deleted666">

	<cfif dbEditID EQ 0>
		<cfparam name="form.acc_list" default="">
	<cfelse>
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	ACCESSORIES
			where	PKG_ID=#dbEditID# and
					STATUS = 'current'
		</cfquery>
		<cfset dbList = "">
		<cfloop query="get_content">
			<cfset addValue = ACC_ID & "|" & ACC_NAME & "|" & NOTES>
			<cfset dbList = ListAppend(dbList,addValue)>
		</cfloop>
		<cfparam name="form.acc_list" default="#dbList#">
	</cfif>
	
	<cfset accArray = ListToArray(form.acc_list)>
	<cfset accListLen = ArrayLen(accArray)>
	
	<cfset validAccs = 0>
	<cfloop index="x" from="1" to="#accListLen#">
		<cfif accArray[x] NEQ deletedConstant>
			<cfset validAccs = validAccs + 1>
		</cfif>
	</cfloop>
	
	<cfif NOT form.editNow>

		<cfset aID = 0>
		<cfset aName = "">
		<cfset aNotes = "">

	<cfelse>
	
		<cfset aID = GetToken(accArray[form.editAID],1,"|")>
		<cfset aName = GetToken(accArray[form.editAID],2,"|")>
		<cfset aNotes =  GetToken(accArray[form.editAID],3,"|")>
		
	</cfif>

	<cfif form.from EQ "two">
	
		<cfif form.addA>

			<cfset problems = "|,_,~">
			<cfset tempName = form.aName>
		
			<cfloop list="#problems#" index="problem">
				<cfset tempName = Replace(tempName,"#problem#"," ","ALL")>
			</cfloop>
		
			<cfif form.editAID>
				<cfset accArray[form.editAID] = form.aID & "|" & tempName & "|" & form.aNotes>
			<cfelse>
				<cfset accArray[accListLen+1] = form.aID & "|" & tempName & "|" & form.aNotes>
			</cfif>
						
		<cfelseif form.removeAID>
		
			<cfset accArray[form.removeAID] = deletedConstant>

		</cfif>
		
	</cfif>

	<cfset accListLen = ArrayLen(accArray)>
	<cfset validAccs = 0>
	<cfloop index="x" from="1" to="#accListLen#">
		<cfif accArray[x] NEQ deletedConstant>
			<cfset validAccs = validAccs + 1>
		</cfif>
	</cfloop>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{
			
			if (theForm.aComplete.value == "no")
			{
				if (!validRequired(theForm.aName,"Accessory Name"))
					return false;
			}
					
			if (theForm.aComplete.value == "yes")
			{
				if (<cfoutput>#validAccs#</cfoutput> == 0)
				{
					alert('You must add at least one Accessory to continue.');
					return false;
				}
			}
			
			return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].aName.focus();
		}

	//-->
	</script>

