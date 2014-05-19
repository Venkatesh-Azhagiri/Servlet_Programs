<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageTitle = "LIMS | Project Details";
	String searchPage = "search_projects.html";
	String pageType = "main";
	boolean hasGrid = false;
	String projid = request.getParameter("projectId");
	String projname = request.getParameter("projectName");
%>
<%@include file="../include/header.jspi" %>
<c:set var="userRole" value="${sessionScope['userRole']}"></c:set>
<c:set var="userName" value="${sessionScope['userName']}"></c:set>
<script type="text/javascript" src="<%= basePath %>js/jquery/jquery.tablesorter.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	//	var isReviewer = "${isNxgReviewer}";
		var userRole = "${sessionScope['userRole']}";
	//    if (isReviewer == 'true' && userRole != '1'){
	    	//var editList = document.getElementById('edit');
	    	//editList.innerHTML = "<strong title='Not Authorized' class='thickbox edit'>Edit Summary</strong>";
	    	//var copyProjectList = document.getElementById('copy');
	    	//copyProjectList.innerHTML = "<strong title='Not Authorized' class='copy_lib thickbox nrmlink'>Copy Project</strong>";
	    	//var uplaodFiles = document.getElementById("uplaodFiles");
	    	//uplaodFiles.innerHTML = "<strong title='Not Authorized' class='thickbox upload-proj'>Upload Files</strong>";
	    	//var addCommentList = document.getElementById("AddCommentLink");
	    	//addCommentList.innerHTML = "<strong title='Not Authorized' class='thickbox comment'>Add Comments</strong>";
	    	//$("#edit").remove();
	    	///$("#copy").remove();
	    	//$("#edit").removeAttr("href");
	    	//$('#edit').attr('title', 'Not Authorized');
	    	//$('#edit').attr('disabled', true);
	    	//$("#copy").removeAttr("href");
	    	//$('#copy').attr('title', 'Not Authorized');
	   // }
	    var errMsg = "${project.error}";
	    var successMsg = $("#successMsg").val();
		if (errMsg.length != 0) {
			$("#rsvErrors").css("display", "block");
		    $("#rsvErrors").html("${project.error}");
		    window.scrollTo($("#rsvErrors").offset().left, $("#rsvErrors").offset().top);
		}
    	if (successMsg.length != 0) {
    		$("#success").css("display", "block");
    	    $("#success").html(successMsg);
    	    $("#success").fadeOut(5000);
    	} else if('${message}'.length != 0) {
    		$("#success").css("display", "block");
    	    $("#success").html('${message}');
    	    $("#success").fadeOut(5000);
    	}
    	$("#successMsg").val("");    	
    	<c:if test ="${not empty commentsList}">
	    	$("#comments_table tr").removeClass("odd");
			$("#comments_table").tablesorter( {
				sortList: [[3,1]] 
			}).bind("sortEnd",function() {
		    	$('#track_body tr:nth-child(even)').removeClass("odd");
		    	$('#track_body tr:nth-child(even) td').removeClass("odd");
			    $('#track_body tr:nth-child(odd)').addClass("odd");
		    });
		</c:if>
		
		$('.adCntnr div.acco2:eq(0)').find('div.report:eq(0)').addClass('openAd').end()
	    .find('div.collapse:gt(0)').hide().end()
	    .find('div.report').click(function() {	    	
	        $(this).toggleClass('openAd').siblings().removeClass('openAd').end()
	        .next('div.collapse').slideToggle().siblings('div.collapse:visible').slideUp();
	        return false;
	    });
				
	});
	 function stickyTip() {
		  $("#cluetip").css("width", "270px");
		  $("#cluetip-outer").css("width", "290px");
		  $("#cluetip-title").css("width", "270px");
		  $("#cluetip-inner").css("width", "270px");
	  }
	function displayError(status) {
		$("#rsvErrors").css("display", "block");
		if (status == 3)
			$("#rsvErrors").html("Project has been Denied");
		if (status == 4 || status == 1)
			$("#rsvErrors").html("Project is not yet Approved");
		if (status == 12)
			$("#rsvErrors").html("Project is on hold");
		if (status == 13)
			$("#rsvErrors").html("Project has been dropped");
		if (status == 14) {
			$("#rsvErrors").css("display", "none");
			alert("Please change the status to proceed");
		}
	}
	
	function removeSummaryFile() {
		document.delete_summary.submit();
	}
	
	function confirmAction(action) {
		var answer = false;
		if (action.toLowerCase() == 'email') {
			answer = confirm("Are you sure you want to send the email?");
			document.project_details.action = "reminder_mail.do";
		} else if (action.toLowerCase() == 'delete') {
			answer = confirm("Are you sure you want to delete this project?");
			document.project_details.action = "delete_project.do";
		} else {
			answer = confirm("Are you sure you want to reopen this project?");
			document.project_details.action = "reopen_project.do";
		}
		if (answer) {
			document.project_details.submit();
		} 
	}
	function getSampleBatch(batchNo, projectId){
		//alert("batchNo**"+batchNo);
		//alert("projectId**"+projectId);
		if(batchNo !=''){
			var resp = $.ajax({url: 'project_tracking.do?projectId=' + projectId+'&batchNo='+batchNo,async: false,success: function(data, result) {if (!result)alert('Failure to recieve.');}}).responseText;
			//alert("resp***"+resp);
			if(resp != ''){
				var progress = resp.split(":");		
				var batchNoAndStatus  = progress[0].split("#");
		
				$("#sampleProgress").html("");			
				$("#libraryProgress").html("");
				$("#runProgress").html("");		
				if(batchNoAndStatus[1] == 'Approved'){
					$("#sampleProgress").html("<div class='meter-wrap' style ='padding:0px;width: 66px;'><div class='meter-value' style ='height:5px; width: 127%;'><div class='meter-text'><span>100%</span></div></div></div>");
				}else{
					$("#sampleProgress").html("<div class='meter-wrap' style ='padding:0px;width: 63px;'><div class='meter-value' style ='height:5px; width:0%;'><div class='meter-text'><span>0%</span></div></div></div>");
				}
				//alert("progress 1***"+progress[1]);
				//$("#sampleProgress").html("<span>Status:"+batchNoAndStatus[1]+"</span>");
				if(progress[1] >0){
					$("#libraryProgress").html("<div class='meter-wrap' style ='padding:0px;width: 270px;'>"+
				    "<div class='meter-value' style ='height:5px;  width: "+progress[1]+"%;<div class='meter-text'><span>"+ progress[1]+"%</span></div></div></div>");
					//$("#libraryProgress").html("<div class='Green_Progress_Bar' id  = 'libraryProgress'><div class='percent'  id  = ''><span style='width: 0%;'></span></div>	<span style = 'margin-left:20px;'>"+progress[1]+"%</span></div>");
				}else{
					$("#libraryProgress").html("<div class='meter-wrap' style ='padding:0px;width: 270px;'>"+
						    "<div class='meter-value' style ='height:5px;  width:0%;<div class='meter-text'><span>0%</span></div></div></div>");
				}
				if(progress[2] > 0){
					//$("#runProgress").html("<div class='Green_Progress_Bar' id  = 'runProgress'><div class='percent'  id  = ''><span style='width: 0%;'></span></div>	<span style = 'margin-left:20px;'>"+progress[2]+"%</span></div>");
					$("#runProgress").html("<div class='meter-wrap' style ='padding:0px;width: 270px;'>"+
						    "<div class='meter-value' style ='height:5px;  width: "+progress[2]+"%;<div class='meter-text'><span>"+ progress[2]+"%</span></div></div></div>");
				}else{
					$("#runProgress").html("<div class='meter-wrap' style ='padding:0px;width: 270px;'>"+
						    "<div class='meter-value' style ='height:5px;  width: 0%;<div class='meter-text'><span>0%</span></div></div></div>");
				}
				var sampleApproversResp  = $.ajax({url: 'sample_batch_approvers_report.do?projectId=' + projectId+'&batchNo='+batchNo,async: false,success: function(data, result) {if (!result)alert('Failure to recieve.');}}).responseText;
				
				if(sampleApproversResp!=''){
					//alert("data**"+sampleApproversResp);
					$("#projectReport").html("");
					$("#projectReport").html(sampleApproversResp) ;
				}
		}
	}
}
</script>
<div class="content" id="projects">
<h3 class="title" title="${project.projectName}"><span>Project: ${project.projectName} (ID: ${project.projectId}) </span></h3>
<div class="errorField" id="rsvErrors"></div>
<input type="hidden" name="successMsg" id="successMsg"></input> 
<c:if test="${isExist}">	
	<div class="common">
		<div class="tab_bar">
			<ul id="freedom" class="idTabs">
				<!--<c:choose>
					<c:when test="${project.status != 1 && project.status != 3 && ((project.status == 4 && (project.sampleCount > 0 || project.libraryCount > 0)) || project.status != 4)}">						
						<li><a class="selected" href="project_details.do?projectId=${project.projectId}">Summary</a></li>
						<li><a href="samples_list.do?projectId=${project.projectId}&projectName=${project.projectName}">Samples</a></li>
						<c:choose>
							<c:when test="${project.sampleCount > 0}">
								<li><a href="library/projectLibraries.do?projectId=${project.projectId}&projectName=${project.projectName}">Libraries</a></li>
								<li><a href="library/lib_preparation.do?projectId=${project.projectId}">Lib Preparation</a></li>
							</c:when>
							<c:otherwise>
								<li><a style="color: #ccc;" title="No Libraries">Libraries</a></li>
								<li><a style="color: #ccc;" title="Not available as the previous process is not yet completed">Lib Preparation</a></li>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${project.libraryCount > 0}">
								<li><a href="kapa/kapa.do?projectId=${project.projectId}&projectName=${project.projectName}">KAPA</a></li>
								<li><a href="kapa/kapa_multiplex.do?projectId=${project.projectId}&projectName=${project.projectName}">Multiplex</a></li>																
								<li><a href="run.do?projectId=${project.projectId}&projectName=${project.projectName}&flag=init">cBot &amp; Sequencer</a></li>
								<li><a href="run_info.do?projectId=${project.projectId}&projectName=${project.projectName}">Runs</a></li>
							</c:when>
							<c:otherwise>
								<li><a style="color: #ccc;" title="Not available as the previous process is not yet completed">KAPA</a></li>
								<li><a style="color: #ccc;" title="Not available as the previous process is not yet completed">Multiplex</a></li>																
								<li><a style="color: #ccc;" title="Not available as the previous process is not yet completed">cBot &amp; Sequencer</a></li>
								<li><a style="color: #ccc;" title="Not available as the previous process is not yet completed">Runs</a></li>
							</c:otherwise>
						</c:choose>
						<li>
							<c:choose>
								<c:when test="${project.runCount > 0}">
									<a href="qc.do?projectId=${project.projectId}&projectName=${project.projectName}">QC</a>
								</c:when>
								<c:otherwise>
									<a style="color: #ccc;" title="Not available as the previous process is not yet completed">QC</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:when>
					<c:otherwise>
						<li><a class="selected" href = "project_details.do?projectId=${project.projectId}">Summary</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">Samples</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">Libraries</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">Lib Preparation</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">KAPA</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">cBot &amp; Sequencer</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">Runs</a></li>
						<li><a href="#" onclick="return displayError('${project.status}')" style="color: #ccc;">QC</a></li>
					</c:otherwise>
				</c:choose>
			-->			
				<li><a class="selected" href="project_details.do?projectId=${project.projectId}">Summary</a></li>
				<li><a href="samples_list.do?projectId=${project.projectId}&projectName=${project.projectName}">Samples</a></li>
				<li><a href="library/projectLibraries.do?projectId=${project.projectId}&projectName=${project.projectName}">Libraries</a></li>
				<li><a href="library/lib_preparation.do?projectId=${project.projectId}">Lib Preparation</a></li>
				<li><a href="kapa/kapa.do?projectId=${project.projectId}&projectName=${project.projectName}">KAPA</a></li>
				<li><a href="kapa/kapa_multiplex.do?projectId=${project.projectId}&projectName=${project.projectName}">Multiplex</a></li>																
				<li><a href="run.do?projectId=${project.projectId}&projectName=${project.projectName}&flag=init">cBot &amp; Sequencer</a></li>
				<li><a href="run_info.do?projectId=${project.projectId}&projectName=${project.projectName}">Runs</a></li>
				<!-- <li><a href="qc.do?projectId=${project.projectId}&projectName=${project.projectName}">QC</a></li> -->						
				<li><a href="results/results.do?projectId=${project.projectId}&projectName=${project.projectName}">Results</a></li>
			</ul>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
		<div id="summary">
		  	<span class="toolbar">
				<span class="fsize lft pad-adj4">
					<ul style="border:none; width:auto;">
						<c:choose>
							<c:when test="${projectRoleTaskAccess.editAccess}" >
									<!-- <li class="icon first" title="Edit Project Summary"><a href="edit_project.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox edit">Edit Summary</a></li> -->
									 <li id = "edit" class="icon first" title="Edit Project Summary"><a href="edit_project.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox edit">Edit Summary</a></li>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${project.status == 11 && projectRoleTaskAccess.editAccess}">
										<li class="icon first"><strong title="This project is closed and hence this feature is inactive" class="thickbox edit">Edit Summary</strong></li>
									</c:when>
									<c:otherwise>
										<li class="icon first"><strong title="Rights not available for this feature" class="thickbox edit">Edit Summary</strong></li>
									</c:otherwise>	
								</c:choose>	
							</c:otherwise>
						</c:choose>
						<c:if test="${projectRoleTaskAccess.deleteAccess}">
							<li class="icon"><a href='#' onclick="confirmAction('delete')" title="Delete Project" class="delete">Delete</a></li>
						</c:if>
						<c:if test="${projectRoleTaskAccess.approveAndDenyAccess}">
								<li class="icon" title="Approve"><a href="approve_project.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox approve">Approve</a></li>
								<li class="icon" title="Deny"><a href="deny_project.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox deny">Deny</a></li>
						</c:if>
						<c:if test="${projectRoleTaskAccess.approveAndDenyImmediateUserAccess}">
							<li class="icon" title="Approve"><a href="approve_project_others.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox approve">Approve</a></li>
							<li class="icon" title="Deny"><a href="deny_project_others.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox deny">Deny</a></li>
						</c:if>
						
						<c:if test="${projectRoleTaskAccess.remindApproval}">
							<li class="icon"><a href="#" onclick="confirmAction('email')" class="email_icon" title="Notify Approvers">Remind Approval</a></li>
						</c:if>			
						
						<c:if test = "${projectRoleTaskAccess.manageApprovers}">	                		
                			<li title="Manage Approvers" class="icon"><a href="approval_history.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox approvehistory">Manage Approvers</a></li>
               			</c:if>							
						<c:if test="${projectRoleTaskAccess.approvalHistory}">
	                		<li title="Approval History" class="icon"><a href="approval_history.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox approvehistory">Approval History</a></li>
                		</c:if>
                		<c:if test="${projectRoleTaskAccess.statusHistory}">
	                		<li title="Status History" class="icon"><a href="status_history.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox statushistory">Status History</a></li>
	                	</c:if>
					   <c:if test="${projectRoleTaskAccess.uploadSummaryFile}">
					  		<li class="icon" title="Upload Project Summary File"><a href="add_summary_file.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="thickbox upload-proj">Upload Summary File</a></li>
						</c:if>						
						<c:if test="${projectRoleTaskAccess.reOpenProjectAccess}">
							<li class="icon" title="Reopen Project"><a href="reopen_project.do?projectId=${project.projectId}&projectName=${project.projectName}&amp;placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600&amp;modal=true" title="Import" class="thickbox edit">Reopen Project</a></li>
						</c:if>
						<c:if test="${projectRoleTaskAccess.copyAccess}">
							<li id = "copy" class="icon" ><a href="copy_project.do?projectId=${project.projectId}&projectName=${project.projectName}&description=${project.description}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="" class="copy_lib thickbox nrmlink">Copy Project</a></li>
						</c:if>
					</ul>
				</span>
			</span><br class="clear" />
			<div class="errorField" id="rsvErrors"></div>
			<div class="successField" id="success"></div>
            <input type="hidden" name="projectId" value="${project.projectId}"/>
			<form name="project_details" id="project_details" action="" method="post">
				<input type="hidden" name="projectId" id="projectId" value="${project.projectId}"></input>
				<input type="hidden" name="projectName" id="projectName" value="${project.projectName}"></input>
			</form>
			<ul class="details">
				<li>
					<label for="pr_name">Project Name</label> 
					<span id="pr_name"><c:out value="${project.projectName}" /></span>
				</li>
				<li>
					<label for="pr_owner">Project Owner</label> 
					<span id="pr_owner"><c:out value="${project.projectOwner}" /></span>
				</li>
				<li>
					<label for="pr_project_type">Project Type</label>
					<c:choose>
						<c:when test="${not empty project.subProjectType}">
							<span id="pr_project_type">
								<c:out value="${project.projectType}" />
								<c:out value="(" />
								<c:out value="${project.subProjectType}" />
								<c:out value=")" />
							</span>
						</c:when>
						<c:otherwise>
							<span id="pr_project_type"><c:out value="${project.projectType}" /></span>
						</c:otherwise>
					</c:choose> 
					
				</li>
				<li>
					<label for="pr_spec">Species</label> 
					<span id="pr_spec"><c:out value="${project.species}" /></span>
				</li>
				<li>
					<label for="pr_seq">Sequencing Type</label> 
					<span id="pr_seq">
						<c:choose>
	                		<c:when test="${project.sequencingType != null}" >
		                		<c:out value="${project.sequencingType}" />
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
             	</li>
				<li>
					<label for="pr_base">Base Pairs (Cycles)</label> 
					<span id="pr_base">
						<c:choose>
	                		<c:when test="${project.basePairsCycles != null && project.basePairsCycles != 0}" >
		                		<c:out value="${project.basePairsCycles} bp" />
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
            	</li>
            	<li>
            		<label for="pr_total_reads">Total Number of Reads</label> 
					<span id="pr_total_reads">					
						<c:choose>
	                		<c:when test="${not empty project.totalReads && project.totalReads != 'null'}" >
		                		<c:out value="${project.totalReads}" />
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
            	</li>
            	<c:choose>				
	            	<c:when test ="${project.libraryType!='' &&project.libraryType!=null}">
						<li>
							<label for="pr_lib_type">Sample Type</label> 
							<span id="pr_lib_type"><c:out value="${project.libraryType}" /></span>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<label for="pr_lib_type">Sample Type</label>
							<i>-- No values --</i>
						</li>					
					</c:otherwise>
				</c:choose>
				<c:choose>				
					<c:when test ="${project.bioAnalyzerFileName!='' &&project.bioAnalyzerFileName!=null}">										
						<li>
							<label for="pr_base">Bio-Analyzer File</label>
							<a href="bioAnalyzerFileDownload.do?bioAnalyzerFile=${project.bioAnalyzerFile}" id="" ><c:out value="${project.bioAnalyzerFileName}" /></a>
						</li>
					</c:when>
					<c:otherwise>
						<li>						
							<label for="pr_base">Bio-Analyzer File</label>
							<i>-- No file --</i>
						</li>
					</c:otherwise>					
				</c:choose>
				<li>
					<label for="pr_no">Are you submitting a prepared library?</label> 
					<c:if test="${project.submittingLibrary == 'N'}">
						<span id="pr_no">No</span>
					</c:if>
					<c:if test="${project.submittingLibrary == 'Y'}">
						<span id="pr_no">Yes</span>
					</c:if>
				</li>
				<li>
					<label for="pr_no">Need Bio-informatics?</label> 
					<c:if test="${project.bioanalyzerRun == 'N'}">
						<span id="pr_no">No</span>
					</c:if>
					<c:if test="${project.bioanalyzerRun == 'Y'}">
						<span id="pr_no">Yes</span>
					</c:if>
				</li>
				<c:set var="projSize" value="${fn:length(projIdList)}"></c:set>
				<c:if test="${projSize > 0 }">
					<li>
						<label for="child_project">Child Project</label>
						<c:forEach items="${projIdList}" var="projId" varStatus="status"> 
						<a href="project_details.do?projectId=${projId.projectId}" style="text-decoration:none" title="Click to view the child project details of ${projId.projectId}. " ><c:out value="${projId.projectName} (ID:${projId.projectId})"/><c:if test="${projSize != status.count}"><c:out value=","/></c:if>&nbsp;</a></c:forEach>
					</li>
				</c:if>
				<!--<c:set var="runSize" value="${fn:length(runList)}"></c:set>
				<li>
					<label for="pr_files">Runs</label>
					<c:forEach items="${runList}" var="run" varStatus="status"> 
					<a href="run.do?projectId=${project.projectId}&projectName=${project.projectName}&runId=${run.runId}" style=text-decoration:none title="Click to view the run details of R${run.runId }" ><c:out value="R${run.runId}"/><c:if test="${runSize != status.count}"><c:out value=","/></c:if>&nbsp;</a></c:forEach>
				</li>-->
			</ul>
			 <ul class="details">
			 	<li>
					<label for="pr_status">Status</label> 
					<span id="pr_status"><c:out value="${project.statusName}" /><c:if test="${project.status == 4}"><c:out value=" (${nextApprover})" /></c:if></span>
				</li>
			 	<li>
					<label for="pr_samples">Max. No. of Samples</label> 
					<span id="pr_samples" class="lft"><c:out value="${project.maxNoOfSamples}" /></span>
					<c:if test="${sampleBatchStatus >=1}">
						<div class="note lft" style="position:absolute; margin-left:212px; margin-top:-10px;">(Few batches are still waiting for approval)</div>
					</c:if>					
				</li>
				<li>
					<label for="pr_samples">Available Samples</label> 
					<span id="pr_samples"><c:out value="${project.sampleCount}" /></span>
				</li>
				<li>
					<label for="pr_libs">Available Libraries </label> 
					<span id="pr_libs"><c:out value="${project.libraryCount}" /></span>
				</li>				
				<c:if test="${projectRoleTaskAccess.uploadSummaryFile}">
					<li>						
						<form name="delete_summary" id="delete_summary" action="delete_summary_file.do" method="post">
							<label for="pr_summary">Summary File </label> 
							<span id="pr_summary"><a href="view_summary_file.do?summaryFileNo=${project.summaryFileNo}"  id="" ><c:out value="${project.summaryFileName}" /></a>
							<a href="add_summary_file.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" class="thickbox pad-adj"><img src="<%= basePath %>img/change_icon.png" align="absmiddle" title="Change Summary File"/></a>
							<input type="hidden" name="projectId" id="projectId" value="${project.projectId}"></input>
							<a href="javascript: removeSummaryFile();" href="" title="Remove Summary File" class="pad-adj"><img src="<%= basePath %>img/remove_icon.gif" align="absmiddle" /></a></span>
						</form>
					</li>
				</c:if>
				<li>
					<label for="pr_request">Created By</label> 
					<span id="pr_request"><c:out value="${project.createdBy}" /></span>
				</li>
				<li>
					<label for="pr_req_on">Created On</label> 
					<span id="pr_req_on"><c:out value="${project.createdOnString}" /></span>
				</li>
				<li>
					<label for="pr_update_by">Last Updated By</label> 
					<span id="pr_update_by"><c:out value="${project.modifiedBy}" /></span>
				</li>
				<li>
					<label for="pr_update_on">Last Updated On</label> 
					<span id="pr_update_on"><c:out value="${project.modifiedOnString}" /></span>
				</li>
				<li>
					<label for="primary_analysis">Primary Analysis Contact</label> 
					<span id="primary_analysis">
						<c:choose>
	                		<c:when test="${project.deligate != null}" >
		                		<c:out value="${project.deligate}" />
		                		<c:if test="${sessionScope['userName'] == project.primaryAnalysisContact}">
		                			<a href="add_deligate.do?projectId=${project.projectId}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" class="thickbox pad-adj"><img src="<%= basePath %>img/change_icon.png" align="absmiddle" title="Reassign the primary analysis contact"/></a>
		                		</c:if>
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
				</li>
				<li>
					<label for="Lab_Contact">Lab Contact</label> 
					<span id="primary_analysis">
						<c:choose>
	                		<c:when test="${project.labContact !=''}" >
		                		<c:out value="${project.labContact}" />
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
				</li>
				<li>
					<label for="NGS_Lab_Contact">NGS Lab Contact</label> 
					<span id="NGS_Lab_Contact">
						<c:choose>
	                		<c:when test="${project.NGSlabContact != ''}" >
		                		<c:out value="${project.NGSlabContact}" />
	                		</c:when>
							<c:otherwise>
		                		<i>-- No values --</i>
	                		</c:otherwise>
                		</c:choose>
               		</span>
				</li>
				<c:if test="${project.parentProjectId > 0}">
					<li>
						<label for="pr_project">Parent Project</label> 
						<span id="pr_project"><a href="project_details.do?projectId=${project.parentProjectId}" style=text-decoration:none title="Click to view the parent project details of ${project.parentProjectId}. "><c:out value="${project.parentProjectName} (ID:${project.parentProjectId})" /></a></span>
					</li>
				</c:if>
				
			</ul>
			<ul class="details" style="width:100%;border:none;">
				<li>
					<label for="pr_desc">Description</label> 
					<span id="pr_desc" style="line-height: 16px; margin-top:-3px; width:750px;"><c:out value="${project.description}" escapeXml="false" /></span>
				</li>
			</ul>
				<!-- 	<a id="a1_right" href="#" onmouseover = "test()">to the right</a>
				<div style = "display:none;">
					<a id="a1_trigger" href="#" >trigger element</a> <a href="#" id="a_bind">bind</a> / <a href="#" id="a_unbind">unbind</a> 
					<a id="a1_target" href="#">target element</a>
					</div>
				
			
			
			<div id="tip1_right" style="display:none;"><span> bubble tooltip da!!!</div>
			<div id="tip1_trigger1" style="display:none;">
			</div> -->
			 <div>
         		<strong class="lft"><h6>Project Progress</h6></strong>
         		<div class = "clear"></div>
         		<strong class="lft" style = "margin-left:20px;"><h6 style = "margin-top:5px;">Sample Batch</h6></strong>
         		<select class = "normal"  style = "margin-left:20px;" name = "samplesBatch" id = "samplesBatch" onchange = "getSampleBatch(this.value, ${project.projectId})">
         		<option value = "">--Select--</option>
         			<c:forEach items = "${sampleBatchList}" var = "batch" varStatus = "inc">
         				<c:choose>
	         				<c:when test = "${inc.count == 1}">
	         					<option value = "${batch}" selected = "selected">${batch}</option>
	         				</c:when>
	         				<c:otherwise>
	         					<option value = "${batch}">${batch}</option>
	         				</c:otherwise>
         				</c:choose>         				
         			</c:forEach>
         		</select>
         		<div class = "clear"></div>
         		<table>
         		<thead>
		         		<tr>
				         	<th width="3%">Opened</th>
				         	<th width="5%">Approved</th>
				         	<th width="7%">Sample Submission</th>
				         	<th width="10%">Library Prep</th>
				         	<th width="10%">Sequencing Run (Data Collection)</th>
				         	<th width="5%">Data QC</th>
			         	</tr>
		         	</thead>
		         	<tbody>
		         	<tr style = "height:100px;">
		         		<td>		         		
		         		<div class="meter-wrap" style ="padding:0px;width: 66px;">
						    <div class="meter-value" style ="height:5px;  width: 127%; ">
						        <div class="meter-text">100%										           
						        </div>
						    </div>
						</div>
		         		</td>
		         		<td>
		         		<c:choose>
		         			<c:when test = "${projectApprovedStatus > 0}">
			         			<div class="meter-wrap" style ="padding:0px;width: 66px;">
								    <div class="meter-value" style ="height:5px;  width: 127%; ">
								        <div class="meter-text">100%								       											           
								        </div>
								    </div>
								</div>
			         		</c:when>
			         		<c:otherwise>
			         			<div class="meter-wrap" style ="padding:0px;width: 63px;">
								    <div class="meter-value" style ="height:5px;  width: 0%; ">
								        <div class="meter-text">
								        	<span> 0%</span>										           
								        </div>
								    </div>
								</div>
			         		</c:otherwise>
		         		</c:choose>
		         		</td>
		         		
			         		<c:set var="progressPercentage" value="${fn:split((projectTracking), ':')}"></c:set>			         		 			         						         		   
					         	<td> 
					         	<div id  = "sampleProgress">
			    					<c:set value = "${fn:split(progressPercentage[0], '#')}" var = "batchNoAndStatus"/>
			    					<c:choose>
				    					<c:when test = "${batchNoAndStatus[1] == 'Approved'}">	
				    						<div class="meter-wrap" style ="padding:0px;width: 66px;">
											    <div class="meter-value" style ="height:5px;  width: 127%;">
											        <div class="meter-text">
											        <span>100%</span>								       											           
											        </div>
											    </div>
											</div>
				    					</c:when>
				    					<c:otherwise>
				    						<div class="meter-wrap" style ="padding:0px;width: 63px;">
											    <div class="meter-value" style ="height:5px;  width: 0%; ">
											        <div class="meter-text">
											        	<span> 0%</span>										           
											        </div>
											    </div>
											</div>
				    					</c:otherwise>				    					
			    					</c:choose>
			    				</div>
		    					</td>
				         		<td style = "color:#FFFFFF;">
				         			<div id = "libraryProgress">
				         			
				         			<c:choose>				         			
				         				<c:when test = "${progressPercentage[1]>0}">
								         	<div class="meter-wrap" style ="padding:0px;width: 270px;">
											    <div class="meter-value" style ="height:5px;  width: ${progressPercentage[1]}%; ">
											        <div class="meter-text">
											           <span>${progressPercentage[1]} %</span>
											        </div>
											    </div>
											</div>
									</c:when>
									<c:otherwise>
										<div class="meter-wrap" style ="padding:0px;width: 270px;">
									    <div class="meter-value" style ="height:5px;  width: 0%; ">
									        <div class="meter-text">
									          <span>0%</span>
									        </div>
									    </div>
									</div>
									</c:otherwise>
									</c:choose>
								</div>	    					
		    					</td>
				         		<td style = "color:#FFFFFF;">
				         		<div id  = "runProgress">
				         		<c:choose>
				         		<c:when test = "${progressPercentage[2] > 0}">				         			
			    						<div class="meter-wrap" style ="padding:0px;width:270px;text-align: center;">
										    <div class="meter-value" style ="height:3px;width: ${progressPercentage[2]}%; ">
										        <div class="meter-text">
										           <span> ${progressPercentage[2]} %</span>
										        </div>
										    </div>
										</div>
								</c:when>
								<c:otherwise>
									<div class="meter-wrap" style ="padding:0px;width:270px;text-align: center;">
										    <div class="meter-value" style ="height:3px;width: 0%; ">
										        <div class="meter-text">
										           <span>0%</span>
										        </div>
										    </div>
										</div>
								</c:otherwise>
								</c:choose>
		    					</div>
				         		</td>
				         		<td>
				         			<div class="meter-wrap" style ="padding:0px;width: 54px;">
									    <div class="meter-value" style ="height:5px;  width: 0%; ">
									        <div class="meter-text">
									            0%
									        </div>
									    </div>
									</div>
				         		</td>							
					</tr>					
					</tbody>		         
         		</table>
         	</div>
         	 <div class="adCntnr" style = "margin-top:-24px;cursor:pointer;cursor:hand;" >
            <div class="acco2">
               <div class="report" id ="expand" style="line-height:0;"><h6><u>Progress Report</u></h6></div>
               <div class="collapse" id = "collapse" style="display:none;height:160px;">
                  <div class="accCntnt" >
                     <div>
                        <div class="titlebarRightc" style="height:25px; width:700px;margin-top:-40px;">
                           <div class="titlebar" style="margin-left:40px;height:25px;">                          
                                <table class="tablesorter track">
                              <thead>
                                 <tr>
                                    <th>Date/Time</th>
                                  	<th>Activity</th>
                                    <th>ActionBy</th>
                                 </tr>
                                 </thead>
                                 <tbody id = "projectReport">
                               		${trackingReport}
                               </tbody>
                               </table>
                           </div>
                        </div>
                     </div>                    
                  </div>
               </div>
            </div>
         </div>
			<div style = "margin-top:-0px;">
				<strong class="lft"><h6>Project Files</h6></strong>
				<strong class="rgt toolbar" style="margin-right:5px;">
					<ul style="border:none; width:auto;">
					<c:choose>
						<c:when test ="${projectRoleTaskAccess.uploadAccess}">
							<li class="first" id = "uplaodFiles" ><a id="upload_files" class="thickbox upload-proj" href="add_project_file.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" title="">Upload Files</a></li>
						</c:when>
						<c:otherwise>					
							<li class="first" id = "uplaodFiles" ><strong title='Not Authorized' class='thickbox upload-proj'>Upload Files</strong></li>
						</c:otherwise>						
					</c:choose>
					</ul>
				</strong>
				<br clear="all" />
				<table>
		         	<thead>
		         		<tr>
				         	<th width="5%">File Name</th>
				         	<th width="3%">File Size</th>
				         	<th width="5%">Uploaded By</th>
				         	<th width="5%">Uploaded On</th>
			         	</tr>
		         	</thead>
		         	<c:choose>
						<c:when test="${empty uploadFileList}">
							<tbody>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td colspan="1" align="center">No files found</td>
								</tr>
							</tbody>
						</c:when>
						<c:otherwise>
				         	<tbody>
				         		<c:forEach items="${uploadFileList}" var="uploadFile" varStatus="status">
						         	<tr>
						         		<td><a href="view_project_file.do?fileNo=${uploadFile.fileNo }">${uploadFile.fileName}</a></td>
						         		<td>
							         		<c:forEach var="up" items="${fn:split(uploadFile.fileSize/1024,'.')}" varStatus="status">
	                        						<c:choose>
		                        						<c:when test="${status.first}">
		                        							<c:out value="${up}." /> 
		                        						</c:when>
		                        						<c:otherwise>
		                        							<c:out value="${fn:substring(up, 0, 2)} KB" /> 
		                        						</c:otherwise>
	                        						</c:choose>
	                    					</c:forEach>
                    					</td>
						         		<td>${uploadFile.uploadedBy}</td>
						         		<td>${uploadFile.uploadedOnString}</td>
						         	</tr>
					         	</c:forEach>
				         	</tbody>
						</c:otherwise>
					</c:choose>					         	
	         	</table>
         	</div>         	
         	<div>
         		<strong class="lft"><h6>Project Comments</h6></strong>
				<strong class="rgt toolbar" style="margin-right:5px;">
					<c:choose>
						<c:when test = "${projectRoleTaskAccess.commentAccess}">
							<c:choose>
								<c:when test="${project.commentsCount == 0}">
									<ul style="border:none; width:auto;">
										<li id="AddCommentLink" class="first"><a href="comment_details.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" class="thickbox comment" title="">Add New Comment</a></li>
									</ul>
								</c:when>
								<c:otherwise>
									<ul style="border:none; width:auto;">
										<li id="AddCommentLink" class="first"><a href="comment_details.do?projectId=${project.projectId}&projectName=${project.projectName}&placeValuesBeforeTB_=savedValues&amp;TB_iframe=true&amp;height=450&amp;width=600" class="thickbox comment" title="">Add Comments (${project.commentsCount})</a></li>
									</ul>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<strong title='Not Authorized'>Add Comments</strong>
						</c:otherwise>
					</c:choose>	
				</strong>
				<br clear="all" />
				<table class="tablesorter track" id="comments_table">
						<thead>
							<tr>
							    <th width="15%">User</th>
							    <th width="15%">Type</th>
							    <th width="45%">Comments</th>
								<th width="25%">Date Added</th>
							</tr>
						</thead>
						<c:choose>
							<c:when test="${empty commentsList}">
								<tbody>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td colspan="1" align="center">No comments found</td>
									</tr>
								</tbody>
							</c:when>
							<c:otherwise>
								<tbody id="track_body">
									<c:forEach items="${commentsList}" var="cmt" varStatus="status">
										<tr>
											<td>${cmt.createdBy}</td>
											<td>${cmt.commentType}</td>
											<td class="lheight">${cmt.comments}</td>
											<td>${cmt.createdOnString}</td>
										</tr> 
									</c:forEach> 
								</tbody>
						</c:otherwise>
					</c:choose>	
				</table>
         	</div>

         	<div>
				<c:if test="${not empty runQCList}">
					<h6>QC Summary</h6>
					<table>
			         	<thead>
			         		<tr>
					         	<th>Run ID</th>
					         	<th>QC File No</th>
					         	<th>No of Libraries</th>
					         	<th>Method</th>
					         	<th>No of Cycles</th>
				         	</tr>
			         	</thead>
			         	<tbody>
			         		<c:forEach items="${runQCList}" var="runQC" varStatus="status">
					         	<tr>
					         		<td>${runQC.runId }</td>
					         		<td>${runQC.fileNo }</td>
					         		<td>${runQC.libraryCount}</td>
					         		<td>${runQC.method}</td>
					         		<td>${runQC.noOfCycles }</td>
					         	</tr>
				         	</c:forEach>
			         	</tbody>
		         	</table>
		         </c:if>
         	</div>
         </div><div class="clear"></div>
	</div>
</c:if>
</div>

<%@include file="../include/footer.jspi" %>