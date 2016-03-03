<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>

<gachonTag:script/>
<body>

	<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

	<gachonTag:navBar/>

<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>


<script>
	//초기 로드 테이블
	$(document).ready(function() {
		selectHomeInfo();
	});
	
	function selectHomeInfo() {

		var dataForm = {
			memberId : "${sessionScope.LOGIN_MEMBER.memberId}"
		};
		$.ajax({
			type : "POST",
			url : "/home.select",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				var route = "";
				
				document.getElementById("memberType_nm").value = response[0].memberType_nm;
				document.getElementById("college_nm").value = response[0].college_nm;
				document.getElementById("department_nm").value = response[0].department_nm;
				document.getElementById("major_nm").value = response[0].major_nm;
				document.getElementById("memberName").value = response[0].memberName;
				document.getElementById("memberId").value = response[0].memberId;
				document.getElementById("completeTerm_nm").value = response[0].completeTerm_nm;
				document.getElementById("schoolYear_nm").value = response[0].schoolYear_nm;
				document.getElementById("collegeStatus_nm").value = response[0].collegeStatus_nm;
				document.getElementById("birthDate").value = response[0].birthDate;
				document.getElementById("phone").value = response[0].phone;
				document.getElementById("mobile").value = response[0].mobile;

				route = "<img style='width: 250px; height:280px; float:left; margin:1% 3% 1% 6%' src="+ "/" + response[0].profileImgPath+"/>"
				$('#profile').html(route);
				
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
</script>



<div class="container">
	<div class="page_title">가천대학교</div>

	<div class="row">
		<div class="well">
			<div class="row">
				<div class="col-sm-3 container">
					<div id="profile"></div>	 
						 
					<button type="file" class="col-sm-11 btn btn-success"
						style="width: 96%; margin-top: 1em; margin-left: 1em; margin-right: 1em;">사진
						선택</button>
				</div>
				<div class="col-sm-9">
					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name">회원구분</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="memberType_nm" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">소속 대학</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="college_nm" readonly />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">단과대학</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="department_nm" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">학과</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="major_nm" readonly />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">이름</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="memberName" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">학번</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="memberId" readonly />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">학년</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="schoolYear_nm" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">이수 학기</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="completeTerm_nm" readonly />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name">학적 상태</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="collegeStatus_nm" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">생년 월일</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="birthDate" readonly />
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name">전화 번호</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="phone" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name">핸드폰 번호</div>
							<div class="col-sm-7  input-group">
								<input type="text" class="form-control" id="mobile"	readonly />
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<!-- 태수형 꺼  -->
		<div class="col-sm-6 col-md-3 container">
			<ul class="list-group">
				<li class="list-group-item"
					style="background-color: #002266; color: #dddddd; font-weight: bold;">학생서비스</li>
				<a href="/member/my_info"><li
					class="list-group-item list_hover">내 정보 보기</li></a>
				<a href="/member/friend_find"><li
					class="list-group-item list_hover">친구 찾기</li></a>
				<a href="/course/cart"><li class="list-group-item list_hover">장바
						구니</li></a>
				<a href="/course/course"><li class="list-group-item list_hover">수강
						조회</li></a>
				<a href="/course/curriculum"><li
					class="list-group-item list_hover">커리큘럼 보기</li></a>
				<a href="/course/change_course"><li
					class="list-group-item list_hover">수업 교환하기</li></a>
				<a href="/timetable/show_timetable"><li
					class="list-group-item list_hover">나의 시간표 보기</li></a>
				<a href="/timetable/share_timetable"><li
					class="list-group-item list_hover">친구와 공유</li></a>

				<a href="/timetable/pro_timetable"><li
					class="list-group-item list_hover">교수님 시간표</li></a>
			</ul>
		</div>

		<!-- 조용진 놈 꺼  -->
		<div class="col-sm-6 col-md-3 container">
			<ul class="list-group">
				<li class="list-group-item"
					style="background-color: #930000; color: #dddddd; font-weight: bold;">커뮤니티</li>
				<a href="/community?divs=gachon"><li class="list-group-item list_hover">가천대 게시판</li></a>
				
				<c:choose>
					<c:when test="${!(LOGIN_MEMBER eq null) }">
						<a href="/community?divs=${LOGIN_MEMBER.department}"><li class="list-group-item list_hover">단대별 게시판</li></a>
						<a href="/community?divs=${LOGIN_MEMBER.schoolYear}"><li class="list-group-item list_hover">학년별 게시판</li></a>
					</c:when>
					<c:otherwise>
						<a href="/community?divs=H"><li class="list-group-item list_hover">단대별 게시판</li></a>
						<a href="/community?divs=1"><li class="list-group-item list_hover">학년별 게시판</li></a>
					</c:otherwise>
				</c:choose>
				<a href="/community?divs=club"><li
					class="list-group-item list_hover">
						동아리</li></a>
				<a href="/community?divs=noname"><li
					class="list-group-item list_hover">
						대나무 숲</li></a>
<!-- 				<a href="/community/market"><li -->
<!-- 					class="list-group-item list_hover"> -->
<!-- 						가천 장터</li></a> -->
				<a href="/community?divs=thunder"><li
					class="list-group-item list_hover">
						번개 모임</li></a>
				<a href="/community?divs=sinmungo"><li
					class="list-group-item list_hover">
						신 문 고</li></a>
<!-- 				<a href="/community/group_buy"><li -->
<!-- 					class="list-group-item list_hover"> -->
<!-- 						공동 구매</li></a> -->
			</ul>
		</div>

		<!-- 지연누나꺼 ㅋ -->
		<div class="col-sm-6 col-md-3 container">
			<ul class="list-group">
				<li class="list-group-item"
					style="background-color: #003E00; color: #dddddd; font-weight: bold;">외부
					커뮤니티</li>
				<a href="outCommunity/store"><li
					class="list-group-item list_hover">
						상점보기</li></a>
				<a href="outCommunity/alba"><li
					class="list-group-item list_hover">
						알바 공고</li></a>
				<a href="outCommunity/event"><li
					class="list-group-item list_hover">
						이벤트 정보</li></a>
			</ul>
		</div>
		<div class="col-sm-6 col-md-3 container">
			<ul class="list-group">
				<li class="list-group-item"
					style="background-color: #A56100; color: #dddddd; font-weight: bold;">기타</li>
				<a href="/common/show_all"><li
					class="list-group-item list_hover">서비스 한눈에 보기</li></a>
			</ul>
		</div>
	</div>
</div>
</body>
</gachonTag:html>