<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>

<gachonTag:script bootstrapTable="YES">
<style>
#toggle {
	cursor: pointer;
}

hr {
	border: 1px solid gray;
	margin: 0 0 2% 0;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	add();	// 페이지 로드 시, 과목 추가하기 처리 담당 함수
	list();	// 페이지 로드 시, 테이블에 리스트 출력
	
	// 익명 즉시실행함수(immediately-invoked function expression)
	// Javascript 대가이신 더글라스 클락포트의 권장 표기법
	(function() {
		
		$('#adminTable').bootstrapTable({
			onClickRow : function(row) {

			}
		}).on('click-row.bs.table', function(e, row, $element) {
			mod(row.courseNum);	// 테이블 리스트 클릭시, mod함수에 courseNum을 parameter로 넘김
		});
		
		/*
	    //Select id=year
		var n = new Date().getFullYear();
		var element = document.getElementById('year');
		for(var i=(n-50);i<n+5;i++){
			console.log(i);
			var option = document.createElement('option');
			option.value=i;
			option.innerHTML=i;
			element.appendChild(option);
		}
		*/
		
	}());
	
});
</script>

<script type="text/javascript">
function list(){		// 리스트 출력
	var dataForm={
		memberId : "${LOGIN_MEMBER.memberId}"
	};
	$.ajax({
		type : "POST",
		url : "/admin/manage_course/list.json", 	// 리스트 값들을 MST에 보여줌 (SELECT_MST)
		cache : false,
		async : false,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			console.log(response);
			$('#adminTable').bootstrapTable('load', response);
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}
</script>

<!-- 생성에 대한 ui를 그린다. 또는 수정에 대한 UI를 그린다.-->
<!-- 1. add mode -->
<script type="text/javascript">
function add() {
	console.log("add함수 실행됨");
	inputTextInit("#courseInfo");
	$("#courseNum").attr("readonly", false);
	
	$("#infoTitle").text("${PAGE.P_MANAGE_COURSE.SUBMIT}");

	$("#posiBtn").text("추가하기");
	document.getElementById('posiBtn').attributes.removeNamedItem("onClick");// onChange이벤트 삭제
	document.getElementById('posiBtn').setAttribute("onClick", "submit();");
	$("#negaBtn").text("다시쓰기");
	document.getElementById('negaBtn').attributes.removeNamedItem("onClick");// onChange이벤트 삭제
	document.getElementById('negaBtn').setAttribute("onClick", "inputTextInit('#courseInfo');");
}
</script>

<!-- 2. modify mode -->
<script type="text/javascript">

function mod(id) {
	console.log("mod함수 실행됨 ["+id+"]=row.courseNum");
	inputTextInit("#courseInfo");
	$("#courseNum").attr("readonly", true);
	
	$("#infoTitle").text("${PAGE.P_MANAGE_COURSE.MODIFY}");
	
	$("#posiBtn").text("수정하기");
	document.getElementById('posiBtn').attributes.removeNamedItem("onClick");// onChange이벤트 삭제
	document.getElementById('posiBtn').setAttribute("onClick", "modify();");
	
	$("#negaBtn").text("삭제하기");
	document.getElementById('negaBtn').attributes.removeNamedItem("onClick");// onChange이벤트 삭제
	document.getElementById('negaBtn').setAttribute("onClick", "deleteCourse();");

	var dataForm={
			courseNum:id
	};
	$.ajax({
		type : "post",
		url : "/admin/manage_course/show.json",		// 리스트에 해당하는 데이터 값들을 상세 DET에 보여줌 (SELECT_DET)
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			if (response.${RESULT_MSG}== "${RESULT_SUCCESS}") {		// 수정하기 모드에서 해당 데이터를 DET 테이블에 뿌려 줌 (response.)
				GachonNoty.showCustomNoty("[${RESULT_SUCCESS}]"+dataForm.courseNum+"과목을 불러왔습니다.");
				console.log(response);
				document.getElementById('courseNum').value=		response.courseNum;
				document.getElementById('courseName').value=	response.courseName;
				document.getElementById('year').value=			response.year;
				document.getElementById('semester').value=		response.semester;
				document.getElementById('college').value=		response.college;
				document.getElementById('completeDivision').value=	response.completeDivision;
				document.getElementById('schoolYear').value=			response.schoolYear;
				document.getElementById('grade').value=					response.grade;
				document.getElementById('professor').value=				response.professor;
				document.getElementById('capacity').value=				response.capacity;
				document.getElementById('cyberYN').value=				response.cyberYN;
				document.getElementById('lecRoom').value=				response.lecRoom;
				document.getElementById('lecTime').value=				response.lecTime;
				document.getElementById('area').value=					response.area;
				document.getElementById('prerequisiteCourse').value=		response.prerequisiteCourse;
				document.getElementById('engineeringAuthentication').value=		response.engineeringAuthentication;
				document.getElementById('summary').value=		response.summary;
				document.getElementById('goal').value=		response.goal;
				document.getElementById('progressWay').value=		response.progressWay;
				document.getElementById('valuationBasis').value=	response.valuationBasis;
				document.getElementById('major').value=		response.major;
				
				
				
			} else if (response.${RESULT_MSG}== "${RESULT_FAIL}") {
				GachonNoty.showCustomNoty("[${RESULT_FAIL}] 로그인을 하고 시도 해 주세요");

			}else{
				GachonNoty.showCustomNoty("사쿠라여 ?");
				inputTextInit("#courseInfo");
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}
</script>


<!-- 수강과목을 추가할지? 수정할지? 처리해주는 부분 -->
<!-- 수강 과목을 추가한다. -->
<script type="text/javascript">
function submit(){
	var dataForm = {
		courseNum					:document.getElementById('courseNum').value,
		courseName					:document.getElementById('courseName').value,
		year						:document.getElementById('year').value,
		semester					:document.getElementById('semester').value,
		college						:document.getElementById('college').value,
		completeDivision			:document.getElementById('completeDivision').value,
		schoolYear					:document.getElementById('schoolYear').value,
		grade						:document.getElementById('grade').value,
		professor					:document.getElementById('professor').value,
		capacity					:document.getElementById('capacity').value,
		cyberYN						:document.getElementById('cyberYN').value,
		lecRoom						:document.getElementById('lecRoom').value,
		lecTime						:document.getElementById('lecTime').value,
		area						:document.getElementById('area').value,
		prerequisiteCourse			:document.getElementById('prerequisiteCourse').value,
		engineeringAuthentication	:document.getElementById('engineeringAuthentication').value,
		summary						:document.getElementById('summary').value,
		goal						:document.getElementById('goal').value,
		progressWay					:document.getElementById('progressWay').value,
		valuationBasis				:document.getElementById('valuationBasis').value,
		major						:document.getElementById('major').value,
		crtUser						:"${LOGIN_MEMBER.memberName}",
		updtUser					:"${LOGIN_MEMBER.memberName}"
	};
	$.ajax({
		type : "post",
		url : "/admin/manage_course/submit.json",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			if (response.${RESULT_MSG}== "${RESULT_SUCCESS}") {
				list();
				GachonNoty.showCustomNoty("[${RESULT_SUCCESS}]"+dataForm.courseName+"과목을 등록 완료 하였습니다.");
			} else if (response.${RESULT_MSG}== "${RESULT_FAIL}") {
				GachonNoty.showCustomNoty("[${RESULT_FAIL}] 로그인을 하고 시도 해 주세요");

			}else{
				GachonNoty.showCustomNoty("사쿠라여 ?");	// ???ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ
				inputTextInit("#courseInfo");
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}
</script>

<!-- 수강 과목을  수정한다. -->
<script type="text/javascript">
function modify(id){
	var dataForm = {
			courseNum					:document.getElementById('courseNum').value,
			courseName					:document.getElementById('courseName').value,
			year						:document.getElementById('year').value,
			semester					:document.getElementById('semester').value,
			college						:document.getElementById('college').value,
			completeDivision			:document.getElementById('completeDivision').value,
			schoolYear					:document.getElementById('schoolYear').value,
			grade						:document.getElementById('grade').value,
			professor					:document.getElementById('professor').value,
			capacity					:document.getElementById('capacity').value,
			cyberYN						:document.getElementById('cyberYN').value,
			lecRoom						:document.getElementById('lecRoom').value,
			lecTime						:document.getElementById('lecTime').value,
			area						:document.getElementById('area').value,
			prerequisiteCourse			:document.getElementById('prerequisiteCourse').value,
			engineeringAuthentication	:document.getElementById('engineeringAuthentication').value,
			summary						:document.getElementById('summary').value,
			goal						:document.getElementById('goal').value,
			progressWay					:document.getElementById('progressWay').value,
			valuationBasis				:document.getElementById('valuationBasis').value,
			major						:document.getElementById('major').value,
			crtUser						:"${LOGIN_MEMBER.memberName}",
			updtUser					:"${LOGIN_MEMBER.memberName}"
	};
	$.ajax({
		type : "post",
		url : "/admin/manage_course/modify.json",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			if (response.${RESULT_MSG}== "${RESULT_SUCCESS}") {
				list();
				GachonNoty.showCustomNoty("[${RESULT_SUCCESS}]"+dataForm.courseName+"과목수정을 완료 하였습니다.");
			} else if (response.${RESULT_MSG}== "${RESULT_FAIL}") {
				GachonNoty.showCustomNoty("[${RESULT_FAIL}] 로그인을 하고 시도 해 주세요");
			}else{
				GachonNoty.showCustomNoty("사쿠라여 ?");
				inputTextInit("#courseInfo");
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}
</script>


<!-- 수강 과목을 삭제한다. -->
<script type="text/javascript">
function deleteCourse(){
	var dataForm = {
		courseNum					:document.getElementById('courseNum').value
	};
	$.ajax({
		type : "post",
		url : "/admin/manage_course/delete.json",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			if (response.${RESULT_MSG}== "${RESULT_SUCCESS}") {
				list();
				GachonNoty.showCustomNoty("[${RESULT_SUCCESS}]"+dataForm.courseNum+"과목삭제를 완료 하였습니다.");
				inputTextInit("#courseInfo");
			} else if (response.${RESULT_MSG}== "${RESULT_FAIL}") {
				GachonNoty.showCustomNoty("[${RESULT_FAIL}] 로그인을 하고 시도 해 주세요");
			}else{
				GachonNoty.showCustomNoty("사쿠라여 ?");
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}
</script>

</gachonTag:script>


<body>
	<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<div class="page_title">${PAGE.P_MANAGE_COURSE.TITLE}</div>
		<hr />
		<div class="table-responsive">
			<table id="adminTable" data-toggle="table" data-url="#"
				data-show-columns="true" data-search="true" data-show-refresh="true"
				data-show-toggle="false" data-show-export="true"
				data-pagination="true">
				<thead class="row">
					<tr>
						<th data-field="courseNum" class="text_center tr-padding-2">
							${PAGE.P_MANAGE_COURSE.COURSE_NUM}</th>
						<th data-field="courseName" class="text_center">
							${PAGE.P_MANAGE_COURSE.COURSE_NAME}</th>
						<th data-field="year" class="text_center">
							${PAGE.P_MANAGE_COURSE.YEAR}</th>
						<th data-field="area_nm" class="text_center">
							${PAGE.P_MANAGE_COURSE.AREA}</th>
						<th data-field="completeDivision_nm" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.COMPLETE_DIVISION}</th>
						<th data-field="grade" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.GRADE}</th>
						<th data-field="professor" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.PROFESSOR}</th>
						<th data-field="lecTime" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.LEC_TIME}</th>
						<th data-field="lecRoom" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.LEC_ROOM}</th>
						<th data-field="major" class="col-sm-3 text_center">
							${PAGE.P_MANAGE_COURSE.MAJOR}</th>
					</tr>
				</thead>
			</table>
		</div>
		<br/>
		<button class="btn btn-info" onclick="add();">추가하기</button>

		<div id="courseInfo" class="well" style="margin-top: 2em;">
			<div id="infoTitle" class="page_title"></div>
			<hr />
			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.COURSE_NUM}</div>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="courseNum">
									
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.COURSE_NAME}</div>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="courseName">
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.YEAR}</div>
								<div class="col-sm-8">
									<select class="form-control" id="year">
										<c:forEach items="${PAGE.YEAR}" var="list">
										<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
									
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.SEMESTER}</div>
								<div class="col-sm-8">
									<select class="form-control" id="semester">
										<c:forEach items="${PAGE.SEMESTER}" var="list">
										<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.COLLEGE}</div>
								<div class="col-sm-8">
									<select id="college" class="form-control">
										<c:forEach items="${PAGE.COLLEGE}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.COMPLETE_DIVISION}</div>
								<div class="col-sm-8">
									<select id="completeDivision" class="form-control">
										<c:forEach items="${PAGE.COMPLETE_DIVISION}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>



				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.SCHOOL_YEAR}</div>
								<div class="col-sm-8">
									<gachonTag:select code="${SCHOOL_YEAR}" id="schoolYear" required="required" />
									
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.GRADE}</div>
								<div class="col-sm-8">
									<gachonTag:select code="${GRADE}" id="grade" required="required" />
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>



			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.PROFESSOR}</div>
								<div class="col-sm-8">
									<input type="text" id="professor" class="form-control">
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.CAPACITY}</div>
								<div class="col-sm-8">
									<input type="text" id="capacity" class="form-control">
								</div>
							</div>
						</div>
					</div>
				</div>



				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-2 text-center attr_name">${PAGE.P_MANAGE_COURSE.LEC_TIME}</div>
						<div class="col-sm-10">
							<input type="text" id="lecTime" class="form-control">
						</div>
					</div>
				</div>
			</div>


			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.PREREQUISITE_COURSE}</div>
								<div class="col-sm-8">
									<input type="text" id="prerequisiteCourse" class="form-control">
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.MAJOR}</div>
								<div class="col-sm-8">
									<select id="major" class="form-control">
										<c:forEach items="${PAGE.MAJOR}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.CYBER_YN}</div>
								<div class="col-sm-8">
									<select id="cyberYN" class="form-control">
										<c:forEach items="${PAGE.USE_YN}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.LEC_ROOM}</div>
								<div class="col-sm-8">
									<input type="text" id="lecRoom" class="form-control">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.AREA}</div>
								<div class="col-sm-8">
									<select id="area" class="form-control">
										<c:forEach items="${PAGE.AREA}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>

						<div class="col-sm-6">
							<div class="row">
								<div class="col-sm-4 text-center attr_name">${PAGE.P_MANAGE_COURSE.ENGINEERING_AUTH}</div>
								<div class="col-sm-8">
									<select id="engineeringAuthentication" class="form-control">
										<c:forEach items="${PAGE.USE_YN}" var="list">
											<option value="${list.CODE}">${list.CODE_NAME}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-sm-6">&nbsp;</div>
			</div>



			<div class="row form-group">
				<div class="col-sm-1 attr_name">${PAGE.P_MANAGE_COURSE.SUMMARY}</div>
				<div class="col-sm-11">
					<textarea id="summary" class="form-control" rows="5"></textarea>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1 attr_name">${PAGE.P_MANAGE_COURSE.GOAL}</div>
				<div class="col-sm-11">
					<textarea id="goal" class="form-control" rows="5"></textarea>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1 attr_name">${PAGE.P_MANAGE_COURSE.PROGRESS_WAY}</div>
				<div class="col-sm-11">
					<textarea id="progressWay" class="form-control" rows="5"></textarea>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-sm-1 attr_name">${PAGE.P_MANAGE_COURSE.VALUATION_BASIS}</div>
				<div class="col-sm-11">
					<textarea id="valuationBasis" class="form-control" rows="5"></textarea>
				</div>
			</div>


			<div class="row form-group">&nbsp;</div>


			<div class="row form-group">
				<div class="col-sm-4">&nbsp;</div>
				<div class="col-sm-4">
					<div class="row">
						<button class="col-sm-5 btn btn-warning" id="negaBtn" onClick=""></button>
						<div class="col-sm-2">&nbsp;</div>
						<button class="col-sm-5 btn btn-success" id="posiBtn" onClick=""></button>
					</div>
				</div>
				<div class="col-sm-4">&nbsp;</div>
			</div>
		</div>
	</div>
</body>
</gachonTag:html>