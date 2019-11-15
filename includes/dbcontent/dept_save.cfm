	
	
	<cfif dbEditID eq 0>
		
		<cftransaction action="begin">
			<cfquery name="dInsert" datasource="#APP_dsn#">
				INSERT INTO DEPARTMENTS 	
								(DEPT_NAME,
								DEPT_EMAIL, 
								NOTES,
								USE_SCANNER,
								RES_ONLINE,
								RES_ADVANCE_TIME,
								RES_LENGTH_GEN,
								<cfif form.rResLengthException NEQ "">
									RES_LENGTH_EXCEPTION,
								</cfif>
								RES_EXPIRE_TIME,
								RES_CATWEEK_LIMIT_A,
								RES_CATWEEK_LIMIT_B,
								RES_CATWEEK_LIMIT_EXCEPTION,
								ALLOW_RECHECK,
								ASSESS_FINES,
								FINE_START,
								FINE_SCHEDULE,
								CHECKOUT_ALLOWED_WITH_FINE,
								CHECKOUT_MAX_PER_CAT,
								IP_ADDRESS)	
				VALUES
								('#form.dName#', 
								'#form.dEmail#',
								'#form.dNotes#',
								'#form.rScanner#',
								'#form.rOnline#',
								#form.rAdvanceTime#,
								#form.rResLength#,
								<cfif form.rResLengthException NEQ "">
									'#form.rResLengthException#',
								</cfif>
								#form.rResExpire#,
								#form.rResCatWeekLimitA#,
								#form.rResCatWeekLimitB#,
								#form.rResCatWeekLimitException#,
								'#form.rReCheck#',
								'#form.rAssessFines#',
								#form.rFineStart#,
								'#form.rFineSchedule#',
								'#form.rAllowCheckFine#',
								#form.rCheckoutCatLimit#,
								'#form.dIpAddress#');								
			</cfquery>
			
			<cfquery name="getID" datasource="#APP_dsn#">
				select 	max(DEPT_ID) as newID
				from	DEPARTMENTS
			</cfquery>
		</cftransaction>
<!--- <cfoutput>
								('#form.dName#', 
								'#form.dNotes#',
								'#form.rScanner#',
								'#form.rOnline#',
								#form.rAdvanceTime#,
								#form.rResLength#,
								#form.rResExpire#,
								#form.rResCatWeekLimitA#,
								#form.rResCatWeekLimitB#,
								#form.rResCatWeekLimitException#,
								'#form.rReCheck#',
								'#form.rAssessFines#',
								#form.rFineStart#,
								'#form.rFineSchedule#',
								'#form.rAllowCheckFine#',
								#form.rCheckoutCatLimit#);								

</cfoutput> --->
		<cfquery name="dInsertRoles" datasource="#APP_dsn#">
			INSERT INTO ROLES 	
							(DEPT_ID, 
							ROLE_NAME,
							NOTES)	
			VALUES
							(#getID.newID#, 
							'Admin',
							'Controls all aspects of system, aside from fines.');
			INSERT INTO ROLES 	
							(DEPT_ID, 
							ROLE_NAME,
							NOTES)	
			VALUES
							(#getID.newID#, 
							'FineMaster',
							'Has ability to define rules and change amounts for fines.');
			INSERT INTO ROLES 	
							(DEPT_ID, 
							ROLE_NAME,
							NOTES)	
			VALUES
							(#getID.newID#, 
							'WorkStudy',
							'Has ability to check items in and out, but most other admin access is limited.');
			INSERT INTO ROLES 	
							(DEPT_ID, 
							ROLE_NAME,
							NOTES)	
			VALUES
							(#getID.newID#, 
							'PartTime',
							'Has access to everything except fines and roles.');
		</cfquery>

	<cfelse>
	
		<cfquery name="dUpdate" datasource="#APP_dsn#">
			UPDATE	DEPARTMENTS
			SET 	DEPT_NAME = '#form.dName#',	
					DEPT_EMAIL = '#form.dEmail#',
					NOTES = '#form.dNotes#',
					USE_SCANNER = '#form.rScanner#',
					RES_ONLINE = '#form.rOnline#',
					RES_ADVANCE_TIME = #form.rAdvanceTime#,
					RES_LENGTH_GEN = #form.rResLength#,
					RES_LENGTH_EXCEPTION = '#form.rResLengthException#',
					RES_EXPIRE_TIME = #form.rResExpire#,
					RES_CATWEEK_LIMIT_A = #form.rResCatWeekLimitA#,
					RES_CATWEEK_LIMIT_B = #form.rResCatWeekLimitB#,
					RES_CATWEEK_LIMIT_EXCEPTION = #form.rResCatWeekLimitException#,
					ALLOW_RECHECK = '#form.rReCheck#',
					ASSESS_FINES = '#form.rAssessFines#',
					FINE_START = #form.rFineStart#,
					FINE_SCHEDULE = '#form.rFineSchedule#',
					CHECKOUT_ALLOWED_WITH_FINE = '#form.rAllowCheckFine#',
					CHECKOUT_MAX_PER_CAT = #form.rCheckoutCatLimit#,	
					IP_ADDRESS = '#form.dIpAddress#'	
			WHERE 	DEPT_ID = #dbEditID#
		</cfquery>
	
	</cfif>

