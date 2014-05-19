function validateFieldForQTip(objectId, objectName, validationType, errorMsg, islogin) {
	var errorHtml = '<img src="themes/blue/images/error.png" align="middle" />';
	if (!islogin) {
		errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
	}
	var fieldValue;
	var isValid = false;
	var style;
	var lengthRequirements;
	var showIcon = 'inline';
	if (validationType.match("^length")) {
		lengthRequirements = validationType;
		validationType = "length";
	}
	if (document.getElementById(objectId) == null) {
		isValid = false;
		style = 'blue';
		errorMsg = 'Property '+objectName+'Does not exist';
	} else {
		fieldValue = getFieldValue(objectId);
		if(fieldValue != '') {
			isValid = true;
			errorHtml  = '';
			showIcon = 'none';
		} else {
		   	isValid = false;
			style = 'blue';
			showIcon = 'inline';
			errorMsg = 'Please enter '+objectName;
		}
	}
	nextField = $("#" + objectId).next();
	if (isValid) {
		switch (validationType){
			case 'digits':
				if (isDigits(fieldValue)) {
					isValid = true;
					showIcon = 'none';
				} else {
					isValid = false;
					errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
					showIcon = 'inline';
					style = 'blue';
					errorMsg = objectName +' should contain only numerics.';
				}
			break;
			case 'specialCharacters':
				if (checkSpecialCharacters(fieldValue)) {
					isValid = true;
					showIcon = 'none';
				} else {
					isValid = false;
					errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
					showIcon = 'inline';
					style = 'blue';
					errorMsg = objectName +' should not contain any special characters.';
				}
			break;
			case "length":
				comparison_rule = "";
				rule_string = "";
				if (fieldValue != '') {
					if (lengthRequirements.match(/length=/)) {
						comparison_rule = "equal";
						rule_string = lengthRequirements.replace("length=", "");
					} else if (lengthRequirements.match(/length>=/)) {
						comparison_rule = "greater_than_or_equal";
						rule_string = lengthRequirements
								.replace("length>=", "");
					} else if (lengthRequirements.match(/length>/)) {
						comparison_rule = "greater_than";
						rule_string = lengthRequirements.replace("length>", "");
					} else if (lengthRequirements.match(/length<=/)) {
						comparison_rule = "less_than_or_equal";
						rule_string = lengthRequirements
								.replace("length<=", "");
					} else if (lengthRequirements.match(/length</)) {
						comparison_rule = "less_than";
						rule_string = lengthRequirements.replace("length<", "");
					}
					switch (comparison_rule) {
					case "greater_than_or_equal":
						if (!(fieldValue.length >= parseInt(rule_string))) {
							isValid = false;
							style = 'blue';
							errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
							showIcon = 'inline';
						} else {
							isValid = true;
							showIcon = 'none';
						}
						break;
					case "greater_than":
						if (!(fieldValue.length > parseInt(rule_string))) {
							isValid = false;
							style = 'blue';
							errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
							showIcon = 'inline';
						} else {
							isValid = true;
							showIcon = 'none';
						}
						break;
					case "less_than_or_equal":
						if (!(fieldValue.length <= parseInt(rule_string))) {
							isValid = false;
							style = 'blue';
							errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
							showIcon = 'inline';
						} else {
							isValid = true;
							showIcon = 'none';
						}
						break;
					case "less_than":
						if (!(fieldValue.length < parseInt(rule_string))) {
							isValid = false;
							style = 'blue';
							errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
							showIcon = 'inline';
						} else {
							isValid = true;
							showIcon = 'none';
						}
						break;
					case "equal":
						var range_or_exact_number = rule_string.match(/[^_]+/);
						var fieldCount = range_or_exact_number[0].split("-");
						if (fieldCount.length == 2) {
							if (fieldValue.length < fieldCount[0]
									|| fieldValue.length > fieldCount[1]) {
								isValid = false;
								style = 'blue';
								errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
								showIcon = 'inline';
							} else {
								isValid = true;
								showIcon = 'none';
							}
						} else {
							if (fieldValue.length != fieldCount[0]) {
								isValid = false;
								style = 'blue';
								errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
								showIcon = 'inline';
							} else {
								isValid = true;
								showIcon = 'none';
							}
						}
						break;
					}
				}
				break;
				
			case 'showQtip':
					isValid = false;
					style = 'blue';					
					errorMsg = errorMsg;
					errorHtml = '<img src="../themes/blue/images/error.png" align="middle" />';
					showIcon = 'inline';
			break;

			default:
			}
	}
	document.getElementById(nextField.attr("id")).innerHTML = errorHtml;
	document.getElementById(nextField.attr("id")).style.display = showIcon;	
	if (!isValid) {
		if (typeof $("#" + objectId).data("qtip") == "object") {
			$("#" + objectId).qtip("destroy");
		}
		$("#" + objectId).qtip({
			content : errorMsg,
			style : style
		});
	} else {
		if (typeof $("#" + objectId).data("qtip") == "object") {
			$("#" + objectId).qtip("destroy");
		}
	}
	return isValid;
}

function getFieldValue(objectId) {
	return document.getElementById(objectId).value;
}

function isDigits(fieldValue) {
	var RE = /^-{0,1}\d*\.{0,1}\d+$/;
	return RE.test(fieldValue);
}

function checkSpecialCharacters(fieldValue) {
	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	for (var i = 0; i < fieldValue.length; i++) {	
		if(iChars.indexOf(fieldValue.charAt(i)) != -1) {			
			return false;		
		}
	}
	return true;
}
function isLetters(fieldValue) {
	if (fieldValue.match(/[^a-zA-Z]/)){
		return true;
	}
	return false;
}
function isLettersAndSpace(fieldValue) {
	if (fieldValue.match(/[^a-zA-Z ]/)){
		return true;
	}
	return false;
}
function isAlpha(fieldValue) {
	if (fieldValue.match(/\W/)){
		return true;
	}
	return false;
}
function isValidEmail(str) {
	var s = $.trim(str);
	var at = "@";
	var dot = ".";
	var lat = s.indexOf(at);
	var lstr = s.length;
	var ldot = s.indexOf(dot);
	if (s.indexOf(at) == -1
			|| (s.indexOf(at) == -1 || s.indexOf(at) == 0 || s.indexOf(at) == lstr)
			|| (s.indexOf(dot) == -1 || s.indexOf(dot) == 0 || s
					.indexOf(dot) == lstr)
			|| (s.indexOf(at, (lat + 1)) != -1)
			|| (s.substring(lat - 1, lat) == dot || s.substring(lat + 1,
					lat + 2) == dot) || (s.indexOf(dot, (lat + 2)) == -1)
			|| (s.indexOf(" ") != -1)) {
		return false;
	}
	return true;
}
function isValidDate(month, day, year, isLaterDate) {
	var daysInMonth;
	if ((year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0)))
		daysInMonth = [ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
	else
		daysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
	if (!month || !day || !year)
		return false;
	if (1 > month || month > 12)
		return false;
	if (year < 0)
		return false;
	if (1 > day || day > daysInMonth[month - 1])
		return false;
	if (isLaterDate) {
		var today = new Date();
		var currMonth = today.getMonth() + 1;
		var currDay = today.getDate();
		var currYear = today.getFullYear();
		if (String(currMonth).length == 1)
			currMonth = "0" + currMonth;
		if (String(currDay).length == 1)
			currDay = "0" + currDay;
		var currDate = String(currYear) + String(currMonth)
				+ String(currDay);
		if (String(month).length == 1)
			month = "0" + month;
		if (String(day).length == 1)
			day = "0" + day;
		incomingDate = String(year) + String(month) + String(day);
		if (Number(currDate) > Number(incomingDate))
			return false;
	}
	return true;
}
