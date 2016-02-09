<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">
<style>
 table { 
 	font-size: 13px; 
 } 
</style>

<script>
$(document).ready(function() {
	selectChangeCourseList();
	$("table.tableMst tr:eq(0)").css("background", "lightblue");
});
</script>

<script>
	var gCourseNum = "";
	
	// 전체 select_mst table
	function selectChangeCourseList() {
		
		var dataForm = {
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/selectChangeCourseList",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				var i;
				
				// 수정 전(백업)
				for(i=0; i<response.length; i++){
					response[i].giveSubject_nm = "[" + response[i].giveSubject + "]  " + response[i].giveSubject_nm;
					response[i].takeSubject_nm = "[" + response[i].takeSubject + "]  " + response[i].takeSubject_nm;
					response[i].writer_nm = response[i].writer + "  /  " + response[i].writer_nm;	
				}
				
				
				$('#table_mst').bootstrapTable('load', response).on('dbl-click-row.bs.table', function(e, row, $element) {
					
					$('input[name="boardNum"]').val(row.boardNum);
					$('input[name="title"]').val(row.boardTitle);
					$('input[name="give_subject"]').val(row.giveSubject);
					$('input[name="take_subject"]').val(row.takeSubject);
					$('input[name="writer_det"]').val(row.writer);

					$('.panel-heading #give').html(row.giveSubject_nm);
					$('.panel-heading #take').html(row.takeSubject_nm);
					
					
					// select 별도 function (det를 위함) : param = giveSubject courseNum, takeSubject courseNum
					selectFormDetGive(row.giveSubject);
					selectFormDetTake(row.takeSubject);
					
					// 종료된 수업은 modal이 뜨지 않음, 종료되지 않은 수업은 modal을 뜨게 함
					if(row.exitYn == 'Y'){
						$('#modal').modal('hide');
					}else{
						$('#modal').modal('show');
					}
					
					// 앞전에 걸린 수업교환하기 lock을 풀어주는 부분
					$('#changeComplete').attr('disabled', false);
					
				});
					

// 				$('#table_mst').bootstrapTable({
// 					'click-row.bs.table' : function(e, row, $element) {	
// 					var selected = $('#table_mst').bootstrapTable('getSelections')[0].writer_nm;
// 					console.info(selected);
// 					}
// 				});
				
				// 선택한 게시글이 내가 쓴거인지 아닌지에 따라 button을 show, hide 해줄 부분

				
				// 종료된 수업을 gray색으로 표시
				var data = $('#table_mst').bootstrapTable('getData');
				
				for (var i = 0; i < data.length; i++) {
					if (data[i].exitYn == "Y") {
						$("#table_mst tbody tr").eq(i).css("background", "#E7E7E7");
					}
				}
				
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	// updateCourse ("수업교환하기" 중 타인이 올린 글 클릭 시)
	function updateCourse() {
		
		var dataForm = {
			boardNum : $('input[name="boardNum"]').val(),
			memberId : '${LOGIN_MEMBER.memberId}',
			giveMemberId : '${LOGIN_MEMBER.memberId}',
			giveSubject : $('input[name="give_subject"]').val(),
		 	giveWriterMemberId : $('input[name="writer_det"]').val(),
		 	
		 	takeMemberId : $('input[name="writer_det"]').val(),
		 	takeSubject : $('input[name="take_subject"]').val(),
		 	takeWriterMemberId : '${LOGIN_MEMBER.memberId}'
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/updateCourse.update",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				
				console.info(response);
				if(response.${RESULT_CODE} == '-404'){
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					$('#changeComplete').attr('disabled','disabled');
				}else{
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					hideModal('modal');
					selectChangeCourseList();
				}
				
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	/*
		double click시 출력 modal 
		1) 좌측 data det select
		2) 우측 data det select
	*/

	// selectChangeFormDet1
	function selectFormDetGive(gs) {
		
		var giveS = gs;
		
		var dataForm = {
			courseNum  : giveS
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/selectWriteform",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
			
				// 넣어주는 부분 해야함
				$("#giveDetProf").html(response[0].professor);
				$("#giveDetGrade").html(response[0].grade_nm);
				$("#giveDetLecTime").html(response[0].lecTime);
				$("#giveDetLecRoom").html(response[0].lecRoom);
				$("#giveDetCyberYn").html(response[0].cyberYN);
				$("#giveDetCapacity").html(response[0].capacity);

			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	// selectChangeFormDet2
	function selectFormDetTake(ts) {
		var takeS = ts;
	
		var dataForm = {
			courseNum : takeS
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/selectWriteform",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				// 넣어주는 부분 해야함
				$("#takeDetProf").html(response[0].professor);
				$("#takeDetGrade").html(response[0].grade_nm);
				$("#takeDetLecTime").html(response[0].lecTime);
				$("#takeDetLecRoom").html(response[0].lecRoom);
				$("#takeDetCyberYn").html(response[0].cyberYN);
				$("#takeDetCapacity").html(response[0].capacity);
				
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	
	/*
		글쓰기 form 
		1) "원하는 과목" select tag
		2) "내어줄 과목" select table
	*/

	// 글쓰기 폼에서 원하는 과목 리스트 select (select tag)
	function selectTakeForm() {
	
		var dataForm = {
			notMemberId : "${LOGIN_MEMBER.memberId}"
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/selectWriteform",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				
				
				$('#wantSubject').append('<option value="">원하는 과목을 선택하세요</option>');
				$.each(response, function(index, item) {
					$('#wantSubject').append('<option value='+item.courseNum + '>' + item.courseNum + " / " + item.courseName + '</option>');
				});
				
				selectGiveForm();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	// 글쓰기 폼에서 내어줄 과목 리스트 select
	function selectGiveForm() {
	
		var dataForm = {
			memberId : "${LOGIN_MEMBER.memberId}"
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/selectWriteform",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				
				var writer = "${LOGIN_MEMBER.memberId}" + "  /  " + "${LOGIN_MEMBER.memberName}";  
				
				document.getElementById("writerName").value = writer;
				
				$('#writeformTable').bootstrapTable('load', response).on(
						'click-row.bs.table', function(e, row, $element) {
							gCourseNum = row.courseNum;
				});
				showModal('writeForm');
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	// 글쓰기 폼에서 글 작성시 (insert)
	function insertWriteform() {
		
		var dataForm = {
			boardTitle : $('#writeTitle').val(),	
			giveSubject : gCourseNum,
			takeSubject :  $("#wantSubject option:selected").val(),
			writer : "${LOGIN_MEMBER.memberId}",
			exitYn : 'N'
		};
		$.ajax({
			type : "POST",
			url : "/course/change_course/insertWriteform",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				selectChangeCourseList();
				hideModal('writeForm');
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

//show, hide modal
	function showModal(modalId){
		$('#'+modalId).modal('show');
	}
	function hideModal(modalId){
		$('#'+modalId).modal('hide');
	}
</script>

</gachonTag:script>
<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<form class="form-horizontal">
			<fieldset>
				<div class="page_title">수업교환 하기</div>
				<hr />

				<div style="color: #F15F5F; font-size: 14px; font-weight: bold;">
					<p>** 공지사항 **</p>
					<p>1. 줬다 뺏지 않기</p>
					<p>2. 장난으로 준다고 설레게 하지 않기</p>
				</div>
				<br />

				<table id="table_mst" class="tableMst" data-toggle="table" data-show-columns="false"
					data-search="true" data-show-refresh="false"
					data-show-toggle="false" data-show-export="false"
					data-pagination="true" data-height="450" data-click-to-select="true" data-select-item-name="boardNum">
					<thead>
						<tr>
							<th data-field="state" data-radio="true"></th>
							<th data-field="boardNum" class="col-md-1">번호</th>
							<th data-field="boardTitle" class="col-md-4">글 제목</th>
							<th data-field="giveSubject_nm" class="col-md-2">내어줄 과목</th>
							<th data-field="takeSubject_nm" class="col-md-2">원하는과목</th>
							<th data-field="writer_nm" class="col-md-2">작성자</th>
							<th data-field="exitYn" class="col-md-1">종료여부</th>
						</tr>
					</thead>
				</table>
			</fieldset>
		</form>
		
		<input type="button" class="btn btn-info" data-toggle="modal" onclick="selectTakeForm();" style="float:right;" value="글쓰기"></input>
		
		<!-- modal.1 : 글쓰기form -->
			<div class="modal fade bs-example-modal-lg" id="writeForm" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">수업 교환하기</h4>
						</div>
						<div class="modal-body">
							<div class="row form-group">
								<label for="Category" class="col-sm-2 control-label" style="margin-top: 1%; text-align: right;">
									글 제목<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-10">
									<input id="writeTitle" class="form-control input-sm"
										placeholder="글 제목을 입력해 주세요" type="text">
								</div>
							</div>
							
							<div class="row form-group">
								<label for="Category" class="col-sm-2 control-label" style="margin-top: 1%; text-align: right;">
									작성자<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-10">
									<input id="writerName" class="form-control input-sm" type="text" readonly>
								</div>
							</div>
							
							<div class="row form-group">
								<label for="Category" class="col-sm-2 control-label" style="margin-top: 1%; text-align: right;">
									원하는 과목<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-10">
									<select class="form-control input-sm" id="wantSubject"></select>
								</div>
							</div>
							
							<div class="row form-group">
								<label for="Category" class="col-sm-2 control-label" style="margin-top: 1%; text-align: right; float:left;">
									내어줄 과목<div class="glyphicon glyphicon-ok"></div>
								</label>
							</div>

							<table id="writeformTable"  data-toggle="table" data-url="#"
								data-show-columns="false" data-search="false"
								data-show-refresh="false" data-show-toggle="false"
								data-show-export="false" data-pagination="true" data-height="400"
								data-click-to-select="true" data-select-item-name="courseNum">
								<thead>
									<tr>
										<th data-field="state" data-radio="true"></th>
										<th data-field="courseNum">학수번호</th>
										<th data-field="courseName">과목명</th>
										<th data-field="professor">담당교수</th>
										<th data-field="grade_nm">학점</th>
										<th data-field="lecTime">강의시간</th>
										<th data-field="lecRoom">강의실</th>
										<th data-field="capacity">수강 인원</th>
									</tr>
								</thead>
							</table>
						</div>
						
						<div class="modal-footer" style="text-align: center;">
							<a href="#" id="saveMaster" class="btn btn-success" onclick="insertWriteform();">등록</a>
							<a href="#" class="btn btn-warning" data-dismiss="modal">닫기</a>
						</div>
					</div>
				</div>
			</div>
					

		<!-- modal.1 : 수업교환 하기 상세 modal -->
		<div id="modal" class="modal fade bs-example-modal-lg" tabindex="-1"
			role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="font-weight: bold;">수업 교환 하기</h4>
					</div>
					
					<div class="modal-body detailInfo">
						<form class="form-horizontal">
							<fieldset>
								<div class="form-group">
									<label for="Detail_Addr"
										class="col-sm-2 control-label input-sm" style="width:13%;">글 번호</label>
									<div class="col-sm-10">
										<input class="form-control input-sm" name="boardNum" type="text" readonly>
									</div>
								</div>
								
								<div class="form-group">
									<label for="Detail_Addr"
										class="col-sm-2 control-label input-sm" style="width:13%;">글 제목</label>
									<div class="col-sm-10">
										<input class="form-control input-sm" name="title" type="text" readonly>
									</div>
								</div>
								
								<div class="form-group">
									<label for="Detail_Addr"
										class="col-sm-2 control-label input-sm" style="width:13%;">글 작성자</label>
									<div class="col-sm-10">
										<input class="form-control input-sm" name="writer_det" type="text" readonly>
									</div>
								</div>
								
								<div class="form-group">
									<label for="Detail_Addr" class="col-sm-2 control-label input-sm" style="width:13%;">내어줄 과목</label>
									<div class="col-sm-4">
										<input class="form-control input-sm" name="give_subject" type="text" readonly>
									</div>
									
									<label for="Detail_Addr" class="col-sm-2 control-label input-sm" style="width:16.5%;">원하는  과목</label>
									<div class="col-sm-4">
										<input class="form-control input-sm" name="take_subject" type="text" readonly>
									</div>
								</div>
								
								<div class="form-group">
									<label for="Detail_Addr"
										class="col-sm-2 control-label input-sm" style="width:13%;">상세</label>
									<div class="col-sm-4">
										<div class="panel panel-success">
											<div class="panel-heading">
												<p class="panel-title detailInfo" id="give"></p>
											</div>
											
											<!-- 미완성 : DB테이블에서 가져와야 함  -->
											<div class="panel-body">
												<p>담당교수 : <span id="giveDetProf"></span></p>
												<p>학      점 : <span id="giveDetGrade"></span></p>
												<p>강의시간 : <span id="giveDetLecTime"></span></p>
												<p>강 의 실 : <span id="giveDetLecRoom"></span></p>
												<p>사이버여부 : <span id="giveDetCyberYn"></span></p>
												<p>수강인원 : <span id="giveDetCapacity"></span></p>
											</div>
										</div>
									</div>
									
									<label for="Detail_Addr"
										class="col-sm-2 control-label input-sm" style="width:16.5%;">상세</label>
									<div class="col-sm-4">
										<div class="panel panel-warning">
											<div class="panel-heading">
												<p class="panel-title detailInfo" id="take"></p>
											</div>
											<div class="panel-body">
												<p>담당교수 : <span id="takeDetProf"></span></p>
												<p>학      점 : <span id="takeDetGrade"></span></p>
												<p>강의시간 : <span id="takeDetLecTime"></span></p>
												<p>강 의 실 : <span id="takeDetLecRoom"></span></p>
												<p>사이버여부 : <span id="takeDetCyberYn"></span></p>
												<p>수강인원 : <span id="takeDetCapacity"></span></p>
											</div>
										</div>
									</div>
								</div>
							</fieldset>
						</form>
					</div>


					<div class="modal-footer" style="text-align:center;">
						<a href="#" id="changeComplete" class="btn btn-info" onclick="updateCourse();">교환하기</a> 
						<a href="#" class="btn btn-default" data-dismiss="modal">닫기</a>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>

</gachonTag:html>
