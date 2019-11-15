
<cfparam name="attributes.date" default="#Now()#">

<cfset currentDate = Attributes.Date>

<cfset reservationWeek=ArrayNew(2)>
<cfset weekDay=ArrayNew(1)>

<cfset currentDayOfWeek = DateFormat(ParseDateTime("#currentDate#"), "dddd")>
<cfset currentDayOfMonth = DateFormat(ParseDateTime("#currentDate#"), "d")>
<cfset currentMonth = DateFormat(ParseDateTime("#currentDate#"), "m")>
<cfset currentYear = DateFormat(ParseDateTime("#currentDate#"), "yyyy")>

<cfswitch expression="#currentDayOfWeek#">
	<cfcase value="Saturday">
		<cfset diffS=currentDayOfMonth-0>
		<cfset diffF=currentDayOfMonth+6>
	</cfcase>
	<cfcase value="Sunday">
		<cfset diffS=currentDayOfMonth-1>
		<cfset diffF=currentDayOfMonth+5>
	</cfcase>
	<cfcase value="Monday">
		<cfset diffS=currentDayOfMonth-2>
		<cfset diffF=currentDayOfMonth+4>
	</cfcase>
	<cfcase value="Tuesday">
		<cfset diffS=currentDayOfMonth-3>
		<cfset diffF=currentDayOfMonth+3>
	</cfcase>
	<cfcase value="Wednesday">
		<cfset diffS=currentDayOfMonth-4>
		<cfset diffF=currentDayOfMonth+2>
	</cfcase>
	<cfcase value="Thursday">
		<cfset diffS=currentDayOfMonth-5>
		<cfset diffF=currentDayOfMonth+1>
	</cfcase>
	<cfcase value="Friday">
		<cfset diffS=currentDayOfMonth-6>
		<cfset diffF=currentDayOfMonth+0>
	</cfcase>
</cfswitch>


<cfif (diffS LT 1) AND (currentMonth IS NOT 1)>
	<cfset reservationWeek[1][1] = (currentMonth-1)> 
	<cfset reservationWeek[1][2] = (daysInMonth[currentMonth-1]+diffS)>  
	<cfset reservationWeek[1][3] = currentYear>  
<cfelseif (diffS LT 1) AND (currentMonth IS 1)>
	<cfset reservationWeek[1][1] = 12>  
	<cfset reservationWeek[1][2] = (daysInMonth[12]+diffS)> 
	<cfset reservationWeek[1][3] = (currentYear-1)>  
<cfelse>
	<cfset reservationWeek[1][1] = currentMonth>  
	<cfset reservationWeek[1][2] = diffS> 
	<cfset reservationWeek[1][3] = currentYear>  
</cfif>

<cfif (diffF GT daysInMonth[currentMonth]) AND (currentMonth IS NOT 12)>
	<cfset reservationWeek[2][1] = (currentMonth+1)> 
	<cfset reservationWeek[2][2] = (diffF)-(daysInMonth[currentMonth])>  
	<cfset reservationWeek[2][3] = (currentYear)> 
<cfelseif (diffF GT daysInMonth[currentMonth]) AND (currentMonth IS 12)>
	<cfset reservationWeek[2][1] = 1>  
	<cfset reservationWeek[2][2] = (diffF)-(daysInMonth[12])> 
	<cfset reservationWeek[2][3] = (currentYear+1)>  
<cfelse>
	<cfset reservationWeek[2][1] = currentMonth>  
	<cfset reservationWeek[2][2] = diffF> 
	<cfset reservationWeek[2][3] = currentYear>  
</cfif>

<cfset saturday="#reservationWeek[1][1]#/#reservationWeek[1][2]#/#reservationWeek[1][3]#">
<cfset friday="#reservationWeek[2][1]#/#reservationWeek[2][2]#/#reservationWeek[2][3]#">

<cfset #Caller.firstDay#=saturday>
<cfset #Caller.lastDay#=friday>