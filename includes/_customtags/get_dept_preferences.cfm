
	<cfparam name="attributes.deptID" default="0">

	<cfquery name="get_prefs" datasource="#caller.APP_dsn#">
		select	*
		from 	DEPARTMENTS 
		where	DEPT_ID = #attributes.deptID# 
	</cfquery>
	
	<cfset caller.useScanner = get_prefs.USE_SCANNER>
	<cfset caller.resOnline = get_prefs.RES_ONLINE>
	<cfset caller.resAdvanceTime = get_prefs.RES_ADVANCE_TIME>
	<cfset caller.resLengthGen = get_prefs.RES_LENGTH_GEN>
	<cfif Trim(get_prefs.RES_LENGTH_EXCEPTION) NEQ "">
		<cfset caller.resLengthExceptionDay = GetToken(get_prefs.RES_LENGTH_EXCEPTION,1,",")>
		<cfset caller.resLengthException = GetToken(get_prefs.RES_LENGTH_EXCEPTION,2,",")>
	<cfelse>
		<cfset caller.resLengthExceptionDay = "">
		<cfset caller.resLengthException = "">
	</cfif>
	<cfset caller.resExpireTime = get_prefs.RES_EXPIRE_TIME>
	<cfset caller.resCatWeekLimitA = get_prefs.RES_CATWEEK_LIMIT_A>
	<cfset caller.resCatWeekLimitB = get_prefs.RES_CATWEEK_LIMIT_B>
	<cfset caller.resCatWeekLimitException = get_prefs.RES_CATWEEK_LIMIT_EXCEPTION>
	<cfset caller.allowRecheck = get_prefs.ALLOW_RECHECK>
	<cfset caller.assessFines = get_prefs.ASSESS_FINES>
	<cfset caller.fineStart = get_prefs.FINE_START>
	<cfset caller.fineSchedule = get_prefs.FINE_SCHEDULE>
	<cfset caller.checkoutAllowedWithFine = get_prefs.CHECKOUT_ALLOWED_WITH_FINE>
	<cfset caller.checkoutMaxPerCat = get_prefs.CHECKOUT_MAX_PER_CAT>
