

	<cfquery name="get_dept" datasource="#APP_dsn#">
		select	DEPT_ID
		from 	ROLES
		where	ROLE_ID=#dbEditID#
	</cfquery>
	
	<cfset requestingDept = get_dept.DEPT_ID>

	<cfset pageTitle = "Modify Equipment / Role Relationships">

	<script language="JavaScript" type="text/javascript">
	<!--
		function setCursor() {						
		}

		function validateForm(theForm)
		{
			/*
			if (!validRequired(theForm.oCat,"Category"))
				return false;
		
			if (!validRequired(theForm.oEquip,"Equipment"))
				return false;
			*/
			return true;
		}
		
	// -->
	</script>
