$(document).ready(function(){
	
	// For Grid Rows
	/*$(".grid_table tr:even").css("background-color","#F5F5F5");*/
	
	// For Samples in Grid
	$('#show_samp').bind('click', function() {
	  $("#samp_list").toggleClass('hide_samp');
	});
	
	
	// For Projects in Grid
	$('#show_proj').bind('click', function() {
	  $("#proj_list").toggleClass('hide_proj');
	});
	
	
	// For Advanced Search Dropdown
	$('#adv_search').bind('click', function() {
		$(this).toggleClass('show_adv_btn');
		$("#adv_form").toggleClass('hide_adv_form');
	});
	
	
	// For Advanced Search Form Submission
	$('#adv_search_form').submit(function() {
		$("#adv_form").addClass('hide_adv_form');
		$("#adv_search").removeClass('show_adv_btn');
	});
	
	
	/*$(".download_now").tooltip({ 
							   effect: 'fade'
							   });*/
	
});

function myOnComplete()
{
   return true;
}

function toggleSelection(obj, isChecked) {
    allObjects = document.getElementsByName(obj + '[]');
    for (i = 0; i < allObjects.length; ++i) {
    	if (allObjects[i].disabled == false) {
    		allObjects[i].checked = isChecked;
    	}
    }
}

function popUp(url, parm, width) {
	var arg = "";
	if (parm != '') {
		arg = parm + "&amp;";
	}
	if (width == '') {
		width = 750;
	}
    tb_show("Result - Comments",url + "?" + arg + "&keepThis=true&amp;TB_iframe=true&amp;height=400&amp;width=" + width + "", null);
}

function checkSpecialCharacters(fields) {
	var iChars = "!@#$%^&*()+=-[]\\\';,./{}|\":<>?";
	for (var i = 0; i < fields.length; i++) {			
		if(iChars.indexOf(fields.charAt(i)) != -1) {			
			return true;		
		}
	}
	return true;
}