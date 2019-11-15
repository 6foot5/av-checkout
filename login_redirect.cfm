
<!--- 

The following values are retrieved from the Directory and stored in these cookie variables:
  cookie.emplid = User's PeopleSoft Student/Employee ID number
  cookie.userID = User's Active Directory (portal/email) Userid
  cookie.userLast = User's Last Name
  cookie.userFirst = User's First Name
  cookie.email = user's email address
  cookie.memberOf = list of groups to which the user belongs
  
NOTEs to Developer:
	*) If your application requires role-based authentication, edit the "APP_accessGroups" variable in the 
		Application.cfm file to contain a list of all access groups that should be able to log into your application.
	*) You MUST update the value of the "APP_homePage" variable in the Application.cfm file to point to the page in 
		your application that will get loaded after authentication succeeds
	*) To add functionality to this page (e.g. store additional directory attributes in the cookie), 
		you may edit either of the following CF templates that will be included in this page:
		redirect_additional_failed.cfm - additional code to be processed if user's authentication fails
		redirect_additional_passed.cfm - additional code to be processed if user's authentication passes
--->  



<cfinclude template="#APP_authDirectory#/login_redirect.cfm">
