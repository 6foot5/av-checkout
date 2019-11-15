
	<cfparam name="url.status" default="cat">
	<cfparam name="url.dept" default=0>
	<cfparam name="url.type" default="walkin">
	<cfparam name="url.userID" default=0>
	<cfparam name="url.roleList" default="">
	<cfparam name="url.date" default="#Now()#">
	<cfparam name="url.time" default="#Now()#">

	<cfparam name="form.status" default="#url.status#">
	<cfparam name="form.dept" default="#url.dept#">
	<cfparam name="form.type" default="#url.type#">
	<cfparam name="form.userID" default="#url.userID#">
	<cfparam name="form.roleList" default="#url.roleList#">
	<cfparam name="form.date" default="#url.date#">
	<cfparam name="form.time" default="#url.time#">

	<cfmodule 
		template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
		deptID="#form.dept#">

<!--- 
	#useScanner#<br>
	#resOnline#<br>
	#resAdvanceTime#<br>
	#resLengthGen#<br>
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
--->


