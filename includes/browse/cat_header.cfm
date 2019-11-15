

	<cfquery name="get_cats" datasource="#APP_dsn#">
		select	CAT_ID, CAT_NAME
		from	CATEGORIES
		where	DEPT_ID = #form.dept#			
		order by 
				CAT_NAME
	</cfquery>
	