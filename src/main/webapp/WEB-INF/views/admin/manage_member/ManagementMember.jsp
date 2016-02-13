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

<!-- Ajax 관련 자바 스크립트 -->
<script type="text/javascript">
	function listIdInfomation() {
		$.ajax({
			type : "POST",
			url : "/admin/manage_member/list.json",
			cache : false,
			async : true,
			dataType : "JSON",
			success : function(response) {
				$('#adminTable').bootstrapTable('load', response);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	//새로운 사용자를 추가합니다.
	function addIdInfomation() {
		var dataForm = {
			memberId : document.getElementById("memberId_add").value,
			memberName : document.getElementById("memberName_add").value,
			password : document.getElementById("password_add").value,
			memberType : document.getElementById("memberType_add").value,
			department : document.getElementById("department_add").value,
			year : document.getElementById("year_add").value,
			joinFromDate : " ",
			closeYesNo : document.getElementById("closeYesNo_add").value,
			closeReason : document.getElementById("closeReason_add").value,
			college : document.getElementById("college_add").value,
			schoolYear : document.getElementById("schoolYear_add").value,
			major : document.getElementById("major_add").value,
			//year : document.getElementById("year").value,
			schoolYear : document.getElementById("schoolYear").value,
			completeTerm : document.getElementById("completeTerm_add").value,
			collegeStatus : document.getElementById("collegeStatus_add").value,
			birthDate : document.getElementById("birthDate_add").value,
			postalCode : document.getElementById("postalCode_add").value,
			address : document.getElementById("address_add").value,

			phone : document.getElementById("phone_1_add").value + "-"
					+ document.getElementById("phone_2_add").value + "-"
					+ document.getElementById("phone_3_add").value,

			phone2 : document.getElementById("phone2_1_add").value + "-"
					+ document.getElementById("phone2_2_add").value + "-"
					+ document.getElementById("phone2_3_add").value,

			mobile : document.getElementById("mobile_1_add").value + "-"
					+ document.getElementById("mobile_2_add").value + "-"
					+ document.getElementById("mobile_3_add").value,
			email : document.getElementById("email_add").value,
			profileImagePath : "resources/image/i.PNG",
			createUser : "${sessionScope.LOGIN_MEMBER.memberName}",
			createPath : " ",
			updateUser : "${sessionScope.LOGIN_MEMBER.memberName}",
			updatePath : ""
		};

		$.ajax({
			type : "POST",
			url : "/admin/manage_member/add.dao",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "JSON",

			success : function(response) {
				if (response.RESULT_MSG == "${RESULT_SUCCESS}") {
					listIdInfomation();//리스트를 다시 출력합니다
					GachonNoty.showCustomNoty("[학번:" + dataForm.memberId + "] \n [이름"
							+ dataForm.memberName + "]\n 회원을 등록완료하였습니다.");
					inputTextInit("#newMember");
				} else if (response.RESULT_MSG == "${RESULT_FAIL}") {
					GachonNoty.showCustomNoty("[학번:" + dataForm.memberId + "] \n [이름"
					      + dataForm.memberName + "]\n 회원등록에 실패하였습니다.");
				} else {
					GachonNoty.showCustomNoty("회원등록에 실패하였습니다.");
				}
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	// 첫회 보여주기
	function showIdInfomation(id) {
		$("#modal select").attr("readonly",true);
		console.log(id);
		dataForm = {
			memberId : id
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_member/show.json",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "JSON",

			success : function(response) {
				if (response.result == "${RESULT_SUCCESS}") {
					$("#modal").modal('show');
					console.log(response);
					$("#img").attr('src',"/"+response.profileImagePath);
					document.getElementById("memberId").value = response.memberId;
					document.getElementById("memberName").value = response.memberName;
					document.getElementById("password").value = response.password;
					document.getElementById("memberType").value = response.memberType;
					document.getElementById("closeYesNo").value = response.closeYesNo;
					document.getElementById("closeReason").value = response.closeReason;
					document.getElementById("college").value = response.college;
					document.getElementById("department").value = response.department;
					console.info(response.department + "****");
					document.getElementById("year").value = response.year;
					console.info(response.year + "****");
					document.getElementById("schoolYear").value = response.schoolYear;
					document.getElementById("major").value = response.major;
					document.getElementById("completeTerm").value = response.completeTerm;
					document.getElementById("collegeStatus").value = response.collegeStatus;
					document.getElementById("birthDate").value = response.birthDate;
					document.getElementById("postalCode").value = response.postalCode;
					document.getElementById("address").value = response.address;
					document.getElementById("year").value = response.year;
					document.getElementById("schoolYear").value = response.schoolYear;
					
					var phone = response.phone.split("-");

					document.getElementById("phone_1").value = phone[0];
					document.getElementById("phone_2").value = phone[1];
					document.getElementById("phone_3").value = phone[2];

					var phone2 = response.phone2.split("-");

					document.getElementById("phone2_1").value = phone2[0];
					document.getElementById("phone2_2").value = phone2[1];
					document.getElementById("phone2_3").value = phone2[2];

					var mobile = response.mobile.split("-");

					document.getElementById("mobile_1").value = mobile[0];
					document.getElementById("mobile_2").value = mobile[1];
					document.getElementById("mobile_3").value = mobile[2];

					document.getElementById("email").value = response.email;
				} else {
					GachonNoty.showCustomNoty("시방 사쿠라여?");
				}
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showCustomNoty(request + "/" + status + "/" + errorThrown
						+ "입니당.");
				console.log(request + "\n" + status + "\n"
						+ errorThrown + "입니당.");
				console.log(request);
				console.log(status);
				console.log(errorThrown);
			}
		});
	}

	//수정을 눌렀을때 .
	function modifyIdInfomation() {
		if ($("#modal input").attr("readonly")) {

			$("#modal input").attr("readonly", false);
			$("#modal select").attr("readonly", false);

			$("#modal #modify").removeClass("btn-info").addClass("btn-success");
			$("#modal #modify").html("수정완료");
			$("#modifyImage").show();
		} else {
			$("#modal #modify").attr("data-dismiss", "modal");
			var dataForm = {
				memberId : document.getElementById("memberId").value,
				memberName : document.getElementById("memberName").value,
				password : document.getElementById("password").value,
				memberType : document.getElementById("memberType").value,
				department : document.getElementById("department").value,
				year : document.getElementById("year").value,
				
				joinFromDate : " ",
				closeYesNo : document.getElementById("closeYesNo").value,
				closeReason : document.getElementById("closeReason").value,
				college : document.getElementById("college").value,
				schoolYear : document.getElementById("schoolYear").value,
				major : document.getElementById("major").value,
				//year : document.getElementById("year").value,
				schoolYear : document.getElementById("schoolYear").value,
				completeTerm : document.getElementById("completeTerm").value,
				collegeStatus : document.getElementById("collegeStatus").value,
				birthDate : document.getElementById("birthDate").value,
				postalCode : document.getElementById("postalCode").value,
				address : document.getElementById("address").value,

				phone : document.getElementById("phone_1").value + "-"
						+ document.getElementById("phone_2").value + "-"
						+ document.getElementById("phone_3").value,

				phone2 : document.getElementById("phone2_1").value + "-"
						+ document.getElementById("phone2_2").value + "-"
						+ document.getElementById("phone2_3").value,

				mobile : document.getElementById("mobile_1").value + "-"
						+ document.getElementById("mobile_2").value + "-"
						+ document.getElementById("mobile_3").value,
				email : document.getElementById("email").value,
				profileImagePath : "resources/image/i.PNG",
				
				updateUser : "${sessionScope.LOGIN_MEMBER.memberName}",
				updateDate : ""
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_member/modify.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				complete : function() {
				},

				success : function(response) {
					console.log('modifyInfomation--success');
					console.log(response);
					if (response.RESULT_MSG == "${RESULT_SUCCESS}") {
						GachonNoty.showCustomNoty(dataForm.memberName
								+ "님의 회원정보를 \n 수정 완료하였습니다. ");
						listIdInfomation();
						$("#modal").modal('hide')
					} else if (response.RESULT_MSG == "${RESULT_FAIL}") {
						GachonNoty.showCustomNoty(dataForm.memberName
								+ "님의 회원정보를 \n 수정 실패하였습니다. ");
					
						listIdInfomation();
					} else {
						GachonNoty.showCustomNoty(response.RESULT_MSG);
						listIdInfomation();
					}

				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	}

	//해당 멤버 데이터삭제~!!
	function deleteIdInfomation() {
		var dataForm = {memberId: document.getElementById("memberId").value};
		$.ajax({
			type : "POST",
			url : "/admin/manage_member/delete.json",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			success : function(response) {
				GachonNoty.showResultNoty("첫번째 인자", response.${RESULT_MSG});
				listIdInfomation();
				$('#modal').modal('hide');
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	//console.log(response.responseText);
	//코어자바스크립트는 responseHeader 하고 responseText
	//var ary = JSON.parse(response); 여기서 에러가 나네용! 이미 json인 response 를 json 으로 다시 하려고해서	
	//에러를 발생기키는대 이거 풀면 자바스크립트 전체 먹통됨.
	//var obj = ary[0];

	//코어 ajax 는 response에 헤더와 바디(text)가 나누어져 있는데 
	//jquery는 response 객체 자체가 그냥 코저 ajax의 responseText 이다. 
	//	console.log(response);
	//	console.log(response[0]);
</script>
</gachonTag:script>
<body>
	<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<div class="page_title">회원관리</div>
		<hr />
		<div class="table-responsive">
			<table id="adminTable" data-toggle="table" data-show-columns="true"
				data-search="true" data-show-refresh="true" data-show-toggle="false"
				data-show-export="true" data-pagination="true">
				<thead class="row">
					<tr>
						<th data-field="memberId" class="text_center">학번</th>
						<th data-field="memberName" class="text_center">회원 이름</th>
						<th data-field="memberType_nm" class="text_center">회원 구분</th>
						<th data-field="closeYesNo" class="text_center">잠금 여부</th>
						<th data-field="college_nm" class="text_center">소속 대학</th>
						<th data-field="schoolYear_nm" class="text_center">학년</th>
						<th data-field="major_nm" class="text_center">전공</th>
					</tr>
				</thead>
			</table>
		</div>

		<!-- Modal : 사용자공통 모달 -->
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
							style="font-weight: bold;">회원 정보 보기</h4>
					</div>

					<div id="showMemberModal" class="modal-body">
						<div class="row form-group">
							<div class="col-sm-5">
								<div class="row">
									<div class="attr_name text-center">회원사진</div>
									<img id="img" height="290px" class="col-sm-12" />
								</div>
								<button id="modifyImage" type="button" onclick="uploadImage();"
									style="display: none;" class="col-xs-12 btn btn-success">
									업로드</button>
							</div>
							<div class="col-sm-7" style="padding-top: 3em;">
								<div class="row form-group">
									<div class="col-sm-4 attr_name text-center">회원 학번</div>
									<div class="col-sm-8">
										<input type="text" id="memberId" class="form-control" readonly />
									</div>
								</div>
								<div class="row form-group">
									<div class="col-sm-4 attr_name text-center">회원 이름</div>
									<div class="col-sm-8">
										<input type="text" id="memberName" class="form-control"
											readonly />
									</div>
								</div>
								<div class="row form-group">
									<div class="col-sm-4 attr_name text-center">비밀번호</div>
									<div class="col-sm-8">
										<input type="password" id="password" class="form-control"
											readonly />
									</div>
								</div>
								<div class="row form-group">
									<div class="col-sm-4 attr_name text-center">생년월일</div>
									<div class="col-sm-8">
										<input type="date" id="birthDate" class="form-control"
											readonly />
									</div>
								</div>
								
							</div>
						</div>
						<div class="row form-group">
							
							<div class="col-sm-2 attr_name text-center">전화번호1</div>
							<div class="col-sm-10">
								<div class="row">
									<div class="col-sm-4">
										<gachonTag:select id="phone_1" code="${TEL}"  className="attr_name"  required="required"/>
									</div>
									<div class="col-sm-4">
										<input type="text" id="phone_2" class="form-control"
											readonly />
									</div>
									<div class="col-sm-4">
										<input type="text" id="phone_3" class="form-control"
											readonly />
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group">
							<div class="col-sm-2 attr_name text-center">전화번호2</div>
							<div class="col-sm-10">
								<div class="row">
									<div class="col-sm-4">
										<gachonTag:select id="phone2_1" code="${TEL}" className="attr_name"  required="required"/>
					
									</div>
									<div class="col-sm-4">
										<input type="text" id="phone2_2" class="form-control"
											readonly />
									</div>
									<div class="col-sm-4">
										<input type="text" id="phone2_3" class="form-control"
											readonly />
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group">
							<div class="col-sm-2 attr_name text-center">핸드폰</div>
							<div class="col-sm-10">
								<div class="row">
									<div class="col-sm-4">
										<gachonTag:select id="mobile_1" code="${PHONE}" className="attr_name"  required="required"/>
									</div>
									<div class="col-sm-4">
										<input type="text" id="mobile_2" class="form-control"
											readonly />
									</div>
									<div class="col-sm-4">
										<input type="text" id="mobile_3" class="form-control"
											readonly />
									</div>
								</div>
							</div>
						</div>
						<div class="row form-group">
							<div class="col-sm-2 attr_name text-center">이메일</div>
							<div class="col-sm-10">
								<input type="text" id="email" class="form-control" readonly />
							</div>
						</div>
						
						
						<div class="row form-group">
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">단과 대학</div>
									<div class="col-sm-8">
										<gachonTag:select id="department" code="${DEPARTMENT}" onChange="majorFilter();" className="attr_name"  required="required"/>
									</div>
								</div>
							</div>
							
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">학과/부</div>
									<div class="col-sm-8">
										<gachonTag:select id="major" code="${MAJOR}" className="attr_name" required="required"/>
									</div>
								</div>
							</div>
						</div>
						
						<div class="row form-group">
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">회원 구분</div>
									<div class="col-sm-8">
										<gachonTag:select id="memberType" code="${MEMBER_TYPE}" className="attr_name"   required="required"/>

											
									</div>
								</div>

							</div>
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">소속대학</div>
									<div class="col-sm-8">
										<gachonTag:select id="college" code="${COLLEGE}" className="attr_name"   required="required"/>
									</div>
								</div>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">학년</div>
									<div class="col-sm-8">
										<gachonTag:select id="schoolYear" code="${SCHOOL_YEAR}" className="attr_name" required="required"/>
									</div>
								</div>
							</div>
						</div>


						
						<div class="row form-group">
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">학적 상태</div>
									<div class="col-sm-8">
										<gachonTag:select id="collegeStatus" code="${COLLEGE_STATUS}" className="attr_name" required="required"/>
									</div>
								</div>
							</div>

							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">이수학기</div>
									<div class="col-sm-8">
										<gachonTag:select id="completeTerm" code="${COMPLETE_TERM}" className="attr_name" required="required"/>
									</div>
								</div>
							</div>
							
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">입학 년도</div>
									<div class="col-sm-8">
										<gachonTag:select id="year" code="${YEAR}" className="attr_name"  required="required"/>
									
									</div>
								</div>
							</div>
							<div class="col-sm-4">&nbsp;</div>
						</div>

						<div class="row form-group">
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">잠금 여부</div>
									<div class="col-sm-8">
										<gachonTag:select id="closeYesNo" code="${USE_YN}" className="attr_name" required="required"/>
										
									</div>
								</div>
							</div>
							<div class="col-sm-8">
								<div class="row">
									<div class="col-sm-2 attr_name text-center">잠금 사유</div>
									<div class="col-sm-10">
										<input type="text" id="closeReason" class="form-control"
											readonly />
									</div>
								</div>
							</div>
						</div>

						<div class="row form-group">
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-4 attr_name text-center">우편 번호</div>
									<div class="col-sm-8">
										<input type="text" id="postalCode" class="form-control"
											readonly />
									</div>
								</div>

							</div>
							<div class="col-sm-8">
								<div class="row">
									<div class="col-sm-2 attr_name text-center">상세 주소</div>
									<div class="col-sm-10">
										<input type="text" id="address" class="form-control" readonly />
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="modal-footer" style="text-align: center;">
						<button type="button" onclick="deleteIdInfomation();"
							class="btn btn-warning" data-dismiss="modal">삭제하기</button>
						<button type="button" id="modify" class="btn btn-info"
							onclick="modifyIdInfomation();">수정하기</button>
					</div>
				</div>
			</div>
		</div>

		<div class="row form-group">
			<div class="col-xs-4">
				<div class="col-xs-6">
					<button onclick="submitMember();" type="button"
						class="btn btn-info">회원 삽입</button>
				</div>
				<div class="col-xs-6">&nbsp;</div>
			</div>
			<div class="col-xs-4">&nbsp;</div>
			<div class="col-xs-4">&nbsp;</div>
		</div>



		<div id="newMember" class="well" style="display: none;">
			<div class="row form-group">
				<div class="col-sm-6">
					<div class="row form-group">
						<div class="attr_name text-center">회원사진</div>
						<img src="${PATH_IMAGES}/i.PNG" width="200px" height="100px"
							class="col-sm-12 img-responsive img-thumbnail" />
					</div>
					<button type="button" onclick="uploadImage();"
						class="col-xs-12 btn btn-success">업로드</button>

				</div>
				<div class="col-sm-6" style="padding-top: 3em;">
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">회원 학번</div>
						<div class="col-sm-8">
							<input type="text" id="memberId_add" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">회원 이름</div>
						<div class="col-sm-8">
							<input type="text" id="memberName_add" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">비밀번호</div>
						<div class="col-sm-8">
							<input type="password" id="password_add" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">생년월일</div>
						<div class="col-sm-8">
							<input type="date" id="birthDate_add" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">전화번호1</div>
						<div class="col-sm-8">
							<div class="row">
								<div class="col-sm-4">
									<gachonTag:select id="phone_1_add" code="${TEL}" required="required"/>
									
								</div>
								<div class="col-sm-4">
									<input type="text" id="phone_2_add" class="form-control" />
								</div>
								<div class="col-sm-4">
									<input type="text" id="phone_3_add" class="form-control" />
								</div>
							</div>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">전화번호2</div>
						<div class="col-sm-8">
							<div class="row">
								<div class="col-sm-4">
									<gachonTag:select id="phone2_1_add" code="${TEL}" required="required"/>
								</div>
								<div class="col-sm-4">
									<input type="text" id="phone2_2_add" class="form-control" />
								</div>
								<div class="col-sm-4">
									<input type="text" id="phone2_3_add" class="form-control" />
								</div>
							</div>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">핸드폰</div>
						<div class="col-sm-8">
							<div class="row">
								<div class="col-sm-4">
									<gachonTag:select id="mobile_1_add" code="${PHONE}" required="required"/>
									
								</div>
								<div class="col-sm-4">
									<input type="text" id="mobile_2_add" class="form-control" />
								</div>
								<div class="col-sm-4">
									<input type="text" id="mobile_3_add" class="form-control" />
								</div>
							</div>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name text-center">이메일</div>
						<div class="col-sm-8">
							<input type="text" id="email_add" class="form-control" />
						</div>
					</div>
				</div>
			</div>

			<div class="row form-group">
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">회원 구분</div>
						<div class="col-sm-8">
							<gachonTag:select id="memberType_add" code="${MEMBER_TYPE}" required="required"/>
							
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">소속대학</div>
						<div class="col-sm-8">
							<gachonTag:select id="college_add" code="${COLLEGE}" required="required"/>
							
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">학년</div>
						<div class="col-sm-8">
							<gachonTag:select id="schoolYear_add" code="${SCHOOL_YEAR}" required="required"/>
					
						</div>
					</div>
				</div>
			</div>

			<div class="row form-group">
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">단과 대학</div>
						<div class="col-sm-8">
							<gachonTag:select id="department_add" code="${DEPARTMENT}" onChange="majorFilter_add();" required="required"/>
						</div>
					</div>
				</div>
				
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">학과/학부</div>
						<div class="col-sm-8">
							<gachonTag:select id="major_add" code="${MAJOR}" required="required"/>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row form-group">
				
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">입학 년도</div>
						<div class="col-sm-8">
							<gachonTag:select id="year_add" code="${YEAR}" required="required"/>
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">학적 상태</div>
						<div class="col-sm-8">
							<gachonTag:select id="collegeStatus_add" code="${COLLEGE_STATUS}" required="required"/>
						</div>
					</div>
				</div>

				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">이수학기</div>
						<div class="col-sm-8">
							<gachonTag:select id="completeTerm_add" code="${COMPLETE_TERM}" required="required"/>
							
						</div>
					</div>
				</div>
<!-- 				<div class="col-sm-4">&nbsp;</div> -->
			</div>


			<div class="row form-group">
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">잠금 여부</div>
						<div class="col-sm-8">
							<gachonTag:select id="closeYesNo_add" code="${USE_YN}" required="required"/>
							
						</div>
					</div>

				</div>
				<div class="col-sm-8">
					<div class="row">
						<div class="col-sm-2 attr_name text-center">잠금 사유</div>
						<div class="col-sm-10">
							<input type="text" id="closeReason_add" class="form-control" />
						</div>
					</div>
				</div>
			</div>

			<div class="row form-group">
				<div class="col-sm-4">
					<div class="row">
						<div class="col-sm-4 attr_name text-center">우편 번호</div>
						<div class="col-sm-8">
							<input type="text" id="postalCode_add" class="form-control" />
						</div>
					</div>

				</div>
				<div class="col-sm-8">
					<div class="row">
						<div class="col-sm-2 attr_name text-center">상세 주소</div>
						<div class="col-sm-10">
							<input type="text" id="address_add" class="form-control" />
						</div>
					</div>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-xs-4">&nbsp;</div>
				<div class="col-xs-4">
					<button class="col-xs-6 btn btn-warning">입력취소</button>
					<button class="col-xs-6 btn btn-success"
						onclick="addIdInfomation();">등록하기</button>
				</div>
				<div class="col-xs-4">&nbsp;</div>
			</div>
		</div>
	</div>

	<!-- UI관련 자바스크립트 -->

	<script type="text/javascript">
		$(document).ready(function() {
			listIdInfomation();
			checkForm($("#memberId_add"), 1, 9, "number"); //col1
			checkForm($("#memberName_add"), 2, 10, "text"); //col2
			checkForm($("#password_add"), 1, 64, "noneKr"); //col3
			checkForm($("#memberType_add"), 1, 3, "noneKr"); //col4
			checkForm($("#department_add"), 1, 20, "noneKr"); //col4
			checkForm($("#year_add"), 1, 20, "noneKr"); //col4
			//가입일								//col5
			checkForm($("#closeReason_add"), 1, 66, "text"); //col7
			checkForm($("#postalCode_add"), 1, 7, "text"); //col14
			checkForm($("#address_add"), 1, 30, "text"); //col15
			checkForm($("#phone_2_add"), 1, 4, "number"); //col16
			checkForm($("#phone_3_add"), 1, 4, "number"); //col16
			checkForm($("#phone2_2_add"), 1, 4, "number"); //col17
			checkForm($("#phone2_3_add"), 1, 4, "number"); //col17
			checkForm($("#mobile_2_add"), 1, 4, "number"); //col18
			checkForm($("#mobile_3_add"), 1, 4, "number"); //col18
			checkForm($("#email_add"), 1, 50, "text"); //col19
			//이미지 처리..							//col20
			//col 21 22 23 24 세션 데이터 처리	
			//---------------------------------------------------------
			//---------------------------------------------------------

			checkForm($("#memberId"), 8, 9, "number"); //col1
			checkForm($("#memberName"), 2, 10, "text"); //col2
			checkForm($("#password"), 8, 64, "noneKo"); //col3
			checkForm($("#memberType"), 1, 3, "noneKo"); //col4
			checkForm($("#department"), 1, 20, "noneKr"); //col4
			checkForm($("#year"), 1, 20, "noneKr"); //col4
			//가입일								//col5
			checkForm($("#closeYesNo"), 1, 1, "text"); //col6
			checkForm($("#closeReason"), 1, 66, "text"); //col7
			checkForm($("#college"), 1, 5, "text"); //col8
			checkForm($("#schoolYear"), 1, 5, "text"); //col9
			checkForm($("#major"), 1, 5, "text"); //col10
			checkForm($("#completeTerm"), 1, 1, "noneKo"); //col11
			checkForm($("#collegeStatus"), 1, 1, "noneKo"); //col12		
			checkForm($("#birthDate"), 1, 15, "noneKo"); //col13
			checkForm($("#postalCode"), 1, 7, "text"); //col14
			checkForm($("#address"), 4, 17, "text"); //col15
			checkForm($("#phone_1"), 1, 4, "number"); //col16
			checkForm($("#phone_2"), 1, 4, "number"); //col16
			checkForm($("#phone_3"), 1, 4, "number"); //col16
			checkForm($("#phone2_1"), 1, 4, "number"); //col17
			checkForm($("#phone2_2"), 1, 4, "number"); //col17
			checkForm($("#phone2_3"), 1, 4, "number"); //col17
			checkForm($("#mobile_1"), 1, 4, "number"); //col18
			checkForm($("#mobile_2"), 1, 4, "number"); //col18
			checkForm($("#mobile_3"), 1, 4, "number"); //col18
			checkForm($("#email"), 1, 50, "text"); //col19
			//이미지 처리..							//col20
			//col 21 22 23 24 세션 데이터 처리				

		});
		function submitMember() {
			$("#newMember").slideToggle();
		}
		$(function() {
			$('#adminTable').bootstrapTable({
				onClickRow : function(row) {

				}
			}).on('click-row.bs.table', function(e, row, $element) {
				showIdInfomation(row.memberId);
			});

			// 삭제
			$("#modal").on(
					'hidden.bs.modal',
					function() {
						inputTextInit("#modal");
						$("#modal input").attr("readonly", true);
						$("#modal select").attr("readonly", true);
						$("#modal #modify").removeClass("btn-success")
								.addClass("btn-info");
						$("#modal #modify").removeAttr("data-dismiss");
						$("#modal #modify").html("수정하기");
						$("#modifyImage").hide();
					});
		});
		
		function majorFilter() {

			var dataForm = {
				grcode : 'MAJOR',			// 이 key 값에 해당하는 value는 무엇인가? MAJOR
				code : $("#department option:selected").val()
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
					$('#major').html('');	// 기존 Label값 지워주고
					
// 					for (var i = 0; i < response.length; i++) {
// 						$('#otherMajor').append('<option value='+response[i].value + '>' + response[i].label + '</option>');
// 					}
					
					$.each(response, function(index, code) {	// index, code -> value, label
						// response 크기만큼 반복하는데 function 파라미터로 value와 label을 가져옴.
						// 조금 더 분석 필요;; <option> </option> 문법을 전체 append한다...?
						// for문 대신 .each
						$('#major').append('<option value='+code.value + '>' + code.label + '</option>');
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		function majorFilter_add() {

			var dataForm = {
				grcode : 'MAJOR',			// 이 key 값에 해당하는 value는 무엇인가? MAJOR
				code : $("#department_add option:selected").val()
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
					$('#major_add').html('');	// 기존 Label값 지워주고
					
// 					for (var i = 0; i < response.length; i++) {
// 						$('#otherMajor').append('<option value='+response[i].value + '>' + response[i].label + '</option>');
// 					}
					
					$.each(response, function(index, code) {	// index, code -> value, label
						// response 크기만큼 반복하는데 function 파라미터로 value와 label을 가져옴.
						// 조금 더 분석 필요;; <option> </option> 문법을 전체 append한다...?
						// for문 대신 .each
						$('#major_add').append('<option value='+code.value + '>' + code.label + '</option>');
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		
	</script>

</body>
</gachonTag:html>