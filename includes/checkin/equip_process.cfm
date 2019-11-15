


	<cfif form.removeID NEQ 0>
	
		<cfif ListLen(form.removeID,"|") EQ 1>
			<cfset equipArray[1][form.removeID] = Replace(equipArray[1][form.removeID],"_out","_in")>
			
		<!--- <cfelseif ListLen(form.removeID,"|") EQ 2>
			<cfset eID = GetToken(form.removeID,1,"|")>
			<cfset aID = GetToken(form.removeID,2,"|")>
			<cfset tmpEquipInfo = GetToken(equipArray[GetToken(eID,1,"_")],1,"|")>
			<cfset tmpAccArray = ListToArray(GetToken(equipArray[eID],2,"|"),"-")>
			<cfloop index="r" from="1" to="#ArrayLen(tmpAccArray)#">
				<cfif GetToken(tmpAccArray[r],1,"_") EQ aID>
					<cfset tmpAccArray[r] = deletedConstant>
				</cfif>
			</cfloop>
			<cfset tmpAccList = ArrayToList(tmpAccArray,"-")>
			<cfset equipArray[eID] = "#tmpEquipInfo#|#tmpAccList#"> --->
			
		</cfif>
	
		<cfset validEquips = 0>
		<cfloop index="x" from="1" to="#ArrayLen(equipArray[1])#"> <!--- need thise to be 2 dimensional to work with equipdisplay (tuned for recurring) --->
			<cfif equipArray[1][x] NEQ deletedConstant>
				<cfset validEquips = validEquips + 1>
			</cfif>
		</cfloop>

		<cfset form.somethingChecked = form.somethingChecked + 1>	
	</cfif>
	
	
