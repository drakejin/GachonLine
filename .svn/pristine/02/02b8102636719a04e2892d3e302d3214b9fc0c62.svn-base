<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>

<gachonTag:script bootstrapTable="YES">

<!-- 게시글 리스트들을 역할을 합니다. -->
<script type="text/javascript">

$(document).ready(function() {
	list();
	$(function() {
		$('#boardList').bootstrapTable().on('click-row.bs.table',function(e, row, $element) {
			location.href="/community?divs=${divs}&boardNo="+row.boardNo;
		});
	});
});

//댓글에 들어가는 인풋박스 검증하기
function replyInput(value) {
	if (value.length > 2 && value.length < 1000) {
		document.getElementById("replyNotice").innerHTML = "&nbsp;";
		document.getElementById("replySubmit").disabled = false;
	} else {
		document.getElementById("replyNotice").innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;덧글이 너무 짧거나 너무 깁니다.1000글자 제한입니다.";
		document.getElementById("replySubmit").disabled = true;
	}
}
//댓글에 들어가는 인풋박스 검증하기
function repliesInput(event) {
	var commentNo = event.srcElement.id.split('_')[0];
	var value = event.srcElement.value;
	
	if (value.length > 2 && value.length < 1000) {
		document.getElementById(commentNo+"_update").disabled = false;
	} else {
		document.getElementById(commentNo+"_update").disabled = true;
	}
}

//리스트를 불러옵니다.
function list() {
	var dataForm = {
		type : '${divs}'
	};
	$.ajax({
		type : "POST",
		url : "/community.select",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		success : function(response) {
			$('#boardList').bootstrapTable('load', response);
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}

</script>
</gachonTag:script>
<body>

	<!-- 구분은 하나의 변수로하고 변수는 두개로 즉 구분자와 그룹자 두개를 넘겨준다. -->
	<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>

	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}"
		type="${LOGIN_MEMBER.memberType}" />
	<div class="container">

		<!-- 커뮤니케이션 게시판에 사용할 nav-Bar 필요한 데이터는 divs만 받으면 된다.
	하나의 컨트롤러 그리고 단 하나의 메서드 로 페이지를 구분한다.
	 -->
		<GachonTag:community-nav divs="${divs}" />
		
		<c:if test="${!(board eq null)}">
			<script type="text/javascript">
			$(document).ready(function() {
				$('html, body').animate({
					scrollTop : $("#board").offset().top - 30
				}, 300);
			});
			</script>
			<div id="board">
				<div class="row" style="margin-top: 3em;">
					<div class="row form-row">
						<div class="col-sm-12">
							<div class="col-sm-2 attr_name ">제목</div>
							<div class="col-sm-10">
								<input id="title" type="text" class="form-control"
									value="${board.LIST.title}" readonly />
							</div>
						</div>
					</div>
	
					<div class="row form-row">
						<div class="col-sm-6">
							<div class="col-sm-4 attr_name ">이름</div>
							<div class="col-sm-8">
								<input id="createUser" type="text" class="form-control"
									value="${board.LIST.createUser }" readonly />
							</div>
						</div>
						<div class="col-sm-6">
							<div class="col-sm-4 attr_name ">학번</div>
							<div class="col-sm-8">
								<input id="createId" type="text" class="form-control"
									value="${board.LIST.createId }" readonly />
							</div>
						</div>
					</div>
				</div>
				<div class="well">
					<div class="row form-group">
						<label for="comment">내용</label>
						<div class="card-content card"
							style="height: 440px; overflow-y: scroll;">
							<div id="content" style="border: none; background-color: #ffffff">
								${board.CONTENT.content }
							</div>
						</div>
					</div>
					<c:if test="${LOGIN_MEMBER.memberId eq board.LIST.createId}">
						<div class="row">
							<div class="col-sm-4">&nbsp;</div>
							<div class="col-sm-4">&nbsp;</div>
							<div class="col-sm-4" style="padding-top: 1em;">
								<div class="col-sm-6">
									<form method="post" id="boardDelete" action="/community/delete">
										<input type="hidden" name="divs" value="${divs}" />
										<input type="hidden" name="boardNo" value="${boardNo}" />
										<input type="submit" onclick="boardDelete()" value="삭제하기" class="col-sm-12 btn btn-warning" />
									</form>
								</div>
								<div class="col-sm-6">
									<form method="post" id="boardUpdate" action="/community/update">
										<input type="hidden" name="divs" value="${divs}" /> 
										<input type="hidden" name="boardNo" value="${boardNo}" />
										<input type="submit" value="수정하기" class="col-sm-12 btn btn-success" />
									</form>
								</div>
							</div>
						</div>
					</c:if>
				</div>
				<div id="replies">

				</div>
				
<script type="text/javascript">
$(document).ready(function(){
	commentList('${boardNo}');
});
</script>
				<c:if test="${!(LOGIN_MEMBER eq null)}">
					<div id="replyNotice" class="row">&nbsp;</div>
					<div class="well">
						<div class="row">
							<div class="col-sm-2">
								<div class="form-group">
									<input class="form-control" type="text" id="replyCreateUser"
										value="${LOGIN_MEMBER.memberName}" readonly />
								</div>
								<div class="form-group">
									<input class="form-control" type="text" name="createId"
										value="${LOGIN_MEMBER.memberId}" id="replyCreateId" readonly />
								</div>
							</div>
							<div class="col-sm-7">
								<textarea onkeydown="replyInput(this.value)" rows="4"
									class="form-control" type="text" id="replyComment1"></textarea>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<input type="reset" class="form-control btn btn-warning" value="다시 작성" />
								</div>
								<div class="form-group">
									<input type="submit" onClick="replySubmit();" id="replySubmit" class="form-control btn btn-success" value="덧글 달기" />
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</c:if>
		<div>
			<div class="table-responsive">
				<table id="boardList" data-toggle="table" data-show-columns="true"
					data-search="true" data-show-refresh="true"
					data-show-toggle="false" data-show-export="true"
					data-pagination="true">
					<thead>
						<tr>
							<th data-field="boardNo" class="col-sm-1 text_center">글 번호</th>
							<th data-field="title" class="col-sm-5 text_center">제 목</th>
							<th data-field="createUser" class="col-sm-2 text_center">작성자</th>
							<th data-field="createDate" class="col-sm-2 text_center">작성일</th>
							<th data-field="viewCount" class="col-sm-1 text_center">조회</th>
						</tr>
					</thead>
				</table>
			</div>

			<div class="row">
				<div class="col-sm-4">&nbsp;</div>
				<div class="col-sm-4">&nbsp;</div>
				<div class="col-sm-4">
					<c:choose>
						<c:when
							test="${!(LOGIN_MEMBER eq null)}">
							<form method="POST" action="/community/write">
								<input type="hidden" name="divs" value="${divs}" /> <input
									type="submit" class="col-sm-11 btn btn-success" style="margin-top: 1em; margin-left: 1em; margin-right: 1em;"
									value="글 쓰기" />
							</form>
						</c:when>
						<c:otherwise>
							&nbsp;
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>	
</body>







<script type="text/javascript">


//덧글 불러오기
function commentList(boardNo){
	var dataForm = {
		boardNo : boardNo	
	};
	$.post("/community/reply",{boardNo:boardNo},function(data){
		var replies = document.getElementById('replies');
		while (replies.firstChild) {
		    replies.removeChild(replies.firstChild);
		}
		replies.className = "well";
		for(var reply in data){

			var div1 = document.createElement('div');
			var div2 = document.createElement('div');
			var div3 = document.createElement('div');
			var div4 = document.createElement('div');
			var div5 = document.createElement('div');
			var div6 = document.createElement('div');
			var div7 = document.createElement('div');
			var div8 = document.createElement('div');
			var div9 = document.createElement('div');
			
			var input1 = document.createElement('input');
			var input2 = document.createElement('input');
			var input3 = document.createElement('input');
			
			var textarea1 = document.createElement('textarea');
			
			div1.className = "row";
			div1.style="background-color:#fff;margin-bottom:1em;padding-top:0.7em;";
		
			div2.className = "col-sm-2";
			div3.className = "col-sm-7";
			div4.className = "col-sm-3";
			
			div5.className = "form-group";
			div6.className = "form-group";
			div7.className = "form-group";
			div8.className = "form-group";
			div9.className = "form-group";
			
			textarea1.className = "form-control";
			textarea1.rows = "4";
			textarea1.readOnly = true;
			textarea1.value = data[reply].comment1;
			textarea1.id = data[reply].commentNo+"_comment1";
			
			input1.type = "text";
			input1.className = "form-control";
			input1.readOnly=true;
			input1.value = data[reply].createUser;
			input1.id = data[reply].commentNo+"_name";
			
			input2.type = "text";
			input2.className = "form-control";
			input2.readOnly=true;
			input2.value = data[reply].createId;
			input2.id = data[reply].commentNo+"_id";
			
			input3.type = "text";
			input3.className = "form-control";
			input3.readOnly=true;
			input3.value = data[reply].createDate;
			input3.id = data[reply].commentNo+"_date";
			
			
			if('${LOGIN_MEMBER.memberId}' == data[reply].createId){
				var input4 = document.createElement('input');
				var input5 = document.createElement('input');
				
				input4.type = "button";
				input4.className = "col-sm-6 btn btn-warning";
				input4.value = "삭제";
				input4.id = data[reply].commentNo+"_delete";
				input4.onclick = replyDelete;
				
				input5.type = "button";
				input5.className = "col-sm-6 btn btn-success";
				input5.value = "수정";
				input5.id = data[reply].commentNo+"_update";
				input5.onclick = replyUpdate;
				
				div9.appendChild(input4);
				div9.appendChild(input5);
			}else{
				div9.innerHTML = "&nbsp;";
			}
			div5.appendChild(input1);
			div6.appendChild(input2);
			div7.appendChild(textarea1);
			div8.appendChild(input3);
			
			div2.appendChild(div5);
			div2.appendChild(div6);
			div3.appendChild(div7);
			div4.appendChild(div8);
			div4.appendChild(div9);
			
			div1.appendChild(div2);
			div1.appendChild(div3);
			div1.appendChild(div4);
			replies.appendChild(div1);
		}
		
	});
}

//댓글 작성
function replySubmit(){
	var replyComment1 =document.getElementById('replyComment1');
	var dataForm ={
		boardNo : '${boardNo}',
		comment1 : replyComment1.value,
		createUser : document.getElementById('replyCreateUser').value,
		createId : document.getElementById('replyCreateId').value
	};
	$.post("/community/reply/write",dataForm,function(data){
		GachonNoty.showCustomNoty(dataForm.createUser+'님의 \n [덧글]이 [등록]되었습니다.');
		replyComment1.value="";
		commentList(dataForm.boardNo);
	});
}
//댓글 삭제
function replyDelete(event){
	if(confirm("해당 댓글을 정말 삭제 하시겠습니까?")){

		var commentNo = event.toElement.id.split('_')[0];
		var comment1 = document.getElementById(commentNo+'_comment1').value;
		var dataForm ={
			boardNo : '${boardNo}',
			commentNo : commentNo
		};
		$.post("/community/reply/delete",dataForm,function(data){
			GachonNoty.showCustomNoty(dataForm.createUser+'님의 \n [덧글]이 [수정]되었습니다.');
			commentList(dataForm.boardNo);
		});
	}
}
//댓글 수정
function replyUpdate(event){
	var commentNo = event.toElement.id.split('_')[0];
	var comment1 = document.getElementById(commentNo+'_comment1').value;
	var dataForm ={
		boardNo : '${boardNo}',
		commentNo : commentNo,
		comment1 : comment1
	};
	var textarea1 = document.getElementById(commentNo+'_comment1');
	var updateBtn = document.getElementById(commentNo+'_update');
	var deleteBtn = document.getElementById(commentNo+'_delete');

	if(!(textarea1.readOnly)){
		if(confirm("해당 댓글을 수정하시겠습니까?")){
			$.post("/community/reply/update",dataForm,function(data){
				GachonNoty.showCustomNoty(dataForm.createUser+'님의 \n [덧글]이 [수정]되었습니다.');
				commentList(dataForm.boardNo);
				
			});
		}
	}else{
		deleteBtn.value="취소"
		deleteBtn.onclick=replyUpdateCancle;
		updateBtn.value="!제출!";
		
		textarea1.onkeydown=repliesInput;
		textarea1.readOnly=false;
	}
}

//댓글 수정버튼을 누르고 나면 나타나는 삭제버튼에 대한 이벤트
function replyUpdateCancle(){
	commentList('${boardNo}');
}

function boardDelete(){
	if(confirm("해당 게시글을 삭제하시겠습니까?")){
		$( "boardDelete" ).submit(function( event ) {
			GachonNoty.showCustomNoty('덧글 삭제가 완료되었습니다.');
		});
	}
}
function boardDelete(){
	if(confirm("해당 게시글을 수정하시겠습니까?")){
		$( "boardDelete" ).submit(function( event ) {
			GachonNoty.showCustomNoty('덧글 삭제가 완료되었습니다.');
		});
	}
}

</script>

</gachonTag:html>



 
 
 