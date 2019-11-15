<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>

<cfset testList = "5,7,12,80">

<cfoutput>
#ListAppend(testList,22)#<br>
#ListDeleteAt(testList,ListFind(testList,12))#<br>
<cfif ListFind(testList,7)>
	#ListDeleteAt(testList,ListFind(testList,7))#<br>
</cfif>

</cfoutput>

</body>
</html>
