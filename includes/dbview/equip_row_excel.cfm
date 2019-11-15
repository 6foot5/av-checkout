

		<cfif index EQ 1>

			<CFFILE ACTION="Write"
	    			FILE="#APP_server_root#\csv\#url.deptID#.csv"
	        		OUTPUT="""Equipment ID"",""Equipment Name"",""Status"",""Status"",""Status"",""Status"",""Status"",""Notes"""
	    			ADDNEWLINE="Yes">

			<CFFILE ACTION="APPEND"
	    			FILE="#APP_server_root#\csv\#url.deptID#.csv"
	        		OUTPUT="""#Trim(BARCODE)#"",""#Trim(NAME)#"",""In"",""Out"",""Late"",""Offline"",""Missing"",""..."""
					ADDNEWLINE="Yes">

			
		<cfelseif index GT 1>

			<CFFILE ACTION="APPEND"
	    			FILE="#APP_server_root#\csv\#url.deptID#.csv"
	        		OUTPUT="""#Trim(BARCODE)#"",""#Trim(NAME)#"",""In"",""Out"",""Late"",""Offline"",""Missing"","" "","""""
					ADDNEWLINE="Yes">

		</cfif> 
