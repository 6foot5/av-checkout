
	<cfparam name="form.dept" default="">

	<cfif dbEditID EQ 0>
		
		<cfset editContract = "no">
		<cfset alreadyExists = "no">
		<cfset foundPSID = "no">
		
		<!--- first, see if user has already been registered in the checkout system --->
		
		<cfquery name="get_user" datasource="#APP_dsn#">
			select	*
			from	USERS
			where	RTRIM(LTRIM(PSID))='#Trim(form.uPSID)#'
		</cfquery>
		
		<!--- if yes, then user cannot be registered again...bounce back to PSID page --->
		
		<cfif get_user.RecordCount GT 0>
		
			<cfset alreadyExists EQ "yes">
			
			<cfset errorMsg = "PSID " & Trim(form.uPSID) & " has already been registered in the system!">
			<cfoutput>
				<form action="dbcontent.cfm?source=#url.source#" method="post" name="errorExists">
					<input type="hidden" name="URL" value="#referringURL#">
					<input type="hidden" name="contentType" value="#contentType#">
					<input type="hidden" name="editID" value="#dbEditID#">
					<input type="hidden" name="error" value="#errorMsg#">
					<input type="hidden" name="step" value="one">
					<input type="hidden" name="status" value="ready">
				</form>
			</cfoutput>
			<script language="JavaScript">
			<!--
				document.forms['errorExists'].submit();
			-->
			</script>
			
		<!--- user not already registered, so check LDAP to see if user exists there --->
			
		<cfelse>

			<cfinclude template="#APP_webroot#/includes/shared/ldap_variables.cfm">
			
			<!--- 
			
			this include defines the following:
			
			LDAP_root
			LDAP_server
			LDAP_port
			LDAP_username
			LDAP_password 
			
			--->								

			<cfset userfilter = "(physicalDeliveryOfficeName=#form.uPSID#)">
			
			<cfset UserSearchFailed = 0>

			<cftry>
			
				<cfldap action="QUERY"
						name="auth"
						attributes="cn,mail,description,title,physicalDeliveryOfficeName,sAMAccountName,memberof"
						start="#LDAP_root#"
						server="#LDAP_server#"
						port="#LDAP_port#"
						filter="#userfilter#"
						username="#LDAP_username#"
						password="#LDAP_password#"> 
				
				<cfcatch type="Any">				
					<cfset UserSearchFailed = 1>				
				</cfcatch>
				
			</cftry>
			
			<!--- If user search returns a result, add user info to checkout DB from LDAP --->
			<cfif auth.recordcount AND NOT UserSearchFailed>
			
				<cfset fullName = Trim(auth.description)>
				<cfset comma=",">
				<cfset firstName=Trim(GetToken(fullName, 2, comma))>
				<cfset lastName=Trim(GetToken(fullName, 1, comma))>
				
				<cfset Ffirst=UCase(Chr(Asc(firstName)))>
				<cfset Frest=Lcase(RemoveChars(firstName, 1, 1))> 
				<cfset Frest = SpanExcluding(Frest," ")> 
				<cfset Ffull=Ffirst & Frest>
				
				<cfset Lfirst=UCase(Chr(Asc(lastName)))>
				<cfset Lrest=Lcase(RemoveChars(lastName, 1, 1))>
				<cfset Lfull=Lfirst & Lrest>  
				
				<cfset uFirstName = Ffull>
				<cfset uLastName = Lfull>
				<cfset uPSID = Trim(form.uPSID)>
				<cfset uUsername = "">
				<cfset uPassword = "">
				<cfset uDeptOwner = 0>
				<cfset uEmail = "">
				<cfset uPhone1 = "">
				<cfset uPhone2 = "">
				<cfset uPhone3 = "">
				<cfset uNotes = "">
		
				<cfset pageTitle = "User Registration">
			
			<!--- If user search fails, check peoplesoft for user info --->
			<cfelse>
			
				<cfquery name="login_checkPS" DATASOURCE="#APP_PS_dsn#">
					SELECT 	B.EMPLID, B.NAME, B.LAST_NAME_SRCH
					FROM 	PS_PERS_DATA_SA_VW B
					WHERE 	B.EMPLID = '#form.uPSID#' 
				</cfquery> 						

				<cfif login_checkPS.RecordCount GT 0>
				
					<cfset fullName = Trim(login_checkPS.NAME)>
					<cfset comma=",">
					<cfset firstName=Trim(GetToken(fullName, 2, comma))>
					<cfset lastName=Trim(GetToken(fullName, 1, comma))>
					
					<cfset Ffirst=UCase(Chr(Asc(firstName)))>
					<cfset Frest=Lcase(RemoveChars(firstName, 1, 1))> 
					<cfset Frest = SpanExcluding(Frest," ")> 
					<cfset Ffull=Ffirst & Frest>
					
					<cfset Lfirst=UCase(Chr(Asc(lastName)))>
					<cfset Lrest=Lcase(RemoveChars(lastName, 1, 1))>
					<cfset Lfull=Lfirst & Lrest>  
					
					<cfset uFirstName = Ffull>
					<cfset uLastName = Lfull>
					<cfset uPSID = Trim(form.uPSID)>
					<cfset uUsername = Trim(form.uPSID)>
					<cfset uPassword = "">
					<cfset uDeptOwner = "">
					<cfset uEmail = "">
					<cfset uPhone1 = "">
					<cfset uPhone2 = "">
					<cfset uPhone3 = "">
					<cfset uNotes = "">
			
					<cfset pageTitle = "User Registration">
			
				<cfelse>
				
					<cfset errorMsg = "You have entered an invalid [ORG-NAME] ID.  Please try again.">
					<cfoutput>
						<form action="dbcontent.cfm?source=#url.source#" method="post" name="errorPSID">
							<input type="hidden" name="URL" value="#referringURL#">
							<input type="hidden" name="contentType" value="#contentType#">
							<input type="hidden" name="editID" value="#dbEditID#">
							<input type="hidden" name="error" value="#errorMsg#">
							<input type="hidden" name="step" value="one">
							<input type="hidden" name="status" value="ready">
						</form>
					</cfoutput>
					<script language="JavaScript">
					<!--
						document.forms['errorPSID'].submit();
					-->
					</script>
				</cfif>

			</cfif>
			<!--- </cfif> --->
			

		</cfif>
				
	<cfelse>
	
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	USERS
			where	USER_ID=#dbEditID#
		</cfquery>
	
		<cfset uFirstName = Trim(get_content.FIRST_NAME)>
		<cfset uLastName = Trim(get_content.LAST_NAME)>
		<cfset uPSID = Trim(get_content.PSID)>
		<cfset uUsername = Trim(get_content.USERNAME)>
		<cfset uPassword = Trim(get_content.PASSWORD)>
		<cfset uEmail = Trim(get_content.EMAIL)>
		<cfset uDeptOwner = get_content.DEPT_OWNER>
		<cfset uPhone1 = get_content.PHONE1>
		<cfset uPhone2 = get_content.PHONE2>
		<cfset uPhone3 = get_content.PHONE3>
		<cfset uNotes = get_content.NOTES>
		
		<cfif Trim(form.dept) NEQ "">
			<cfset editContract = "yes">
			<cfif ListFind(uDeptOwner,Trim(form.dept))>
				<cfset ownerWithout = ListDeleteAt(uDeptOwner,ListFind(uDeptOwner,Trim(form.dept)))>
				<cfset ownerWith = uDeptOwner>
			<cfelse>
				<cfset ownerWithout = uDeptOwner>
				<cfset ownerWith = ListAppend(uDeptOwner,Trim(form.dept))>
			</cfif>
		<cfelse>
			<cfset editContract = "no">
		</cfif>

		<cfset pageTitle = "Modify User Entry">

		<!--- <cfoutput>
		</cfoutput> --->

	</cfif>

	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{

			if (!validInt(theForm.uPhone1,"Phone Number", true))
				return false;
			
			if (!validInt(theForm.uPhone2,"Phone Number", true))
				return false;
			
			if (!validInt(theForm.uPhone3,"Phone Number", true))
				return false;
			
			if (theForm.uPhone1.value.length != 3)
			{
				alert('Please provide a valid local phone number.');
				theForm.uPhone1.focus();
				return false;		
			}

			if (theForm.uPhone2.value.length != 3)
			{
				alert('Please provide a valid local phone number.');
				theForm.uPhone2.focus();
				return false;		
			}

			if (theForm.uPhone3.value.length != 4)
			{
				alert('Please provide a valid local phone number.');
				theForm.uPhone3.focus();
				return false;		
			}

			if (!validEmail(theForm.uEmail,"Email Address", true))
				return false;
			
			<cfif NOT ListFind(uDeptOwner,"0")>
				
				if (!validRequired(theForm.uPassword,"Password"))
					return false;
							
				if (!validRequired(theForm.uPasswordConfirm,"Confirm Password"))
					return false;
							
				if (theForm.uPassword.value != theForm.uPasswordConfirm.value)
				{
					alert('Password entry must match Confirm Password entry.');
					theForm.uPassword.focus();
					return false;		
				}
	
			</cfif>
			
		  return true;
		}

		function setCursor() 
		{	
			document.forms['form1'].uPhone1.focus();
		}

	//-->
	</script>


		<!--- <script LANGUAGE="JavaScript">
		<!--
			function validateForm(theForm)    
			{
	
				if (!validInt(theForm.uPhone1,"Phone Number", true))
					return false;
				
				if (!validInt(theForm.uPhone2,"Phone Number", true))
					return false;
				
				if (!validInt(theForm.uPhone3,"Phone Number", true))
					return false;
				
				if (theForm.uPhone1.value.length != 3)
				{
					alert('Please provide a valid local phone number.');
					theForm.uPhone1.focus();
					return false;		
				}
	
				if (theForm.uPhone2.value.length != 3)
				{
					alert('Please provide a valid local phone number.');
					theForm.uPhone2.focus();
					return false;		
				}
	
				if (theForm.uPhone3.value.length != 4)
				{
					alert('Please provide a valid local phone number.');
					theForm.uPhone3.focus();
					return false;		
				}
	
				if (!validEmail(theForm.uEmail,"Email Address", true))
					return false;
							
				if (!validRequired(theForm.uPassword,"Password"))
					return false;
							
				if (!validRequired(theForm.uPasswordConfirm,"Confirm Password"))
					return false;
							
				if (theForm.uPassword.value != theForm.uPasswordConfirm.value)
				{
					alert('Password entry must match Confirm Password entry.');
					theForm.uPassword.focus();
					return false;		
				}
	
			  return true;
			}
	
			function setCursor() 
			{	
				document.forms['form1'].uPhone1.focus();
			}
	
		//-->
		</script> --->

