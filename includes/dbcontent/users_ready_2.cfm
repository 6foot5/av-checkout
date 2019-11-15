
<cfoutput>

	<!--- #form.dept#!!! --->

	<p>First Name:<br>
	<input class="readonly" type="text" size="15" name="uFirstName" value="#uFirstName#" readonly="yes"></p>								
	
	<p>Last Name:<br>
	<input class="readonly" type="text" size="15" name="uLastName" value="#uLastName#" readonly="yes"></p>								

	<p>Local Phone:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="3" name="uPhone1" value="#uPhone1#" maxlength="3">
	<input class="#APP_style_inputAdmin#" type="text" size="3" name="uPhone2" value="#uPhone2#" maxlength="3">
	<input class="#APP_style_inputAdmin#" type="text" size="4" name="uPhone3" value="#uPhone3#" maxlength="4">
	</p>								
	
	<p>Email:<br>
	<input class="#APP_style_inputAdmin#" type="text" size="50" name="uEmail" value="#uEmail#"></p>								
	
	<!--- <cfif url.source NEQ "login"> --->
	<!--- <cfelse>
	</cfif> --->
	<cfif ListFind(uDeptOwner,"0")>

		<input type="hidden" name="uUsername" value="#uUsername#">
		<input type="hidden" name="uPassword" value="#uPassword#">
		<input type="hidden" name="uPasswordConfirm" value="#uPassword#">	

	<cfelse>

		<p>Username:<br>
		<input class="readonly" type="text" size="25" name="uUsername" value="#uUsername#" readonly="yes"></p>								

		<p>Create Password:<br>
		<input class="#APP_style_inputAdmin#" type="password" size="25" name="uPassword" value="#uPassword#"></p>								
	
		<p>Confirm Password:<br>
		<input class="#APP_style_inputAdmin#" type="password" size="25" name="uPasswordConfirm" value="#uPassword#"></p>								
	
	</cfif>
	
	<cfif editContract>
		<select class="#APP_style_inputAdmin#" name="uDeptOwner">
			<cfif Trim(uDeptOwner) EQ Trim(ownerWith)>
				<option value="#Trim(ownerWith)#" selected>Yes, allowed to checkout</option>
				<option value="#Trim(ownerWithout)#">No, not allowed to checkout</option>
			<cfelse>
				<option value="#Trim(ownerWithout)#" selected>No, not allowed to checkout</option>
				<option value="#Trim(ownerWith)#">Yes, allowed to checkout</option>
			</cfif>
		</select>
	<cfelse>
		<input type="hidden" name="uDeptOwner" value="#uDeptOwner#">
	</cfif>

	<input type="hidden" name="uPSID" value="#uPSID#">

	<cfif url.source EQ "internal">
		<p>Notes:<br>
		<textarea class="#APP_style_inputAdmin#" name="uNotes" rows="5" cols="50">#uNotes#</textarea></p>
	<cfelse>
		<input type="hidden" name="uNotes" value="#uNotes#">	
	</cfif>

	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
