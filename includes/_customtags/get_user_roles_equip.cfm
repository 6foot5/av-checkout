
<cfparam name="attributes.deptID" default=0>
<cfparam name="attributes.userID" default=0>
<cfparam name="attributes.roleList" default="">

	<cfquery name="get_equipIDs" datasource="#caller.APP_dsn#">
		select	EQUIP_ID, ACC_LIST, STATUS
		from	RES_DETAILS
		where	RES_ID = #form.resID#
	</cfquery>

