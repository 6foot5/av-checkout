
	<cfset oneYearAgo = CreateODBCDateTime(DateAdd("yyyy",-1,Now()))>

	<cfquery name="get_old_res" datasource="#APP_dsn#">
		select 	RES_ID
		from	RESERVATIONS
		where	RES_DT < #oneYearAgo# and
				RTRIM(LTRIM(STATUS)) <> 'checked' and
				RTRIM(LTRIM(STATUS)) <> 'open';
	</cfquery>
	
	<cfquery name="delete_old_res" datasource="#APP_dsn#">
		delete
		from	RES_DETAILS
		where	RES_ID IN
				(
					select	RES_ID
					from	RESERVATIONS
					where	RES_DT < #oneYearAgo# and
							RTRIM(LTRIM(STATUS)) <> 'checked' and
							RTRIM(LTRIM(STATUS)) <> 'open'
				);	

		delete
		from	RESERVATIONS
		where	RES_DT < #oneYearAgo# and
				RTRIM(LTRIM(STATUS)) <> 'checked' and
				RTRIM(LTRIM(STATUS)) <> 'open';
	</cfquery>
	
	<cfoutput query="get_old_res">
		#RES_ID#<br>
	</cfoutput>