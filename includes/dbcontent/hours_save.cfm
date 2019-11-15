	
	
	<cfif dbEditID eq 0>
		
		<cftransaction action="begin">
			<cfquery name="hInsert" datasource="#APP_dsn#">
				INSERT INTO HOURS_DEF 	
								(DEPT_ID,
								TYPE, 
								DATE_ON, 
								DATE_OFF, 
								HOURS_TAG)	
				VALUES
								(#form.hDept#, 
								'#form.hType#', 
								'#form.hDateOn#', 
								'#form.hDateOff#', 
								'#form.hTag#')									
			</cfquery>
		<cftransaction action="commit"/>
			<cfquery name="hGetMax" datasource="#APP_dsn#">
				select	max(HOURS_ID) as newID
				from	HOURS_DEF;
			</cfquery>
		</cftransaction>
		
		<cfset daysSelected = ListToArray(form.hDOW)>
		
		<cfloop index="i" from="1" to="#ArrayLen(daysSelected)#">
			<cfset fieldName = "form.hHoursDay" & "#i#">
			<cfset hExp = "#fieldName#">
			<cfset hExpValue = Evaluate(hExp)>
			<cfquery name="hInsertDetails" datasource="#APP_dsn#">
				insert into	HOURS_DETAIL
							(HOURS_ID,
							DOW,
							DAILY_HOURS)
				values
							(#hGetMax.newID#,
							'#daysSelected[i]#',
							'#hExpValue#');
			</cfquery>
		</cfloop>
	
		<cfoutput>

			<script language="JavaScript">
			<!--
				//window.location.replace('#form.URL#');			
				//opener.location.replace('#form.URL#');
				//window.close();
			//-->
			</script>
			
		</cfoutput>
	
	<cfelse>
	
		<cfquery name="hUpdate" datasource="#APP_dsn#">
			UPDATE	HOURS_DEF
			SET 	DATE_ON = '#form.hDateOn#',	
					DATE_OFF = '#form.hDateOff#',
					HOURS_TAG = '#form.hTag#'
			WHERE 	HOURS_ID = #dbEditID#
		</cfquery>
	
		<cfquery name="hDelOld" datasource="#APP_dsn#">
			delete	
			from	HOURS_DETAIL
			where 	HOURS_ID = #dbEditID#
		</cfquery>
	
		<cfset daysSelected = ListToArray(form.hDOW)>
		
		<cfloop index="i" from="1" to="#ArrayLen(daysSelected)#">
			<cfset fieldName = "form.hHoursDay" & "#i#">
			<cfset hExp = "#fieldName#">
			<cfset hExpValue = Evaluate(hExp)>
			<cfquery name="hInsertDetails" datasource="#APP_dsn#">
				insert into	HOURS_DETAIL
							(HOURS_ID,
							DOW,
							DAILY_HOURS)
				values
							(#dbEditID#,
							'#daysSelected[i]#',
							'#hExpValue#');
			</cfquery>
		</cfloop>

		<cfoutput>
	
			<script language="JavaScript">
			<!--
				//window.location.replace('#form.URL#');			
				//opener.location.replace('#form.URL#');
				//window.close();
			//-->
			</script>
			
		</cfoutput>
	
	</cfif>

