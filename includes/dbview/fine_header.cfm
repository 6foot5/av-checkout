

	<cfparam name="url.sorter" default="Upper(U.LAST_NAME)">
	<cfparam name="url.orderby" default="ASC">
	<cfparam name="url.showStatus" default="all">

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	F.FINE_ID, F.AMOUNT, F.STATUS, R.RETURN_DT, D.DEPT_NAME, U.FIRST_NAME, U.LAST_NAME
		from	FINES F, USERS U, DEPARTMENTS D, RESERVATIONS R
		where	F.RES_ID = R.RES_ID and
				R.DEPT_ID = D.DEPT_ID and
				R.USER_ID = U.USER_ID	
		<cfif url.deptID NEQ "all">
			and D.DEPT_ID=#url.deptID#
		</cfif>
		<cfif url.showStatus NEQ "all">
			and F.STATUS='open'
		</cfif>				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
	<cfset headerContent = "Fine Date|User Name|Amount|Department|Status">
	<cfset columnSorters = "R.RETURN_DT|Upper(U.LAST_NAME)|F.AMOUNT|Upper(D.DEPT_NAME)|Upper(F.STATUS)">	
	<cfset alignment = "left|left|right|left|left">	
	<cfset widths = "100|100|75|125|100">	
	