

	<cfif form.specialResType NEQ "normal">
		<script language="JavaScript">
		<!-- // create calendar object(s) just after form tag closed
			 // specify form element as the only parameter (document.forms['formname'].elements['inputname']);
			 // note: you can have as many calendar objects as you need for your application
			var cal1 = new calendar2(document.forms['walkinBuild'].elements['specialStartDate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar2(document.forms['walkinBuild'].elements['specialEndDate']);
			cal2.year_scroll = true;
			cal2.time_comp = false;
		//-->
		</script>
	</cfif>
