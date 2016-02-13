<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script/>

<style>
	hr {border:1px solid gray;}
	
	.form-group{margin-bottom:2%;}
	
	.buttonStyle{width:45%; font-weight:bold;}
	
	#footerStyle{margin-left:70%;}
</style>

<!-- update시 세션 / db를 모두 최신화 시켜주어야함.... 생각해보기 -->


<script type="text/javascript">
	//초기 로드 테이블
	$(document).ready(function() {
		selectMyinfo();
	});
	
	function selectMyinfo() {
		var tempMemberId;
		var dataForm = {
			memberId : "${LOGIN_MEMBER.memberId}"
		};
		$.ajax({
			type : "POST",
			url : "/member/my_info/myInfo.select",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
		 		document.getElementById("type").value = response[0].memberType_nm;
		 		document.getElementById("num").value = response[0].memberId;
		 		document.getElementById("name").value = response[0].memberName;
		 		document.getElementById("college").value = response[0].college_nm;
		 		document.getElementById("department").value = response[0].department_nm;
		 		document.getElementById("major").value = response[0].major_nm;
		 		document.getElementById("collegeStatus").value = response[0].collegeStatus_nm;
		 		document.getElementById("schoolYear").value = response[0].schoolYear_nm;
		 		document.getElementById("completeTerm").value = response[0].completeTerm_nm;
		 		document.getElementById("birth").value = response[0].birthDate;
		 		document.getElementById("postalCode").value = response[0].postalCode;
		 		document.getElementById("address").value = response[0].address;
		 		document.getElementById("phone").value = response[0].phone;
		 		document.getElementById("phone2").value = response[0].phone2;
		 		document.getElementById("mobile").value = response[0].mobile;
		 		document.getElementById("email").value = response[0].email;
		 		
		 		// READ-ONLY로 쓰기방지
		 		$("input[id=type]").attr("readonly", true);
				$("input[id=num]").attr("readonly", true);
				$("input[id=name]").attr("readonly", true);
				$("input[id=college]").attr("readonly", true);
				$("input[id=department]").attr("readonly", true);
				$("input[id=major]").attr("readonly", true);
				$("input[id=collegeStatus]").attr("readonly", true);
				$("input[id=schoolYear]").attr("readonly", true);
				$("input[id=completeTerm]").attr("readonly", true);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	// update시, 세션에 적용시켜야하는데.... redirect 안하고 session 변경해서 보여주기를..어떻게...
	function updateMst(pw) {
		var passwd = pw;
		
		var dataForm = {
			memberType : "${LOGIN_MEMBER.memberType}",	
			memberId : "${LOGIN_MEMBER.memberId}",
			memberName :"${LOGIN_MEMBER.memberName}",	
			birthDate : "${LOGIN_MEMBER.birthDate}",	
			college : "${LOGIN_MEMBER.college}",	
			department :"${LOGIN_MEMBER.department}",	
			major : "${LOGIN_MEMBER.major}",	
			collegeStatus : "${LOGIN_MEMBER.collegeStatus}",
			completeTerm : "${LOGIN_MEMBER.completeTerm}",	
			password : passwd,
			birthDate : $('#birth').val(),
			postalCode : $('#postalCode').val(),
			address : $('#address').val(),
			phone : $('#phone').val(),
			phone2 : $('#phone2').val(),
			mobile : $('#mobile').val(),		
			email : $('#email').val(),		
			updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/member/my_info/myInfo.update",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				alert("성공");
				window.location.reload(true);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	function Validation(){ 	// 비밀번호 벨리데이션 체크
		if($('#password').val() == "" || $('#pwChk').val() == ""){
			alert("비밀번호를 입력하세요.");
			return;
		}else{
			if($('#password').val() == $('#pwChk').val()){
				updateMst($('#password').val());
			}else{
				alert("비밀번호가 일치하지 않습니다.");
				refreshPW();
			}
		}
		
	}
	
	function refreshAll(){
		$("input[id=password]").val("");
		$("input[id=pwChk]").val("");
		$("input[id=birth]").val("");
		$("input[id=postalCode]").val("");
		$("input[id=address]").val("");
		$("input[id=phone]").val("");
		$("input[id=phone2]").val("");
		$("input[id=mobile]").val("");
		$("input[id=email]").val("");
	}
	
	function refreshPW(){
		$("input[id=password]").val("");
		$("input[id=pwChk]").val("");
	}
</script>

<body>
<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag" %>
<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<form class="form-horizontal">
			<fieldset>
				<div class="page_title">내정보 보기</div>
				<hr />
				
				<div class="form-group">
					<label for="inputEmail" class="col-lg-2 control-label">회원사진</label>
					<div>
						<form method="post" enctype="multipart/form-data" action="imgup.jsp">
							<div class="col-lg-10">	
								<input type="file" class="btn btn-default" style="font-weight:bold;"> </input>
							</div>
						</form>
					</div>
				</div>
				
				<div class="form-group">
					<label for="Category" class="col-sm-2 control-label">회원구분</label>
					<div class="col-sm-2">
						<input id="type" class="form-control" type="text"> 
					</div>
					
					<label for="Number" class="col-sm-2 control-label">회원번호</label>
					<div class="col-sm-2">
						<input id="num" class="form-control" type="text">
					</div>
					
					<label for="Name" class="col-sm-2 control-label">회원이름</label>
					<div class="col-sm-2">
						<input id="name" class="form-control" type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="Univ" class="col-sm-2 control-label">소속대학</label>
					<div class="col-sm-2">
						<input id="college" class="form-control" type="text">
					</div>
					
					<label for="College" class="col-sm-2 control-label">단과대학</label>
					<div class="col-sm-2">
						<input id="department" class="form-control" type="text">
					</div>
					
					<label for="Major" class="col-sm-2 control-label">전    공</label>
					<div class="col-sm-2">
						<input id="major" class="form-control" type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="Register" class="col-sm-2 control-label">학적상태</label>
					<div class="col-sm-2">
						<input id="collegeStatus" class="form-control" type="text">
					</div>
					
					<label for="School_Year" class="col-sm-2 control-label">학년</label>
					<div class="col-sm-2">
						<input id="schoolYear" class="form-control" type="text">
					</div>
					
					<label for="Comlete_Term" class="col-sm-2 control-label">이수학기</label>
					<div class="col-sm-2">
						<input id="completeTerm" class="form-control" type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="Pw" class="col-sm-2 control-label">비밀번호</label>
					<div class="col-sm-2">
						<input id="password" class="form-control"  type="password">
					</div>
					
					<label for="Pwchk" class="col-sm-2 control-label">비밀번호확인</label>
					<div class="col-sm-2">
						<input id="pwChk" class="form-control"  type="password">
					</div>
					
					<label for="Birth" class="col-sm-2 control-label">생년월일</label>
					<div class="col-sm-2">
						<input id="birth" class="form-control"  type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="Addr_Number" class="col-sm-2 control-label">우편번호</label>
					<div class="col-sm-2">
						<input id="postalCode" class="form-control" type="text">
					</div>
					
					<label for="Address" class="col-sm-2 control-label">기본주소</label>
					<div class="col-sm-6">
						<input id="address" class="form-control" type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="Phone" class="col-sm-2 control-label">전화번호</label>
					<div class="col-sm-2">
						<input id="phone" class="form-control" type="text">
					</div>
					
					<label for="Phone2" class="col-sm-2 control-label">전화번호2</label>
					<div class="col-sm-2">
						<input id="phone2" class="form-control" type="text">
					</div>
					
					<label for="CellPhone" class="col-sm-2 control-label">휴대전화</label>
					<div class="col-sm-2">
						<input id="mobile" class="form-control" type="text">
					</div>
				</div>
				
				<div class="form-group">
					<label for="E-mail" class="col-sm-2 control-label">이메일</label>
					<div class="col-sm-3">
						<input id="email" class="form-control" type="email">
					</div>
				</div>
				
				<hr />
				<div class="form-group">
					<div>
						<div id="footerStyle">
							<a href="#" onclick="Validation();" class="btn btn-success btn-info buttonStyle">저장</a>
							<a href="#" onclick="refreshAll();" class="btn btn-success btn-warning buttonStyle">새로쓰기</a>
						</div> 
					</div>
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>

</gachonTag:html>