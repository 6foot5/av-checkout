	
	
	<cfif dbEditID eq 0>
	
		<cfquery name="dInsert" datasource="#APP_dsn#">
			INSERT INTO CATEGORIES 	
							(DEPT_ID,
							CAT_NAME, 
							ENFORCE_LIMIT,
							NOTES)	
			VALUES
							(#form.cDept#,
							'#form.cName#', 
							'#form.cEnforceLimit#', 
							'#form.cNotes#')									
		</cfquery>

	<cfelse>
	
		<cfquery name="dUpdate" datasource="#APP_dsn#">
			UPDATE	CATEGORIES
			SET 	DEPT_ID = #form.cDept#,	
					CAT_NAME = '#form.cName#',	
					ENFORCE_LIMIT = '#form.cEnforceLimit#',	
					NOTES = '#form.cNotes#'
			WHERE 	CAT_ID = #dbEditID#
		</cfquery>
	
	</cfif>

