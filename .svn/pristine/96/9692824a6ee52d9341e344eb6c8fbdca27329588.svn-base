<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">

	<!-- 가상시간표 아코디언 시작 -->
	<link rel="stylesheet"
		href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css">


	<script>
		$(function() {
			$("#accordion").accordion({
				collapsible : true,
				active : 2
			});
		});
	</script>



	<!-- 가상시간표 보기 테이블 -->
	<style>
/* --- The Table Structure --- */
.scheduleTable {
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
}

.scheduleTable  tr  th,.scheduleTable  tr  td {
	border-right: 1px solid #bbb;
	border-bottom: 1px solid #bbb;
	box-shadow: 2px 2px 1px #e5dfcc;
	text-align: center;
}

.scheduleTable  tr  th:first-child,.scheduleTable  tr  td:first-child {
	border-left: 1px solid #bbb;
}

.scheduleTable  tr  th {
	border-top: 1px solid #bbb;
}

/* top-left border-radius */
.scheduleTable  tr:first-child  th:first-child {
	border-top-left-radius: 6px;
}

/* top-right border-radius */
.scheduleTable  tr:first-child  th:last-child {
	border-top-right-radius: 6px;
}

/* bottom-left border-radius */
.scheduleTable  tr:last-child  td:first-child {
	border-bottom-left-radius: 6px;
}

/* bottom-right border-radius */
.scheduleTable  tr:last-child  td:last-child {
	border-bottom-right-radius: 6px;
}

/* -- The Stlyes -- 
	body {
		margin: 30px;
		background: #ECEAE3;
		font-family: 'Muli', Serif;
	} */
.scheduleTable  th,.scheduleTable  td {
	padding: 8px 20px;
}

.scheduleTable  th {
	background: #E5E6EB;
	color: #111;
}

.scheduleTable  td {
	background: #EFF1F6;
}
</style>
	<!-- 가상시간표 보기 css 끝 -->

	<style>
#ui-id-1 {
	background: #E7E7E7;
	font-weight: bold;
}

#ui-id-2 {
	/* background :  */
	
}

/* .btn-warning { */
/* 	height: 30px; */
/* 	padding-bottom: 20px; */
/* 	padding-top: 2px; */
/* } */
</style>
	<!-- 가상시간표 아코디언 끝 -->

	<script>
		//초기 로드 테이블
		$(document).ready(function() {
			selectMst();
			selectTemporarySchedule();

			$("b").css("background", "yellow");
			$("table.mTable tr:eq(0)").css("background", "lightblue");
			$("table.dTable tr:eq(0)").css("background", "lightblue");
			$("table.aTable tr:eq(0)").css("background", "lightblue");

		});
	</script>

	<!-- MST 테이블 Ajax (조건 필터링 이전 - 최초 Select) -->
	<script>
		function selectMst() {

			var dataForm = {
				college : $("#college_s option:selected").val(),
				semester : $("#semester_s option:selected").val(),
				completeDivision : $("#completeDivision_s option:selected").val(),
				schoolYear : $("#schoolYear_s option:selected").val(),
				major : $("#major_s option:selected").val(),
				courseName : $("#courseName_s").val(),
				memberId : "${LOGIN_MEMBER.memberId}"
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/list.json", // major_map에서 매칭되는 courseNum을 가지고 course_mst에 접근 url
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#MST').bootstrapTable('load', response);
					
					console.log(response);
					
					var data = $('#MST').bootstrapTable('getData');
					
					for (var i = 0; i < data.length; i++) {
						if (data[i].appYn == "Y") {
							$("table.mTable tbody tr").eq(i).css("background", "#E0EFFF");
						}
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<!-- 학부>전공 필터링 Ajax -->
	<script>
		function majorFilter() {

			var dataForm = {
				grcode : 'MAJOR', // 이 key 값에 해당하는 value는 무엇인가? MAJOR
				code : $("#department_s option:selected").val()
			};
			$.ajax({
				type : "POST",
				url : "/common/code/codeDETWithCode.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#major_s').html('');

					$('#major_s').append('<option value="">전체</option>');
					$.each(response, function(index, code) {
						$('#major_s').append('<option value='+code.value + '>' + code.label + '</option>');

					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<!-- 수업계획서 Modal Ajax -->
	<script>
		function selectModal() {
			var dataForm = {
				courseNum : $('#MST').bootstrapTable('getSelections')[0].courseNum
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/show.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					// 					var str_grade = "";
					// 					str_grade += response.grade + "학점";

					document.getElementById("modalCourseName").value = response.courseName;
					document.getElementById("modalCourseNum").value = response.courseNum;
					document.getElementById("modalCompleteDivision").value = response.completeDivision_nm;
					// 					document.getElementById("modalGrade").value = str_grade;
					document.getElementById("modalGrade").value = response.grade_nm;
					document.getElementById("modalLecTime").value = response.lecTime;
					document.getElementById("modalLecRoom").value = response.lecRoom;
					document.getElementById("modalPrerequisiteCourse").value = response.prerequisiteCourse;
					document.getElementById("modalEngineeringAuthentication").value = response.engineeringAuthentication_nm;
					document.getElementById("modalProfessorName").value = response.professor;
					document.getElementById("modalProfessorPhone").value = response.phone;
					document.getElementById("modalProfessorEmail").value = response.email;
					document.getElementById("ModalSummary").value = response.summary;
					document.getElementById("ModalGoal").value = response.goal;
					document.getElementById("ModalProgressWay").value = response.progressWay;
					document.getElementById("ModalValuationBasis").value = response.valuationBasis;
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>


	<!--  수강신청 취소는 어떻게 함??? 신청버튼이 신청하면 다시 취소로 바뀌게 해야하고, 신청한 과목의 라인색이 바뀌도록 업그레이드 시킬 것!  -->

	<!-- 신청자 현황보기 Ajax (select, insert) -->
	<script>
		function selectApplicantModal() {

			var dataForm = {
				courseNum : $('#MST').bootstrapTable('getSelections')[0].courseNum
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/applicantState.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#applicantInfo').bootstrapTable('load', response);

				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function insertApplicantModal(idx, regCourseNum) {

			var dataForm = {
				courseNum : regCourseNum,
				memberId : "${LOGIN_MEMBER.memberId}",
// 				appYn : appYn,
				crtUser : "tester",
				updtUser : "tester"
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/applicantState.insert", // insert는 임의 지정
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					if(response.RESULT_CODE > 0){
						$('a.register button').eq(idx).toggleClass("btn-info").toggleClass("btn-warning");	// toggleClass('class명') : class명이 기존에 있다면, 삭제해주고 없다면 추가해 줌
						$('a.register button').eq(idx).text('신청취소');
					}
					
					selectMst();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function deleteApplicantModal(idx, cancelCourseNum) {

			var dataForm = {
				courseNum : cancelCourseNum,
				memberId : "${LOGIN_MEMBER.memberId}"
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/applicantState.delete",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					if(response.RESULT_CODE > 0){
						$('a.register button').eq(idx).toggleClass("btn-info").toggleClass("btn-warning");
						$('a.register button').eq(idx).text('수강신청');
					}
// 					selectMst();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<!-- 가상시간표 Ajax (select, insert) -->
	<script>
		function selectTemporarySchedule() {

			var dataForm = {};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/temporarySchedule.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#DET').bootstrapTable('load', response);

				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function insertTemporarySchedule() {

			var dataForm = {
				courseNum : $('#MST').bootstrapTable('getSelections')[0].courseNum,
				courseName : $('#MST').bootstrapTable('getSelections')[0].courseName,
				area : $('#MST').bootstrapTable('getSelections')[0].area,
				completeDivision : $('#MST').bootstrapTable('getSelections')[0].completeDivision,
				grade : $('#MST').bootstrapTable('getSelections')[0].grade,
				professor : $('#MST').bootstrapTable('getSelections')[0].professor,
				lecTime : $('#MST').bootstrapTable('getSelections')[0].lecTime,
				lecRoom : $('#MST').bootstrapTable('getSelections')[0].lecRoom,
				schoolYear : $('#MST').bootstrapTable('getSelections')[0].schoolYear
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/temporarySchedule.insert", // insert는 임의 지정
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					selectTemporarySchedule();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function deleteTemporarySchedule() {
			var dataForm = {
				courseNum : $('#DET').bootstrapTable('getSelections')[0].courseNum
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/temporarySchedule.delete",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					selectTemporarySchedule();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="시간표 가져오기">
		function selectTmpSchedule() {
			var dataForm = {};

			var color = [ "#FFA7A7", "#FFC19E", "#FFE08C", "#CEF279", "#B7F0B1", "#D1B2FF", "#FFB2F5", "#B2EBF4" ];
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/temporarySchedule.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					console.log(response);
					$.each(response, function(index, item) {
						var info = "[" + item.courseName + "]" + "<br/>" + item.lecRoom;

						var str = item.lecTime + "/";
						var sstr = str.split('/');
						var kssr = sstr[0].split(',');

						$('td[id=' + kssr[0] + ']').html(info);
						$('td[id=' + kssr[1] + ']').html(info);
						$('td[id=' + kssr[2] + ']').html(info);
						$('td[id=' + kssr[3] + ']').html(info);

						var lec = "";
						var stn = "";
						var lecSplit = "";
						for (var i = 0; i < response.length; i++) {
							lec = response[i].lecTime;
							if (i != 0) {
								lec = response[i].lecTime;
								stn += "," + lec;
							} else {
								lec = response[i].lecTime;
								stn += lec;
							}

						}

						lecSplit = stn.split(',');
						for (var j = 0; j < lecSplit.length; j++) {
							for (var k = 0; k < lecSplit.length; k++) {
								if ($('td[id=' + lecSplit[j] + ']').text() == $('td[id=' + lecSplit[k] + ']').text()) {
									$('td[id=' + lecSplit[k] + ']').css("background-color", color[j / 4]);
								}
							}
						}

					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script type="text/javascript">
		function modalType(type) {
			inputTextInit("#class_info");

			if (type == "plan") {
				selectModal();
			} else if (type == "applicant") {
				selectApplicantModal();
			} else if (type == "bookmark") {
				insertTemporarySchedule();
			} else if (type == "schedule") {
				selectTmpSchedule();
			}
		}
	</script>
</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>
	<div class="container">
		<!-- c:forEach jstl 을 사용해서 해볼 것. option 사용하면 너무 복잡해짐;; -->
		<form class="form-horizontal">
			<fieldset style="margin-bottom: 3%;">
				<div class="page_title">수강조회</div>
				<hr />

				<!-- <h2>수강과목</h2> -->
				<div class="form-group" style="margin: 0;">
					<div class="row">
						<div class="col-md-3">
							<label>소속 캠퍼스</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-2">
							<label>년도</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-2">
							<label>학기</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-3">
							<label>이수 영역</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-2">
							<label>학년</label>
						</div>
					</div>

					<div class="row">
						<div class="col-md-3">
							<!-- 셀렉트박스 쓰는법... -->
							<gachonTag:select code="${COLLEGE }" id="college_s"
								required="required" />
							<!-- initLabel="전체" 를 넣어주면, 전체 항목 생성. initLabel은 SelectTag.java 참고 -->
						</div>
						<div class="col-md-2">
							<input class="form-control" value="2015" type="2015" disabled>
						</div>
						<div class="col-md-2">
							<gachonTag:select code="${SEMESTER }" id="semester_s"
								required="required" />
						</div>
						<div class="col-md-3">
							<gachonTag:select code="${COMPLETE_DIVISION }"
								id="completeDivision_s" required="required" />
						</div>
						<div class="col-md-2">
							<gachonTag:select code="${SCHOOL_YEAR }" id="schoolYear_s"
								initLabel="전체" />
						</div>
					</div>
				</div>

				<div style="margin-top: 0.5%;"></div>
				<div class="form-group" style="margin: 0%">
					<div class="row">
						<div class="col-md-3">
							<label>학부/학과</label>
						</div>
						<div class="col-md-4">
							<label>전공</label>
						</div>
						<div class="col-md-5">
							<label>과목명</label>
						</div>
					</div>

					<div class="row">
						<div class="col-md-3">
							<gachonTag:select code="${DEPARTMENT }" id="department_s"
								onChange="majorFilter();" initLabel="전체" />
						</div>
						<div class="col-md-4">
							<gachonTag:select code="${MAJOR }" id="major_s" initLabel="전체" />
						</div>
						<div class="col-md-4">
							<input type="text" class="form-control" id="courseName_s"
								placeholder="과목명을 입력하세요">
						</div>

						<div class="col-md-1">
							<input type="button" class="btn btn-info"
								onclick="selectMst();" value="검색"> </input>
						</div>
					</div>
			</fieldset>
		</form>

		<table class="mTable" id="MST" data-toggle="table"
			data-show-columns="false" data-search="false"
			data-show-refresh="false" data-show-toggle="false"
			data-show-export="false" data-pagination="true" data-height="500"
			data-click-to-select="true" data-select-item-name="radioName">
			<thead>
				<tr>
					<!--  course_mst DB에서 가져올 것 -->
					<th data-field="state" data-radio="true"></th>
					<th data-field="courseNum">학수번호</th>
					<th data-field="courseName">교과목명</th>
					<th data-field="area_nm">영역</th>
					<th data-field="completeDivision_nm">이수구분</th>
					<th data-field="grade_nm">학점</th>
					<th data-field="professor">담당교수</th>
					<th data-field="lecTime">강의시간</th>
					<th data-field="lecRoom">강의실</th>
					<th data-formatter="operateFormatter" data-events="operateEvents">수강신청</th>
					<th data-field="appYn" data-visible="false">수강신청</th>
				</tr>
			</thead>
		</table>

		<div style="margin-bottom: 5%; margin-top: 1%;">
			<!-- Button trigger modal 1 -->
			<input type="button" class="btn btn-info" data-toggle="modal"
				data-target="#bookmark" onclick="modalType('bookmark');"
				value="과목찜하기"> </input>

			<!-- Button trigger modal 2 -->
			<input type="button" class="btn btn-info" data-toggle="modal"
				data-target="#class_info" onclick="modalType('plan');"
				value="수업 계획서"> </input>

			<!-- Button trigger modal 3 -->
			<input type="button" class="btn btn-info" data-toggle="modal"
				data-target="#applicant" onclick="modalType('applicant');"
				value="신청자 현황보기"> </input>
		</div>


		<h2 class="page_title">가상 시간표</h2>
		<br>
		<div id="accordion">
			<h3>가상 시간표란? (click)</h3>
			<div>
				<span>수강조회에서 신청한 과목에 대한 가상 시간표를 확인할 수 있습니다.</span> &nbsp; <span><b>'가상시간표보기'</b>로
					확인하세요!</span>
			</div>
		</div>
		<hr />
		<table class="dTable" id="DET" data-toggle="table"
			data-show-columns="false" data-search="false"
			data-show-refresh="false" data-show-toggle="false"
			data-show-export="true" data-pagination="true" data-height="300"
			data-click-to-select="true" data-select-item-name="radioName">

			<div id="transform-buttons" class="btn-group"
				style="position: relative; float: right; margin-bottom: 1%;">

				<input type="button" class="btn btn-info" data-toggle="modal"
					style="margin-right: 3px;" data-target="#schedule"
					onclick="modalType('schedule');" value="가상시간표 보기"> </input>

				<button class="btn btn-info" data-method="remove"
					onClick="deleteTemporarySchedule();">
					<i class="glyphicon glyphicon-trash"></i> <span data-es="Destruir">삭제</span>
				</button>
			</div>
			<thead>
				<tr>
					<th data-field="state" data-radio="true"></th>
					<th data-field="courseNum">학수번호</th>
					<th data-field="courseName">교과목명</th>
					<th data-field="schoolYear_nm">학년</th>
					<th data-field="area_nm">영역</th>
					<th data-field="completeDivision_nm">이수</th>
					<th data-field="grade_nm">학점</th>
					<th data-field="professor">담당교수</th>
					<th data-field="lecTime_nm">강의시간</th>
					<th data-field="lecRoom">강의실</th>
				</tr>
			</thead>
		</table>

		<!-- Modal 2 : 수업계획서 모달-->
		<div class="modal fade bs-example-modal-lg" id="class_info"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="font-weight: bold;">수업 계획서</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">교과목명</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalCourseName"
										readonly>
								</div>

								<label for="id" class="col-sm-2 control-label">학수번호</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalCourseNum"
										readonly>
								</div>
							</div>


							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">이수</label>
								<div class="col-sm-4">
									<input type="text" class="form-control"
										id="modalCompleteDivision" readonly>
								</div>

								<label for="id" class="col-sm-2 control-label">학점</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalGrade"
										readonly>
								</div>
							</div>

							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">강의시간</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalLecTime"
										readonly>
								</div>

								<label for="id" class="col-sm-2 control-label">강의실</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalLecRoom"
										readonly>
								</div>
							</div>

							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">선수과목</label>
								<div class="col-sm-4">
									<input type="text" class="form-control"
										id="modalPrerequisiteCourse" readonly>
								</div>

								<label for="id" class="col-sm-2 control-label">공학인증이수</label>
								<div class="col-sm-4">
									<input type="text" class="form-control"
										id="modalEngineeringAuthentication" readonly>
								</div>
							</div>

							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">교수성명</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="modalProfessorName"
										readonly>
								</div>

								<label for="id" class="col-sm-2 control-label">연락처</label>
								<div class="col-sm-4">
									<input type="text" class="form-control"
										id="modalProfessorPhone" readonly>
								</div>
							</div>


							<div class="row form-group">
								<label for="id" class="col-sm-2 control-label">E-mail</label>
								<div class="col-sm-10">
									<input type="email" class="form-control"
										id="modalProfessorEmail" readonly>
								</div>
							</div>

							<div class="row form-group">
								<label class="col-sm-2 control-label">강의개요</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="ModalSummary" disabled></textarea>
								</div>
							</div>

							<div class="row form-group">
								<label class="col-sm-2 control-label">강의목표</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="ModalGoal" disabled></textarea>
								</div>
							</div>

							<div class="row form-group">
								<label class="col-sm-2 control-label">강의진행</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="ModalProgressWay" disabled></textarea>
								</div>
							</div>

							<div class="row form-group">
								<label class="col-sm-2 control-label">성적평가</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="ModalValuationBasis"
										disabled></textarea>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal 3 : 신청자현황 보기 모달-->
		<div class="modal fade" id="applicant" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="font-weight: bold;">신청자현황 보기</h4>
					</div>
					<div class="modal-body">
						<table id="applicantInfo" class="aTable" data-toggle="table"
							data-url="#" data-show-columns="false" data-search="false"
							data-show-refresh="false" data-show-toggle="false"
							data-show-export="true" data-pagination="true" data-height="500">
							<thead>
								<tr>
									<th data-field="memberId">학번</th>
									<th data-field="schoolYear_nm">학년</th>
									<th data-field="memberName">이름</th>
									<th data-field="major_nm">전공</th>
									<th data-field="updtDt">신청일자</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>


		<!-- Modal 4 : 가상시간표 보기 모달-->
		<div class="modal fade bs-example-modal-lg" id="schedule"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel"
							style="font-weight: bold;">가상시간표 보기</h4>
					</div>
					<div class="modal-body">
						<section class="invoice">
							<table class="scheduleTable">
								<thead>
									<tr>
										<th></th>
										<th>월요일</th>
										<!-- MO -->
										<th>화요일</th>
										<!-- TU -->
										<th>수요일</th>
										<!-- WE -->
										<th>목요일</th>
										<!-- TH -->
										<th>금요일</th>
										<!-- FR -->
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>1교시(09:00-09:50)<br>A교시(09:00-10:15)
										</th>
										<td id="MO1"></td>
										<!-- 월 -->
										<td id="TU1"></td>
										<!-- 화 -->
										<td id="WE1"></td>
										<!-- 수 -->
										<td id="TH1"></td>
										<!-- 목 -->
										<td id="FR1"></td>
										<!-- 금 -->
									</tr>
									<tr>
										<th>2교시(10:00-10:50)<br>B교시(10:30-11:45)
										</td>
										<td id="MO2"></td>
										<!-- 월 -->
										<td id="TU2"></td>
										<!-- 화 -->
										<td id="WE2"></td>
										<!-- 수 -->
										<td id="TH2"></td>
										<!-- 목 -->
										<td id="FR2"></td>
										<!-- 금 -->
									</tr>
									<tr>
										<th>3교시(11:00-11:50)<br>
										</td>
										<td id="MO3"></td>
										<!-- 월 -->
										<td id="TU3"></td>
										<!-- 화 -->
										<td id="WE3"></td>
										<!-- 수 -->
										<td id="TH3"></td>
										<!-- 목 -->
										<td id="FR3"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>4교시(12:00-12:50)<br>C교시(12:00-13:15)
										</td>
										<td id="MO4"></td>
										<!-- 월 -->
										<td id="TU4"></td>
										<!-- 화 -->
										<td id="WE4"></td>
										<!-- 수 -->
										<td id="TH4"></td>
										<!-- 목 -->
										<td id="FR4"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>5교시(13:00-13:50)<br>
										</td>
										<td id="MO5"></td>
										<!-- 월 -->
										<td id="TU5"></td>
										<!-- 화 -->
										<td id="WE5"></td>
										<!-- 수 -->
										<td id="TH5"></td>
										<!-- 목 -->
										<td id="FR5"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>6교시(14:00-14:50)<br>D교시(13:30-14:45)
										</td>
										<td id="MO6"></td>
										<!-- 월 -->
										<td id="TU6"></td>
										<!-- 화 -->
										<td id="WE6"></td>
										<!-- 수 -->
										<td id="TH6"></td>
										<!-- 목 -->
										<td id="FR6"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>7교시(15:00-15:50)<br>E교시(15:30-16:45)
										</td>
										<td id="MO7"></td>
										<!-- 월 -->
										<td id="TU7"></td>
										<!-- 화 -->
										<td id="WE7"></td>
										<!-- 수 -->
										<td id="TH7"></td>
										<!-- 목 -->
										<td id="FR7"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>8교시(16:00-16:50)<br>
										</td>
										<td id="MO8"></td>
										<!-- 월 -->
										<td id="TU8"></td>
										<!-- 화 -->
										<td id="WE8"></td>
										<!-- 수 -->
										<td id="TH8"></td>
										<!-- 목 -->
										<td id="FR8"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>9교시(17:30-18:20)<br>
										</td>
										<td id="MO9"></td>
										<!-- 월 -->
										<td id="TU9"></td>
										<!-- 화 -->
										<td id="WE9"></td>
										<!-- 수 -->
										<td id="TH9"></td>
										<!-- 목 -->
										<td id="FR9"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>10교시(18:25-19:15)<br>
										</td>
										<td id="MO10"></td>
										<!-- 월 -->
										<td id="TU10"></td>
										<!-- 화 -->
										<td id="WE10"></td>
										<!-- 수 -->
										<td id="TH10"></td>
										<!-- 목 -->
										<td id="FR10"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>11교시(19:20-20:10)<br>
										</td>
										<td id="MO11"></td>
										<!-- 월 -->
										<td id="TU11"></td>
										<!-- 화 -->
										<td id="WE11"></td>
										<!-- 수 -->
										<td id="TH11"></td>
										<!-- 목 -->
										<td id="FR11"></td>
										<!-- 금 -->
									</tr>
								</tbody>
							</table>
						</section>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	function operateFormatter(value, row, index) {
		var arrHtml = null;
		console.log(value);
		console.log(row);
		console.log(index);

		if (row.appYn == "Y") { // 신청한 것
			arrHtml = [ '<a class="register" href="javascript:toggleApplicant(\'' + index + '\',\''+row.courseNum+'\')" title="Like">', '<button class="btn btn-sm btn-warning">신청취소</button>',
					'</a>' ]
		} else {
			arrHtml = [ '<a class="register" href="javascript:toggleApplicant(\'' + index + '\',\''+row.courseNum+'\')" title="Like">', '<button class="btn btn-sm btn-info">수강신청</button>',
					'</a>' ]
		}
		console.info(arrHtml.join(''));
		return arrHtml.join('');
	}

	function toggleApplicant(idx, courseNum) {
		$('a.register button').eq(idx).text() == "수강신청" ? insertApplicantModal(idx, courseNum) : deleteApplicantModal(idx, courseNum);
	}
</script>

</gachonTag:html>
