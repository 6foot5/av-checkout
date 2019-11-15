

<cfoutput>
	<b>#NAME#</b> (#BARCODE#)<br>				
	<cfif Trim(ITEM_RETURN_DT) NEQ "">
		<i>Returned on #DateFormat(ITEM_RETURN_DT,"ddd, m/d/yyyy")# at #TimeFormat(ITEM_RETURN_DT,"h:mm tt")#</i><br>
	</cfif>
	<cfif ACC_PKG NEQ "">
		<cfset tmpAccArray = ListToArray(ACC_LIST)>
		 <cfquery name="get_acc" datasource="#APP_dsn#">
			select	ACC_NAME
			from	ACCESSORIES
			where	PKG_ID = #ACC_PKG# and
					(0 = 1 
					<cfloop index="t" from="1" to="#ArrayLen(tmpAccArray)#">
						OR ACC_ID = #tmpAccArray[t]#
					</cfloop>)
			order by
					ACC_NAME
		</cfquery>							
		<cfif get_acc.recordcount>
			<cfloop query="get_acc">
				&nbsp;&nbsp;&nbsp;#ACC_NAME#<br>
			</cfloop>
		</cfif>
	</cfif>
</cfoutput>
