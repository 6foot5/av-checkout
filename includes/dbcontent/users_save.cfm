	
	
	<cfif dbEditID eq 0>
	
		<cfquery name="get_user" datasource="#APP_dsn#">
			select	*
			from	USERS
			where	RTRIM(LTRIM(PSID))='#Trim(form.uPSID)#'
		</cfquery>
		
		<cfif get_user.recordcount>

			<cfset errorMsg = "PSID " & Trim(form.uPSID) & " has already been registered in the system!">

			<cfoutput>
				<h4>Registration Summary</h4>				
				<p>PSID #Trim(form.uPSID)# has already been registered in the system!</p>
				<cfif form.source EQ "login">
					<p><a href="#APP_webroot#/logoff.cfm">Login</a></p>
				<cfelse>
					<p><a href="home.cfm">Return Home</a></p>
				</cfif>
			</cfoutput>

		<cfelse>			

			<cfquery name="uInsert" datasource="#APP_dsn#">
				INSERT INTO USERS 	
								(FIRST_NAME,
								LAST_NAME, 
								PSID, 
								<cfif uUsername NEQ "">
									USERNAME, 
								</cfif>
								<cfif uPassword NEQ "">
									PASSWORD, 
								</cfif>
								EMAIL,
								PHONE1, 
								PHONE2, 
								PHONE3, 
								<cfif uDeptOwner NEQ "">
									DEPT_OWNER, 
								</cfif>
								NOTES)	
				VALUES
								('#form.uFirstName#', 
								'#form.uLastName#', 
								'#form.uPSID#', 
								<cfif uUsername NEQ "">
									'#form.uUsername#', 
								</cfif>
								<cfif uPassword NEQ "">
									'#form.uPassword#', 
								</cfif>
								'#form.uEmail#', 
								'#form.uPhone1#', 
								'#form.uPhone2#', 
								'#form.uPhone3#', 
								<cfif uDeptOwner NEQ "">
									'#form.uDeptOwner#', 
								</cfif>
								'#form.uNotes#')									
			</cfquery>
	
			<cfif url.source NEQ "internal">
				
				<h4>Registration Summary</h4>
				
				<p>Thank you for registering!  <br><br>Please review the summary of your login information below.
				To access the equipment reservation and checkout system, <br>click on the link below and then login.<br><br>
				<cfoutput>
				<cfif ListFind(uDeptOwner,"0")>
					Username: Portal Username<br>
					Password: Portal Password</b>
				<cfelse>
					Username: <b>#form.uUsername#</b><br>
					Password: <b>#form.uPassword#</b>
				</cfif>
				</cfoutput>
				</p>
				
				<p>
				<cfoutput><a href="#APP_webroot#/logoff.cfm">Login</a></cfoutput>
				</p>
			
			</cfif>
		
		</cfif>
		
	<cfelse>
	
		<cfquery name="uUpdate" datasource="#APP_dsn#">
			update	USERS
			set				
					<cfif uPassword NEQ "">
						PASSWORD='#form.uPassword#',
					</cfif>
					EMAIL='#form.uEmail#',					
					PHONE1='#form.uPhone1#', 
					PHONE2='#form.uPhone2#', 
					PHONE3='#form.uPhone3#',
					DEPT_OWNER='#form.uDeptOwner#' 
			where	USER_ID = #dbEditID#
		</cfquery>
	
		<cfif url.source NEQ "internal">
			
			<h4>Profile Summary</h4>
			
			<p>Your profile has been updated!  Please review the summary of your login information below.
			<br><br>
			<cfoutput>
				Username: <b>#form.uUsername#</b><br>
				Password: <b>#form.uPassword#</b>
			</cfoutput>
			</p>
			
			<p>
			<a href="home.cfm">Back to Home</a>
			</p>
		
		</cfif>
	
	</cfif>
	
