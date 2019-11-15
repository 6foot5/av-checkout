	
		<cfset todaysDate = DateFormat(Now(),"m/d/yyyy")>

		<cfquery name="fUpdate" datasource="#APP_dsn#">
			UPDATE	FINES
			SET 	AMOUNT = #form.fAmount#,
					<cfif Trim(form.fStatus) EQ	"paid">
						SETTLE_DATE = '#todaysDate#',	
					</cfif>
					STATUS = '#form.fStatus#'
			WHERE 	FINE_ID = #dbEditID#
		</cfquery>

