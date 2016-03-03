<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script>
<c:if test="${error eq 'nolog'}">
	<script>
	GachonNoty.showCustomNoty('로그인후 사용해주시기 바랍니다.','warning');
	console.log("로그인후 사용해주시기 바랍니다.");
	</script>		
</c:if>
<c:if test="${error eq 'logout'}">
	<script>
	GachonNoty.showCustomNoty('${LOGIN_MEMBER}님이 로그아웃 하셨습니다.');
	console.log("${LOGIN_MEMBER}님이 로그아웃 하셨습니다.");
	</script>		
</c:if>

<script data-for="ready">
// $(document).ready(function(){
//  	$('#memberId').val('201033152');
//  	$('#password').val('111');
// 	login();
// });
</script>

<script type="text/javascript">

$(function () {
	$(document).keydown(function (key) {
        if (key.keyCode == 13) {
            login();
        }
    });
});
function login() {
	var dataForm = {
			memberId : document.getElementById("memberId").value,
			password : document.getElementById("password").value
	};
	$.ajax({
		type : "POST",
		url : "/login.go",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "JSON",
		success : function(response) {
			if(response.${RESULT_MSG}=='${RESULT_SUCCESS}'){
				location.href="/home";
			}else{
				GachonNoty.showCustomNoty("학번과 비밀번호가 다릅니다. \n 또는 아이디가 잠겨있습니다.");
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});

}
</script>
<c:if test="${!(LOGIN_MEMBER eq null) }">
	<script type="text/javascript">
		$('#memberId').val('${LOGIN_MEMBER.memberId}');
		$('#password').val('${LOGIN_MEMBER.password}');
		login();
	</script>
</c:if>

<style>
.content {
	height: 35em;
	border: solid 2px #bbb;
	border-radius: 15px;
	padding: 2em 2em 2em 2em;
}

.content-side {
	background-color: #fff;
	border: solid 2px #bbb;
	border-radius: 15px;
	padding: 2em 2em 2em 2em;
	overflow-y: scroll;
	height: 700px;
}

.content-controller {
	background-color: #fff;
	border: solid 2px #bbb;
	border-radius: 15px;
	padding: 3em 2em 1em 2em;
	margin-left: 12%;
}
</style>


</gachonTag:script>

<body>

	<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>
	
	<div class="container">
		<div class="page_title">로그인</div>
		<hr />
		<div class="row">
			<div class="col-sm-2">&nbsp;</div>
			<div class="col-sm-8">
				<div class="form-group">
					<label for="usrname"> <span
						class="glyphicon glyphicon-user"></span> 사용자 이름
					</label> <input type="text" class="form-control" id="memberId"
						placeholder="학번을 입력하세요">
				</div>
				<div class="form-group">
					<label for="psw"> <span
						class="glyphicon glyphicon-eye-open"></span> 비밀번호
					</label> <input type="password" class="form-control"  id="password"
						placeholder="비밀번호를 입력하세요">
				</div>
				<div class="checkbox">
					<label><input type="checkbox" value="" id="checked" checked>기억하기</label>
				</div>
				<button type="button" onclick="login();"
					class="btn btn-default btn-success btn-block">
					<span class="glyphicon glyphicon-off"></span>로그인
				</button>
			</div>
			<div class="col-sm-2">&nbsp;</div>
		</div>
		
		<br>
		<br>
		<br>
		<div class="row">
			<div class="col-sm-9 content-controller">
				<div class="row">
					<div class="form-group">
						<label> <span class="glyphicon glyphicon-info-sign"></span>&nbsp; 본 페이지는 자동 가입제입니다. Tester 계정은 아래와 같습니다.</label>
					</div>
					<hr/>
					
					<div class="form-group">
						<label>Tester(관리자) 이름&nbsp; : &nbsp;</label> 
						<label>201033152</label>
					</div>
				
					<div class="form-group">
						<label>Tester(관리자) 비밀번호&nbsp; : &nbsp;</label> 
						<label>111</label>
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
</gachonTag:html>
