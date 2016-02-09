<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script>
	<c:if test="${RESULT_MSG eq '실패'}">
		<script>
			GachonNoty.showCustomNoty("제목은 20글자를 넘지 않게 해주세요\n 내용은 1300자 이내로 작성해주세요");

		</script>
	</c:if>
	<script type="text/javascript">
	function checkInput(){
		var content = document.getElementById('content').value;
		var title = document.getElementById('title').value;
		var notice = document.getElementById('notice');
		
		if(title.length>0&&title.length<=25){
			if(content.length>0&&content.length<=1300){
				document.getElementById("notice").innerHTML = "&nbsp;";
				document.getElementById("submit").disabled = false;
				document.getElementById("submit").disabled = false;
			}else{
				document.getElementById("notice").innerHTML = "내용이 너무 짧거나 너무 깁니다.1300글자 제한입니다.";
				document.getElementById("submit").disabled = true;
			}	
		}else{
			document.getElementById("notice").innerHTML = "제목 너무 짧거나 너무 깁니다.25글자 제한입니다.";
			document.getElementById("submit").disabled = true;
		}
		
	}
	
	</script>
	
</gachonTag:script>
<body>
<!-- 속성 아직 안만들어 놨어요 이거는 임시방편으로 만든 태그라이브러리이고  /WEB-INF/tags/nav-bar.tag 
에다가 링크를 수정해주세양! 나중에 tag class 만들때 참고할게양 ! -->

<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>


<div class="container">
	<GachonTag:community-nav divs="${divs}"/>
	<div class="well"  style="margin-top:3em;">
		<c:choose>
			<c:when test="${board eq null }">	
				<form action="/community/write/submit" method="post">
					<input type="hidden" name="divs" value="${divs}"/>
					<input type="hidden" name="type" value="${divs}"/>
					
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2 attr_name ">제목</div>
							<div class="col-sm-10 input-group" style="padding-left:2.8em;">
								<input id="title" onkeydown="checkInput()"  type="text" name="title" class="form-control" value="" placeholder="제목을 입력하세요" />
							</div>
						</div>
					</div>
			
					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">이름</div>
							<div class="col-sm-7 input-group">
								<input type="text" class="form-control" value="${LOGIN_MEMBER.memberName }" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">학번</div>
							<div class="col-sm-7 input-group">
								<input type="text" class="form-control" value="${LOGIN_MEMBER.memberId }"
									readonly />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-12">
							<label for="comment">내용 작성 </label>
							<textarea id="content" onkeydown="checkInput()" class="form-control" name="content" rows="20"></textarea>
						</div>
					</div>
					<div id="notice" class="row">
						&nbsp;
					</div>
						
					<div class="row">
						<div class="col-sm-4">&nbsp;</div>
						<div class="col-sm-4">&nbsp;</div>
						<div class="col-sm-4">
							<div class="col-sm-6">
								<input type="reset" value="다시 작성" class="col-sm-12 btn btn-warning" />
							</div>
							<div class="col-sm-6">
								<input id="submit" type="submit" value="글 등록" class="col-sm-12 btn btn-success" disabled/>
							</div>
						</div>
					</div>
				</form>
			</c:when>
			<c:otherwise>
				<form action="/community/update/submit" method="post">
					<input type="hidden" name="divs" value="${divs}"/>
					<input type="hidden" name="type" value="${divs}"/>
					<input type="hidden" name="boardNo" value="${board.LIST.boardNo}"/>
					<div class="row">
						<div class="col-sm-12 form-group">
							<div class="col-sm-2 attr_name ">제목</div>
							<div class="col-sm-10 input-group" style="padding-left:2.8em;">
								<input id="title" onkeydown="checkInput()"  type="text" name="title" class="form-control" value="${board.LIST.title}" placeholder="제목을 입력하세요" />
							</div>
						</div>
					</div>
			
					<div class="row">
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">이름</div>
							<div class="col-sm-7 input-group">
								<input type="text" class="form-control" value="${LOGIN_MEMBER.memberName }" readonly />
							</div>
						</div>
						<div class="col-sm-6 form-group">
							<div class="col-sm-5 attr_name ">학번</div>
							<div class="col-sm-7 input-group">
								<input type="text" class="form-control" value="${LOGIN_MEMBER.memberId }"
									readonly />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-12">
							<label for="comment">내용 작성 </label>
							<textarea id="content" onkeydown="checkInput()" class="form-control" name="content" rows="20">${board.CONTENT.content}</textarea>
						</div>
					</div>
					<div id="notice" class="row">
						&nbsp;
					</div>
						
					<div class="row">
						<div class="col-sm-4">&nbsp;</div>
						<div class="col-sm-4">&nbsp;</div>
						<div class="col-sm-4">
							<div class="col-sm-6">
								<input type="reset" value="다시 작성" class="col-sm-12 btn btn-warning" />
							</div>
							<div class="col-sm-6">
								<input id="submit" type="submit" value="수정 완료" class="col-sm-12 btn btn-success" disabled/>
							</div>
						</div>
					</div>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</div>

</body>
</gachonTag:html>