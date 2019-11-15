<!--- 
this returns a 2 part string (caller.equipItemString), part 1 has equipment info and part 2 has accessory info:

1. euqip ID _
2. barcode _
3. equip name _
4. res length _
5. due date _
6. time conflict (res id of conflict res) _
7. equip status (used for checkin to indicate item returned)
|
1. acc ID _
2. acc name
~
 --->
 
<cfparam name="attributes.equipID" default=0>
<cfparam name="attributes.barcode" default=0>
<cfparam name="attributes.equipName" default="na">
<cfparam name="attributes.resLength" default=0>
<cfparam name="attributes.dueDate" default="#CreateODBCDateTime(Now())#">
<cfparam name="attributes.timeConflict" default=0>
<cfparam name="attributes.equipStatus" default="na">
<cfparam name="attributes.accList" default="na">

	<cfif attributes.accList EQ "na">
		<cfquery name="get_acc" datasource="#caller.APP_dsn#">
			select	A.ACC_ID, A.ACC_NAME
			from 	ACCESSORIES A, EQUIPMENT E
			where	A.PKG_ID=E.ACC_PKG and
					E.EQUIP_ID=#attributes.equipID# and
					A.STATUS = 'current'
		</cfquery>
	<cfelse>
		<cfset tmpAccArray = ListToArray(attributes.accList)>
		<cfquery name="get_acc" datasource="#caller.APP_dsn#">
			select	ACC_ID, ACC_NAME
			from	ACCESSORIES
			where	0 = 1 
					<cfloop index="t" from="1" to="#ArrayLen(tmpAccArray)#">
						OR ACC_ID = #tmpAccArray[t]#
					</cfloop>
		</cfquery>
	</cfif>
		
	<cfif get_acc.recordcount>
		<cfset tmpAccList = "">
	<cfelse>
		<cfset tmpAccList = "empty">
	</cfif>
	
	<cfloop query="get_acc">
		<cfset tmpAccList = ListAppend(tmpAccList,"#ACC_ID#_#ACC_NAME#","~")>			
	</cfloop>
	
	<cfset caller.equipItemString = "#attributes.equipID#_#attributes.barcode#_#attributes.equipName#_#attributes.resLength#_#attributes.dueDate#_#attributes.timeConflict#_#attributes.equipStatus#|#tmpAccList#">
	

