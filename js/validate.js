function isEmailAddr(email)
{
  var result = false;
  var theStr = new String(email);
  var index = theStr.indexOf("@");
  if (index > 0)
  {
    var pindex = theStr.indexOf(".",index);
    if ((pindex > index+1) && (theStr.length > pindex+1))
	result = true;
  }
  return result;
}

function validRequired(formField,fieldLabel)
{

	var result = true;
	
	if (formField.value == "")
	{
		alert('Please provide a value for the "' + fieldLabel +'" field.');
		formField.focus();
		result = false;
	}
	
	return result;
}

function allDigits(str)
{
	return inValidCharSet(str,"0123456789.");
}

function inValidCharSet(str,charset)
{
	var result = true;

	// Note: doesn't use regular expressions to avoid early Mac browser bugs	
	for (var i=0;i<str.length;i++)
		if (charset.indexOf(str.substr(i,1))<0)
		{
			result = false;
			break;
		}
	
	return result;
}

function validEmail(formField,fieldLabel,required)
{
	var result = true;
	
	if (required && !validRequired(formField,fieldLabel))
		result = false;

	if (result && formField.value != "" && ((formField.value.length < 3) || !isEmailAddr(formField.value)) )
	{
		alert("Please enter a complete email address: e.g. yourname@yourdomain.com");
		formField.focus();
		result = false;
	}
   
  return result;

}

function processPSID(IDstring)
{
	var doneParsing = 0;	
	while (!doneParsing)
	{
		if (IDstring.value.charAt(0) == "0")
			IDstring.value = IDstring.value.substring(1,IDstring.value.length);
		else
			doneParsing = 1;
	}
	
	if (IDstring.value.charAt(0) == "1" || IDstring.value.charAt(0) == "2")
		IDstring.value = "00" + IDstring.value;
	else
		IDstring.value = "0" + IDstring.value;
	
	return IDstring;				
}

function validPSID(IDstring)
{
	if (IDstring.value.length < 6 || IDstring.value.length > 8)
		return false;		
	else
		return true;
}


function validNum(formField,fieldLabel,required)
{
	var result = true;
	numStr = new String(formField.value);

	if (required && !validRequired(formField,fieldLabel))
		result = false;
	
	//if (numStr.indexOf(".") != numStr.lastIndexOf("."))
		//result = false;
  
 	if (result && formField.value != "")
 	{
 		if (!allDigits(formField.value) || (numStr.indexOf(".") != numStr.lastIndexOf(".")))
 		{
 			alert('Please enter a valid number for the "' + fieldLabel +'" field.');
			formField.focus();		
			result = false;
		}
	} 
	
	return result;
}


function validInt(formField,fieldLabel,required)
{
	var result = true;

	if (required && !validRequired(formField,fieldLabel))
		result = false;
  
 	if (result && formField.value != "")
 	{
 		var num = parseInt(formField.value);
 		if (isNaN(num))
 		{
 			alert('Please enter a valid number for the "' + fieldLabel +'" field.');
			formField.focus();		
			result = false;
		}
	} 
	
	return result;
}


function validDate(formField,fieldLabel,required)
{
	var result = true;

	if (required && !validRequired(formField,fieldLabel))
		result = false;
  
 	if (result)
 	{
 		var elems = formField.value.split("/");
 		
 		result = (elems.length == 3); // should be three components
 //alert('the ' + fieldLabel +' result is: ' + result);		
 		if (result)
 		{
 			var month = parseInt(elems[0]);
  			var day = parseInt(elems[1]);
 			var year = parseInt(elems[2]);
			
			//alert(month+' ('+ elems[0]+') '+day+' ('+ elems[1]+') '+' '+year+' ('+ elems[2]+')');
			
			/*
			arg1 = allDigits(elems[0]);
			arg2 = (month > 0);
			arg3 = (month < 13);
			arg4 = allDigits(elems[1]);
			arg5 = (day > 0);
			arg6 = (day < 32);
			arg7 = allDigits(elems[2]);
			arg8 = (elems[2].length == 2);
			arg9 = (elems[2].length == 4);
			alert(arg1+' '+arg2+' '+arg3+' '+arg4+' '+arg5+' '+arg6+' '+arg7+' '+arg8+' '+arg9);
			*/
			
			result = allDigits(elems[0]) && (month > 0) && (month < 13) &&
					 allDigits(elems[1]) && (day > 0) && (day < 32) &&
					 //allDigits(elems[2]) && ((year >= 0 && year <= 99)  || (year > 2000 && year < 3000));
					 allDigits(elems[2]) && ((elems[2].length == 2) || (elems[2].length == 4));
 //alert('the inside if value of' + fieldLabel +' is: ' + result);		
		}
 		
  		if (!result)
  		//else
 		{
 			alert('Please enter a date in the format MM/DD/YYYY for the "' + fieldLabel +'" field.');
			formField.focus();		
		}
	} 
	//alert('the final' + fieldLabel +' result is: ' + result);
	return result;
}

function daysDifference(laterdate,earlierdate) 
{
	var difference = laterdate.getTime() - earlierdate.getTime();

	var daysDifference = Math.floor(difference/1000/60/60/24);
	difference -= daysDifference*1000*60*60*24
	var hoursDifference = Math.floor(difference/1000/60/60);
	difference -= hoursDifference*1000*60*60
	var minutesDifference = Math.floor(difference/1000/60);
	difference -= minutesDifference*1000*60
	var secondsDifference = Math.floor(difference/1000);

	return daysDifference;
}

function timeCompareOK(fHour, fMin, sHour, sMin) 
{
	if (fHour > sHour)
	{
		var result = false;
	}
	else if (fHour < sHour)
	{
		var result = true;
	}
	else
	{
		if (fMin >= sMin)
			var result = false;
		else
			var result = true;
	}
	
	return result;
}

function compareTwoValidDates(firstDate, secondDate)
{		
	var elems1 = firstDate.split("/");
	var elems2 = secondDate.split("/");
	
	result = (elems1.length == 3); // should be three components

	if (result)
	{
		var month1 = parseInt(elems1[0]);
		var day1 = parseInt(elems1[1]);
		var year1 = parseInt(elems1[2]);
	}
	else
		alert('Error with first date!');

	result = (elems2.length == 3); // should be three components

	if (result)
	{
		var month2 = parseInt(elems2[0]);
		var day2 = parseInt(elems2[1]);
		var year2 = parseInt(elems2[2]);
	}
	else
		alert('Error with second date!');

	var laterdate = new Date(year2,month2,day2);     
	var earlierdate = new Date(year1,month1,day1);  
	
	return daysDifference(laterdate,earlierdate);
	
}


