
<cfoutput>

	<select name="subject"
	 		class="#APP_style_inputAdmin#"
			onChange="if(this.options[this.selectedIndex].value != '') { JavaScript:document.forms['form1'].status.value='ready';document.forms['form1'].cComplete.value='no'; document.forms['form1'].submit(); }">
		<option value="">Select a Subject Area</option>
		<option value="AH">Art History (AH)</option>
		<option value="AH">Animation (AN)</option>
		<option value="CE">Ceramics (CE)</option>
		<option value="DA">Digital Imaging (DA)</option>
		<option value="DE">"Old" Design Courses (DE)</option>
		<option value="DR">Drawing (DR)</option>
		<option value="EA">Electronic Arts (EA)</option>
		<option value="ED">Education (ED)</option>
		<option value="ENV">Environmental Design (ENV)</option>
		<option value="EX">Externships (EX)</option>
		<option value="FA">Graduate Fine Arts (FA)</option>
		<option value="FB">Fiber (FB)</option>
		<option value="FF">Foundation (FF)</option>
		<option value="GD">Graphic Design (GD)</option>
		<option value="GFA">General Fine Arts (GFA)</option>
		<option value="HST">History (HST)</option>	
		<option value="IL">Illustration (IL)</option>
		<option value="IM">Interactive Media (IM)</option>
		<option value="IN">Interior Architecture (IN)</option>
		<option value="L">Literature (L)</option>		
		<option value="LA">Liberal Arts (LA)</option>
		<option value="MA">Masters in Education (MAED & MAFA)</option>
		<option value="PBP">Post Baccalaureate (PBP)</option>		
		<option value="PH">Photography (PH)</option>	
		<option value="PR">Printmaking (PR)</option>	
		<option value="PT">Painting (PT)</option>	
		<option value="SC">Sculpture (SC)</option>	
		<option value="SCI">Science (SCI)</option>	
		<option value="SOC">Social Sciences (SOC)</option>	
		<option value="SS">Sculptural Studies (SS & WD)</option>	
		<option value="VC">"Old" Visual Communications (VC)</option>	
		<option value="VID">Video (VID)</option>	
		<option value="WD">Wood Sciences (WD)</option>	
	</select>
	
	<cfif form.subject NEQ ""><br><br>
		<select class="#APP_style_inputAdmin#" name="cName">
			<option value="000000|Everyone at [ORG-NAME]">Everyone at [ORG-NAME]</option>
			<cfloop query="CourseInfo">
				<option value="#CRSE_ID#|#SUBJECT# #CATALOG_NBR# - #DESCR#">#SUBJECT# #CATALOG_NBR# - #DESCR#</option>
			</cfloop>
		</select><br><br>
		<input class="#APP_style_inputAdmin#" type="submit" name="cSubmit" value="Add Class" onClick="JavaScript:document.forms['form1'].status.value='ready';document.forms['form1'].addC.value='yes';document.forms['form1'].cComplete.value='no';document.forms['form1'].subject.value='#form.subject#';">
	</cfif>
	
	<p>Classes Currently Tied to Role:<br><br>
	<table width="500" cellpadding="2" cellspacing="0" border="1" style="border-collapse: collapse">
		<tr class="tableHead" bgcolor="#APP_table_head_bgcolor#">
			<td width="100">Course ID</td>
			<td width="300">Name</td>
			<td width="100">&nbsp;</td>
		</tr>
		<cfif validClasses>
			<cfset rowcount = 0>
			<cfloop index="i" from="1" to="#classListLen#">
				<cfif classArray[i] NEQ deletedConstant>
					<cfif rowcount MOD 2 EQ 0>
						<cfset bgcolor=APP_rowColorEven>
					<cfelse>
						<cfset bgcolor=APP_rowColorOdd>
					</cfif>	
					<tr class="table" bgcolor="#bgcolor#">
						<td width="100">#GetToken(classArray[i],1,"|")#</td>
						<td width="300">#GetToken(classArray[i],2,"|")#</td>
						<td width="100" align="center">
							<a 	href="JavaScript:document.forms['form1'].submit();" 
								onClick="JavaScript:document.forms['form1'].removeCID.value='#i#';document.forms['form1'].status.value='ready';document.forms['form1'].cComplete.value='no';document.forms['form1'].subject.value='#form.subject#';">
								Remove</a><!---&nbsp;|&nbsp;
							 <a 	href="JavaScript:document.forms['form1'].submit();" 
								onClick="JavaScript:document.forms['form1'].editAID.value='#i#';document.forms['form1'].status.value='ready';document.forms['form1'].aComplete.value='no';document.forms['form1'].editNow.value='yes';">
								Edit</a> --->						
						</td>
					</tr>					
					<cfset rowcount = rowcount + 1>
				</cfif>
			</cfloop>
		<cfelse>
			<tr class="table">
				<td width="500" align="center" colspan="3">&nbsp;<br> * * * No Classes * * *<br>&nbsp;</td>
			</tr>					
		</cfif>
	</table>
	</p>
	
	<input type="hidden" name="addC" value="no">
	<input type="hidden" name="editNow" value="no">
	<input type="hidden" name="removeCID" value=0>
	<input type="hidden" name="cComplete" value="yes">
	<input type="hidden" name="from" value="two">
	<!--- <input type="hidden" name="subject" value="#form.subject#"> --->
	<input type="hidden" name="rDept" value="#form.rDept#">
	<input type="hidden" name="rName" value="#form.rName#">
	<input type="hidden" name="rNotes" value="#form.rNotes#">
	<input type="hidden" name="contentType" value="#contentType#">
	<input type="hidden" name="editID" value="#dbEditID#">
	<input type="hidden" name="class_list" value="#ArrayToList(classArray)#">
	<input type="hidden" name="deletedConstant" value="#deletedConstant#">
	<input type="hidden" name="step" value="two">
	<input type="hidden" name="status" value="save">
									
</cfoutput>
