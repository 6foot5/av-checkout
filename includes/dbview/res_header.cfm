

	<cfparam name="url.selfview" default="no">
	<cfparam name="url.sorter" default="R.OUT_DT">
	<cfparam name="url.orderby" default="DESC">
	<!--- <cfparam name="form.psid" default="0">
	<cfparam name="form.equipID" default="0"> --->
	<cfparam name="form.updateStatus" default="no">
	<cfparam name="homePage" default="no">
	<cfparam name="topCode" default="">
	
	<cfif form.updateStatus>
		<cfset updateDept = url.deptID>
		<cfmodule 
			template="#APP_webroot#/#APP_path_customtags#/get_dept_preferences.cfm"
			deptID="#updateDept#">	
		<cfinclude template="#APP_webroot#/includes/shared/res_status_update.cfm">	
	</cfif>

	<cfif url.deleteID>
		<cfset dbDeleteID = url.deleteID>
		<cfinclude template="#APP_webroot#/includes/dbdelete/reservation.cfm">
	</cfif>
	
	<cfset rightNow = CreateODBCDateTime(Now())>

	<cfquery name="get_content" datasource="#APP_dsn#">
		select	#topCode# R.RES_ID, R.DEPT_ID, R.RES_DT, R.OUT_DT, R.DUE_DT, R.STATUS, R.NOTES, R.RES_NOTES, R.INITIALS, D.DEPT_ID, D.DEPT_NAME, U.FIRST_NAME, U.LAST_NAME, U.EMAIL, U.PSID
		from	RESERVATIONS R, DEPARTMENTS D, USERS U
		where	R.DEPT_ID = D.DEPT_ID and
				R.USER_ID = U.USER_ID
				<cfif Trim(url.psid) NEQ "">				
					AND ( RTRIM(LTRIM(U.PSID)) = '#Trim(url.psid)#' OR Upper(RTRIM(LTRIM(U.LAST_NAME))) LIKE '#UCase(Trim(url.psid))#%' )
				</cfif>
				<cfif Trim(url.equipID) NEQ "">
					AND R.RES_ID IN (select RES_ID from RES_DETAILS R, EQUIPMENT E where R.EQUIP_ID = E.EQUIP_ID and E.BARCODE = #url.equipID#)				
				</cfif>
				<cfif url.late>
					AND R.DUE_DT < #rightNow#
				<cfelseif url.date NEQ "">
					AND (
							( 
								DATEPART(mm,R.RES_DT) = #DateFormat(url.date,"mm")# AND 
								DATEPART(dd,R.RES_DT) = #DateFormat(url.date,"dd")# AND 
								DATEPART(yyyy,R.RES_DT) = #DateFormat(url.date,"yyyy")# 
							)
							OR					
							( 	DATEPART(mm,R.DUE_DT) = #DateFormat(url.date,"mm")# AND 
								DATEPART(dd,R.DUE_DT) = #DateFormat(url.date,"dd")# AND 
								DATEPART(yyyy,R.DUE_DT) = #DateFormat(url.date,"yyyy")# 
							)
						)
				</cfif>
				<cfif url.upcoming EQ "checkins">
					AND R.STATUS = 'checked'
				</cfif>
				<cfif url.upcoming EQ "checkouts">
					AND R.STATUS = 'open'
				</cfif>
		<cfif url.deptID NEQ "all">
			and R.DEPT_ID=#url.deptID#
		</cfif>
				
		order by 
				#url.sorter# #url.orderby#
	</cfquery>
	
<!--- 	<cfif url.upcoming EQ "checkins">
		<cfset headerContent = "Due DT|User|Items|Notes">
		<cfset columnSorters = "R.DUE_DT|U.LAST_NAME|None|None">	
	<cfelse>
		<cfset headerContent = "Pickup DT|User|Items|Notes">
		<cfset columnSorters = "R.RES_DT|U.LAST_NAME|None|None">	
	</cfif>
	<cfset alignment = "center|left|left|left">	
	<cfset widths = "100|140|160|100">	
	 --->
	
	<cfif homePage>
		<cfset headerContent = "Pickup DT|Due DT|User|Items|Notes">
		<cfset columnSorters = "None|None|None|None|None">	
		<cfset alignment = "center|center|left|left|left">	
		<cfset widths = "150|150|140|160|100">	
	<cfelse>
		<cfset headerContent = "Pickup DT|Due DT|User|Items|Notes">
		<cfset columnSorters = "R.RES_DT|R.DUE_DT|U.LAST_NAME|None|None">	
		<cfset alignment = "center|center|left|left|left">	
		<cfset widths = "150|150|140|160|100">	
	</cfif>
	 