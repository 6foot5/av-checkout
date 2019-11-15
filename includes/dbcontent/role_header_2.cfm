

	<cfparam name="form.addC" default="no">
	<cfparam name="form.editNow" default="no">
	<cfparam name="form.editCID" default=0>
	<cfparam name="form.removeCID" default=0>
	<cfparam name="form.from" default="start">
	<cfparam name="form.subject" default="">
	
	<cfset pageTitle = "Modify Role">

	<cfset deletedConstant = "deleted666">

	<cfif dbEditID EQ 0>
		<cfparam name="form.class_list" default="">
	<cfelse>
		<cfquery name="get_content" datasource="#APP_dsn#">
			select	*
			from 	ROLES_CLASSES
			where	ROLE_ID=#dbEditID#
		</cfquery>
		<cfset dbList = "">
		<cfloop query="get_content">
			<cfset addValue = PS_CLASS_ID & "|" & PS_CLASS_NAME>
			<cfset dbList = ListAppend(dbList,addValue)>
		</cfloop>
		<cfparam name="form.class_list" default="#dbList#">
	</cfif>
	
	<cfset classArray = ListToArray(form.class_list)>
	<cfset classListLen = ArrayLen(classArray)>
	
	<cfset validClasses = 0>
	<cfloop index="x" from="1" to="#classListLen#">
		<cfif classArray[x] NEQ deletedConstant>
			<cfset validClasses = validClasses + 1>
		</cfif>
	</cfloop>
	
	<!--- <cfif NOT form.editNow>

		<cfset cName = "">
		<cfset cNotes = "">

	<cfelse>
	
		<cfset cName = GetToken(classArray[form.editCID],1,"|")>
		<cfset cNotes =  GetToken(classArray[form.editCID],2,"|")>
		
	</cfif> --->

	<cfif form.from EQ "two">
	
		<cfif form.addC>
		
			<!--- <cfif form.editCID>
				<cfset classArray[form.editCID] = form.cName>
			<cfelse> --->
			<cfif NOT ListContains(form.class_list,form.cName)>
				<cfset classArray[classListLen+1] = form.cName>
			</cfif>
			<!--- </cfif> --->
						
		<cfelseif form.removeCID>
		
			<cfset classArray[form.removeCID] = deletedConstant>

		</cfif>
		
	</cfif>

	<cfset classListLen = ArrayLen(classArray)>
	<cfset validClasses = 0>
	<cfloop index="x" from="1" to="#classListLen#">
		<cfif classArray[x] NEQ deletedConstant>
			<cfset validClasses = validClasses + 1>
		</cfif>
	</cfloop>
	
	<cfif form.subject NEQ "">
		<CFQUERY NAME="CourseInfo" DATASOURCE="#APP_PS_dsn#">			
			SELECT 
				DISTINCT A.CRSE_ID,A.DESCR,B.SUBJECT,B.CATALOG_NBR
			FROM
				PS_CRSE_CATALOG A,	PS_CRSE_OFFER B
			WHERE
				A.EFFDT =(SELECT MAX(A_ED.EFFDT) FROM PS_CRSE_CATALOG A_ED
						  WHERE A.CRSE_ID = A_ED.CRSE_ID AND A_ED.EFFDT <= 
						  SUBSTRING(CONVERT(CHAR,GETDATE()),1,11))
			   AND A.CRSE_ID = B.CRSE_ID
					<!--- <cfif '#form.CourseSubject#' Is 'CS%'>
					AND (B.SUBJECT LIKE 'CS%'
					OR B.SUBJECT LIKE 'NC%'
					OR B.SUBJECT LIKE 'WKSHP%')
					<cfelseif '#form.CourseSubject#' Is 'SS%'>
					AND (B.SUBJECT LIKE 'SS%'
					OR B.SUBJECT LIKE 'WD%')	
					AND B.ACAD_CAREER <> 'CNST'	
					AND A.COMPONENT <> 'ABR'
					<cfelse></cfif> --->
					AND B.SUBJECT LIKE '#form.subject#%'
					AND B.ACAD_CAREER <> 'CNST'
					<!--- AND A.COMPONENT <> 'ABR' --->
					
				AND A.EFF_STATUS = 'A'
				 AND B.EFFDT =
					(SELECT MAX(B_ED.EFFDT) FROM PS_CRSE_CATALOG B_ED
					WHERE B.CRSE_ID = B_ED.CRSE_ID
					  AND B_ED.EFFDT <= SUBSTRING(CONVERT(CHAR,GETDATE()),1,11))
			
			ORDER BY B.SUBJECT, B.CATALOG_NBR			
		</cfquery>
	</cfif>

	
	<script LANGUAGE="JavaScript">
	<!--
		function validateForm(theForm)    
		{
			
			if (theForm.cComplete.value == "no")
			{
				if (!validRequired(theForm.cName,"Class Name"))
					return false;
			}
					
			/*
			if (theForm.cComplete.value == "yes")
			{
				if (<cfoutput>#validClasses#</cfoutput> == 0)
				{
					alert('You must add at least one Class to continue.');
					return false;
				}
			}*/
			
			return true;
		}

		function setCursor() 
		{	
			//document.forms['form1'].aName.focus();
		}

	//-->
	</script>

