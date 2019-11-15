

<cfset rowID = EQUIP_ID>

<cfif RES_LENGTH EQ 0>
	<cfset lengthString = "Return Same Day">
<cfelseif RES_LENGTH GT 0 AND RES_LENGTH LTE 48>
	<cfset lengthString = RES_LENGTH & " Hours">
<cfelseif RES_LENGTH GT 48 and RES_LENGTH LT 168>
	<cfset lengthString = RES_LENGTH/24 & " Day(s)">
<cfelse>
	<cfset lengthString = RES_LENGTH/168 & " Week(s)">
</cfif>

<cfset tableContent = BARCODE & "|" & NAME & "|" & AVAILABILITY & "|" & lengthString>
