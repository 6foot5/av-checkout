
<cfparam name="attributes.rawTime" default="#Now()#">

<cfset currentHours=TimeFormat(attributes.rawTime, "H")>
<cfset currentMinutes=TimeFormat(attributes.rawTime, "mm")>

<cfif currentMinutes GT 0 and currentMinutes LTE 15>
	<cfset currentMinutes=15>
<cfelseif currentMinutes GT 15 and currentMinutes LTE 30>
	<cfset currentMinutes=30>
<cfelseif currentMinutes GT 30 and currentMinutes LTE 45>
	<cfset currentMinutes=45>
<cfelseif currentMinutes GT 45 and currentMinutes LTE 60>
	<cfset currentMinutes=0>
	<cfset currentHours=currentHours+1>
</cfif>

<cfset timePrime = currentHours & ":" & currentMinutes>
<cfset caller.adjustedTime=TimeFormat(ParseDateTime("#timePrime#"), "H:mm")>