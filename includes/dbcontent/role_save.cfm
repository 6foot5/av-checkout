	
	
	<cfif dbEditID eq 0>
	
		<cftransaction action="begin">
			<cfquery name="rInsert" datasource="#APP_dsn#">
				insert into	ROLES
						(DEPT_ID, ROLE_NAME, NOTES)
				values
						(#form.rDept#, '#form.rName#', '#form.rNotes#')		
			</cfquery>
		<cftransaction action="commit"/>
			<cfquery name="rGetMax" datasource="#APP_dsn#">
				select	max(ROLE_ID) as newID
				from	ROLES;
			</cfquery>
		</cftransaction>
		
		<cfset newClasses = ListToArray(form.class_list)>
		<cfset rID = rGetMax.newID>
		
		<cfloop index="i" from="1" to="#ArrayLen(newClasses)#">
			<cfif newClasses[i] NEQ form.deletedConstant>
				<cfset cID = GetToken(newClasses[i],1,"|")>
				<cfset cName = GetToken(newClasses[i],2,"|")>
				<cfoutput>#cID#, #cName#</cfoutput>
				<cfquery name="aInsert" datasource="#APP_dsn#">
					insert into	ROLES_CLASSES
								(ROLE_ID, PS_CLASS_ID, PS_CLASS_NAME)
					values
								(#rID#, '#Replace(cID," ","")#', '#Trim(cName)#');
				</cfquery>
			</cfif>
		</cfloop>
	
	
	<cfelse>
	
		<cfquery name="rUpdate" datasource="#APP_dsn#">
			UPDATE	ROLES
			SET 	DEPT_ID = #form.rDept#,	
					ROLE_NAME = '#form.rName#',
					NOTES = '#form.rNotes#'
			WHERE 	ROLE_ID = #dbEditID#
		</cfquery>
	
		<cfquery name="cDelOld" datasource="#APP_dsn#">
			delete	
			from	ROLES_CLASSES
			where 	ROLE_ID = #dbEditID#
		</cfquery>
		
		<cfset newClasses = ListToArray(form.class_list)>
		<cfset rID = dbEditID>
		
		<cfloop index="i" from="1" to="#ArrayLen(newClasses)#">
			<cfif newClasses[i] NEQ form.deletedConstant>
				<cfset cID = GetToken(newClasses[i],1,"|")>
				<cfset cName = GetToken(newClasses[i],2,"|")>
				<cfquery name="aInsert" datasource="#APP_dsn#">
					insert into	ROLES_CLASSES
								(ROLE_ID, PS_CLASS_ID, PS_CLASS_NAME)
					values
								(#rID#, '#Replace(cID," ","")#', '#Replace(cName," ","")#');
				</cfquery>
			</cfif>
		</cfloop>
	
	</cfif>

