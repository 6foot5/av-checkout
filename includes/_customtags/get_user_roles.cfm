
	<cfparam name="attributes.classList" default="">
	<cfparam name="attributes.userID" default="0">

	<cfset classArray = ListToArray(attributes.classList)>
	
	<cfquery name="get_roles" datasource="#caller.APP_dsn#">
		select	R.ROLE_ID, R.DEPT_ID, R.ROLE_NAME
		from	ROLES_USERS RU, ROLES R
		where	RU.USER_ID = #attributes.userID# and
				RU.ROLE_ID = R.ROLE_ID 
	</cfquery>
	
	<cfquery name="get_roles_classes" datasource="#caller.APP_dsn#">
		select	R.ROLE_ID, R.DEPT_ID, R.ROLE_NAME
		from	ROLES_CLASSES RC, ROLES R
		where	(RC.PS_CLASS_ID = '000000'
				<cfloop index="x" from="1" to="#ArrayLen(classArray)#">
					or RTRIM(LTRIM(RC.PS_CLASS_ID)) = '#classArray[x]#'
				</cfloop>) and
				RC.ROLE_ID = R.ROLE_ID
	</cfquery>
	
	<cfset roleList = "">
	<cfset possibleAdminRoles = "Admin,globalAdmin,FineMaster,WorkStudy,PartTime">
	<cfset adminDepts = "">
	<cfset adminType = "">
	
	<cfset remoteIP = Trim(cgi.Remote_Addr)>
	<cfset remoteSubnet = Trim(GetToken(cgi.Remote_Addr,1,".") & "." & getToken(cgi.Remote_Addr,2,".") & "." & getToken(cgi.Remote_Addr,3,".") & ".")>
	
	<cfloop query="get_roles">
		<cfif ListContains(possibleAdminRoles, Trim(ROLE_NAME)) NEQ 0>
			<cfquery name="get_dept_ip" datasource="#caller.APP_dsn#">
				select	IP_ADDRESS
				from	DEPARTMENTS
				where	DEPT_ID=#get_roles.DEPT_ID#
			</cfquery>
			<!---  commented out 12-09-03...need to wait for static IP to reinstate this condition
			<cfif NOT ListContains(adminDepts, DEPT_ID) and ( ListContains(get_dept_ip.IP_ADDRESS, Trim(cgi.Remote_Addr)) )> --->
			<cfif NOT ListContains(adminDepts, DEPT_ID)>
				<cfif (Trim(ROLE_NAME) EQ "WorkStudy" AND (ListContains(get_dept_ip.IP_ADDRESS, remoteIP) OR ListContains(get_dept_ip.IP_ADDRESS, remoteSubnet))) OR Trim(ROLE_NAME) NEQ "WorkStudy">				
					<cfset adminDepts = ListAppend(adminDepts,DEPT_ID)>
				</cfif>
				<!--- <cfset adminDepts = ListAppend(adminDepts,DEPT_ID)> --->
			</cfif>
			<cfif (Trim(ROLE_NAME) EQ "WorkStudy" AND (ListContains(get_dept_ip.IP_ADDRESS, remoteIP) OR ListContains(get_dept_ip.IP_ADDRESS, remoteSubnet))) OR Trim(ROLE_NAME) NEQ "WorkStudy">				
				<cfset adminType = ListAppend(adminType,ROLE_NAME)>
			</cfif> 
			<!--- <cfset adminType = ListAppend(adminType,ROLE_NAME)> --->
		</cfif>
		<cfset roleList = ListAppend(roleList,"#ROLE_ID#|#ROLE_NAME#")>
	</cfloop>
	
	<cfloop query="get_roles_classes">
		<cfif NOT ListContains(roleList,ROLE_ID)>
			<cfset roleList = ListAppend(roleList,"#ROLE_ID#|#ROLE_NAME#")>			
		</cfif>
	</cfloop>
	
	<cfset caller.roleList = roleList>
	<cfset caller.adminDepts = adminDepts>
	<cfset caller.adminType = adminType>
