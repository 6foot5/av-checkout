
<cfapplication 	name="checkout"
				clientmanagement="Yes"
				sessionmanagement="Yes"
				setclientcookies="Yes"
				sessiontimeout="#createtimespan(0,0,30,0)#"
				clientstorage="cookie">

		<cfset APP_title="[App Title]">
		<cfset APP_dsn="">
		<cfset APP_PS_dsn="">
		<cfset APP_webroot="">
		<cfset APP_path_css="css">
		<cfset APP_path_js="js">
		<cfset APP_path_customtags="includes/_customtags">
		<cfset APP_path_images="images">
		<cfset APP_URL="">
		<cfset APP_server_root="">
		<cfset APP_js_winSmall="toolbar=no,menubar=no,top=50,left=50,width=425,height=475,resizable=yes,scrollbars=yes">
		<cfset APP_js_winBig="toolbar=no,menubar=no,top=50,left=50,width=740,height=550,resizable=yes,scrollbars=yes">
		<cfset APP_js_winApp="toolbar=no,menubar=no,top=25,left=25,width=830,height=600,resizable=yes,scrollbars=yes">
		<cfset APP_style_inputAdmin="small">

		<cfset APP_topHeightF = "25">
		<cfset APP_leftWidthF = "150">

		<cfset APP_page_bgcolor="71828A">
		<cfset APP_head_bgcolor="71828A">
		<!--- <cfset APP_table_head_bgcolor="6495ED"> --->
		<cfset APP_table_head_bgcolor="B0C4DE">
		<cfset APP_table_bgcolor="FFFFFF">
		<cfset APP_mainTableBorder="1">
		<cfset APP_table_bgcolorInset="FFFFFF">
		<cfset APP_table_bordercolor="666666">
		<cfset APP_table_cellpad="10">
		<cfset APP_table_height="95%">
		<cfset APP_table_width="95%">
		<cfset APP_rowColorOdd="EEEEEE">
		<cfset APP_rowColorEven="FFFFFF">

<!---
The following variable will be used to find the master templates necessary to
authenticate users who log into your application.  Do not change this value.
 --->
<cfset APP_authDirectory = "/__authentication/master">


<!---
The following variables are fine with their default values.  only change them if you
rename any of the files originally copied to your directory from the /__authentication
directory (index.cfm, login_redirect.cfm, validate.cfm)
 --->
<cfset APP_loginPage = "login.cfm">
<cfset APP_validatePage = "validate.cfm">
<cfset APP_redirectPage = "login_redirect.cfm">


<!---
*APP_homePage* is the name of the page you'd like users to be directed to after
a successful login.  It is home.cfm by default, but you should change it to
whatever your home page is named.
 --->
<cfset APP_homePage = "version2.1/">


<!---
the values stored in the *APP_title* (e.g. Purchase Orders) and
*APP_descr* (e.g. Create and edit purchase orders)
variables will be ouput on the sign-in screen.
 --->
<cfset APP_title="[ORG-NAME] Online Checkout System">
<cfset APP_descr = "Login with your portal username and password and follow the instructions.  If you do not have a portal username or password, please contact the department whose equipment you'd like to check out.">

<!---
*APP_accessGroups* is used to limit access to your application to those
users who belong to certain groups on the LDAP server (e.g. bulk emailers, faculty, etc).
Specify a comma-separated list of groups who should have access to your app.
e.g.: <cfset APP_accessGroups = "Website Master,Website Contributor">
if the variable is set to nothing, any user may access the app, as
long as they enter a valid username and password
--->
<cfset APP_accessGroups = "">
