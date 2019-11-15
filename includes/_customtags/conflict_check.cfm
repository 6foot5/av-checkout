
<cfparam name="attributes.existingOut" default="">
<cfparam name="attributes.existingIn" default="">
<cfparam name="attributes.pendingOut" default="">
<cfparam name="attributes.pendingIn" default="">

<cfset Caller.outInBetween=0>
<cfset Caller.inConflict=0>

<cfif attributes.pendingOut GTE attributes.existingOut and attributes.pendingOut LT attributes.existingIn>
	<cfset Caller.outInBetween=1>
</cfif> 

<cfif attributes.pendingOut LT attributes.existingOut and attributes.pendingIn GT attributes.existingOut>
	<cfset Caller.inConflict=1>
</cfif>