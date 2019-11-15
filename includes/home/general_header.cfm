	<cfparam name="url.type" default="">
	<cfparam name="url.pageMax" default=15>
	<cfparam name="form.psid" default="">
	<cfparam name="form.date" default="">
	<cfparam name="form.late" default="no">
	<cfparam name="form.equipID" default="">
	<cfparam name="form.upcoming" default="all">
	<cfparam name="url.upcoming" default="#form.upcoming#">
	<cfparam name="url.psid" default="#form.psid#">
	<cfparam name="url.late" default="#form.late#">
	<cfparam name="url.date" default="#form.date#">
	<cfparam name="url.equipID" default="#form.equipID#">
	<cfparam name="url.deleteID" default=0>
	<cfparam name="url.deptID" default="all">
	<cfparam name="url.catID" default="-1">
	<cfparam name="url.source" default="internal">
	<cfparam name="url.step" default=1>

	<cfset referringURL = ListLast(HTTP_REFERER, "/")>
	<cfif referringURL EQ "">
		<cfset referringURL = "home.cfm">
	</cfif>
	
	<!--- <cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 AND ListContains(cookie.userAdminType,"globalAdmin") EQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0> --->
	<cfif ( ListContains(cookie.userAdminType,"Admin") NEQ 0 )  OR  ListContains(cookie.userAdminType,"WorkStudy") NEQ 0>
		<script LANGUAGE="JavaScript">
		<!--
			function validateWalkinForm(theForm)    
			{
			
				if (!validNum(theForm.psid,"Valid [ORG-NAME] ID",true))
					return false;
					
				if (allDigits(theForm.psid.value))
				{
				
					theForm.psid.value = processPSID(theForm.psid).value;
	
					if (!validPSID(theForm.psid))
					{
						alert('Please provide a valid [ORG-NAME] ID.');
						theForm.psid.focus();
						return false;		
					}
				}
	
				return true;
			}
	
			function validateLookupForm(theForm)    
			{
				if (theForm.psid.value == "" && theForm.equipID.value == "")
				{
					alert('Please provide a valid [ORG-NAME] ID / Last Name or an Equipment ID.');
					theForm.psid.focus();
					return false;		
				}
						
				if (allDigits(theForm.psid.value) && theForm.psid.value != "")
				{			
					theForm.psid.value = processPSID(theForm.psid).value;
	
					if (!validPSID(theForm.psid))
					{
						alert('Please provide a valid [ORG-NAME] ID.');
						theForm.psid.focus();
						return false;		
					}
				}
	
				if (!allDigits(theForm.equipID.value) && theForm.equipID.value != "")
				{			
					alert('Please provide a valid Equipment ID.');
					theForm.equipID.focus();
					return false;		
				}
	
				return true;
			}
	
			function validateDayviewForm(theForm)    
			{
				
				if (theForm.upcoming.value == "all")
				{
					if (!validDate(theForm.date,"Lookup Date",true))
						return false;
				}
					
				return true;
			}
	
			function validateUsersForm(theForm)    
			{

				if (!validRequired(theForm.user,"User's PSID or Name"))
					return false;
				
				if (allDigits(theForm.user.value) && theForm.user.value != "")
				{			
					theForm.user.value = processPSID(theForm.user).value;
	
					if (!validPSID(theForm.user))
					{
						alert('Please provide a valid [ORG-NAME] ID.');
						theForm.user.focus();
						return false;		
					}
				}
	
				return true;
			}
	
			function setCursor() 
			{	
				document.forms['walkin'].psid.focus();
			}
	
		//-->
		</script>
	<cfelse>
		<script LANGUAGE="JavaScript">
		<!--
			function setCursor() 
			{	
			}
	
		//-->
		</script>
	</cfif>
	
	<!--- <script LANGUAGE="JavaScript">
	<!--
		function createTarget(form) 
		{

			_target = form.target;
			_colon = _target.indexOf(":");
			
			if (_colon != -1) 
			{
				form.target = _target.substring(0,_colon);
				form.args = _target.substring(_colon+1);
			} 
			else if (typeof(form.args)=="undefined") 
			{
				form.args = "";
			}
			
			if (form.args.indexOf("{")!=-1) 
			{
				_args = form.args.split("{");
				form.args = _args[0];
				for(var i = 1; i < _args.length;i++) 
				{
					_args[i] = _args[i].split("}");
					form.args += eval(_args[i][0]) + _args[i][1];
			   	}
			}
			
			form.args = form.args.replace(/ /g,"");
			_win = window.open('',form.target,form.args);
			
			if(typeof(focus)=="function")
				_win.focus();
		
			return true;		
		}
	//-->
	</script> --->

	