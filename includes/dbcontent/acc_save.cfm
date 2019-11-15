	
	
	<cfif dbEditID eq 0>
	
		<cftransaction action="begin">
			<cfquery name="pInsert" datasource="#APP_dsn#">
				insert into	ACCESSORY_PKG
						(DEPT_ID, PKG_NAME, NOTES, STATUS)
				values
						(#form.pDept#, '#form.pName#', '#form.pNotes#', 'current')		
			</cfquery>
		<cftransaction action="commit"/>
			<cfquery name="pGetMax" datasource="#APP_dsn#">
				select	max(PKG_ID) as newID
				from	ACCESSORY_PKG;
			</cfquery>
		</cftransaction>
		
		<cfset newAcc = ListToArray(form.acc_list)>
		<cfset pID = pGetMax.newID>
		
		<cfloop index="i" from="1" to="#ArrayLen(newAcc)#">
			<cfif newAcc[i] NEQ form.deletedConstant>
				<cfset aName = GetToken(newAcc[i],2,"|")>
				<cfset aNotes = GetToken(newAcc[i],3,"|")>
				<cfquery name="aInsert" datasource="#APP_dsn#">
					insert into	ACCESSORIES
								(PKG_ID, ACC_NAME, NOTES, STATUS)
					values
								(#pID#, '#aName#', '#aNotes#', 'current');
				</cfquery>
			</cfif>
		</cfloop>
	
	
	<cfelse>
	
		<cfquery name="pUpdate" datasource="#APP_dsn#">
			UPDATE	ACCESSORY_PKG
			SET 	DEPT_ID = #form.pDept#,	
					PKG_NAME = '#form.pName#',
					NOTES = '#form.pNotes#'
			WHERE 	PKG_ID = #dbEditID#
		</cfquery>
	
		<cfquery name="pDelOld" datasource="#APP_dsn#">
			update	ACCESSORIES
			set 	STATUS = 'deleted'
			where 	PKG_ID = #dbEditID#
		</cfquery>
		
		<cfset newAcc = ListToArray(form.acc_list)>
		<cfset pID = dbEditID>
		
		<cfloop index="i" from="1" to="#ArrayLen(newAcc)#">
			<cfif newAcc[i] NEQ form.deletedConstant>
				<cfset aID = GetToken(newAcc[i],1,"|")>
				<cfset aName = GetToken(newAcc[i],2,"|")>
				<cfset aNotes = GetToken(newAcc[i],3,"|")>

				<cfif aID EQ 0>
					<cfquery name="aInsert" datasource="#APP_dsn#">
						insert into	ACCESSORIES
									(PKG_ID, ACC_NAME, NOTES, STATUS)
						values
									(#pID#, '#aName#', '#aNotes#', 'current');
					</cfquery>
				<cfelse>
					<cfquery name="aUpdate" datasource="#APP_dsn#">
						update	ACCESSORIES
						set 	ACC_NAME = '#aName#', NOTES = '#aNotes#', STATUS = 'current'
						where 	ACC_ID = #aID#
					</cfquery>
				</cfif>
			</cfif>
		</cfloop>
	
	</cfif>

