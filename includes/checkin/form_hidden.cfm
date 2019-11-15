

<cfoutput>
	<input type="hidden" name="fine" value="#resFine#">
	<input type="hidden" name="resID" value="#form.resID#">
	<input type="hidden" name="somethingChecked" value="#form.somethingChecked#">
	<input type="hidden" name="alreadyChecked" value="#form.alreadyChecked#">
	<input type="hidden" name="removeID" value=0>
	<input type="hidden" name="status" value="ready">
	<input type="hidden" name="equip_list" value="#ArrayToList(equipArray[1])#">
	<cfif form.status NEQ "ready">
		<input type="hidden" name="initials" value="#form.initials#">
	</cfif>
</cfoutput>
