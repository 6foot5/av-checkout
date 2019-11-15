


<cfoutput>
	<p><b>Equipment ID</b><br><br> <!--- *** Add Browse and Check Status functionality!! *** --->
	<input type="text" name="equipID" size="15" class="#APP_style_inputAdmin#" value="">
	<!--- <input class="#APP_style_inputAdmin#" type="button" value="..." onClick="JavaScript:document.forms['browse'].submit();"><br><br> --->
	<input class="#APP_style_inputAdmin#" type="button" value="browse" onClick="JavaScript:window.open('browse.cfm?date=#form.date#&time=#form.time#&dept=#form.dept#&status=cat&type=#form.type#&userID=#userID#&roleList=#roleList#', 'browse','toolbar=0,width=700,height=500,resizable=yes,scrollbars=yes');"><br><br>
	<input type="submit" name="submit" value="Add to Cart" class="#APP_style_inputAdmin#" onClick="JavaScript:document.forms['walkinBuild'].add.value='yes';"><br><br>
	</p>
</cfoutput>
