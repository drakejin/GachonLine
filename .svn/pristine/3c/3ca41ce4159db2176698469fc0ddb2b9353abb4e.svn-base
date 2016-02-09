<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html title="시간표보기">
<gachonTag:script>
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/component.css"/ >
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/myform.css"/ >
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/pgwslideshow.min.css"/ >
<script src="${PATH_PLUGIN }/whatIsThis/pgwslideshow.min.js"></script>

<style>
.pgwSlideshow .ps-current .ps-next {
	right: 1;
	top: 40%;
}

.pgwSlideshow {
	margin-left: 2%;
	width: 49%;
}

ul {
	padding-left: 0px;
}

.pgwSlideshow .ps-current .ps-prev {
	left: 0;
	top: 40%;
}

.pgwSlideshow .ps-caption {
	left: 0;
	padding: 5px;
	font-size: 1.4rem;
}

.pgwSlideshow.narrow {
	width: 400px;
	margin-left: 0px;
}

#form-wrapper {
	-webkit-border-radius: 5px;
	padding-top: 10px;
}

#form-wrapper input {
	width: 200%;
}

#form-wrapper label {
	font-size: 13px;
	padding: 5px;
}

.myform {
	/* margin: 0 auto; */
	width: 100%;
	height: 260px;
	/* padding: 10px; */
	margin-left: 0;
}
</style>

<script>
	$(document).ready(function() {
	$('#proInfo').on('shown.bs.modal', function() {
		$('#myInput').focus();
		$('.pgwSlideshow').pgwSlideshow();
	});
	});

</script>
</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="noname" type="noname" id="noname" />

	<!-- 교수님 선택 -->
	<div class="container">
		<div class="page_title">교수님 시간표 보기</div>
		<br>
		<div class="col-md-2">
			<!-- Button trigger modal 1 -->
			<input type="button" class="btn btn-info" data-toggle="modal" data-target="#proInfo"
				style="font-size: 14px; width: 100%; height: 30px; font-weight: bold; margin-left: 10px" value="정보보기"></input>
		</div>
	</div>


	<!-- 알바 채용 정보 모달 -->
	<div class="modal fade bs-example-modal-lg" id="proInfo" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="myModalLabel" style="font-weight: bold; text-align: center;">아르바이트 리스트 제목</h2>
				</div>
				<div class="modal-body" style="height: 95%;">
					<div style="float: left;">
						<ul class="pgwSlideshow" style="margin: 0%;">
							<!-- 임시 이미지 경로 설정, 로컬 실제 경로에서 이미지 불러오기 -->
							<li><img src="<c:url value='/resources/image/tree_root.jpg'/>" alt="코리안 디저트 카페, 설빙" data-description="한국식 디저트 카페, 눈꽃 설빙, 인절미설빙"></li>
							<li><img src="<c:url value='/resources/image/houses.jpg'/>" alt="" data-description=""></li>
							<li><img src="<c:url value='/resources/image/hill_fence.jpg'/>" alt="" data-large-src=""></li>
						</ul>
					</div>

					<h2 style="margin-bottom: 10px; margin-left: 50%; margin-top: 0px;">회사명</h2>
					<form class="form-horizontal myform1" id="form-wrapper" style="float: left; margin-left: 3%; margin-bottom: 0px; width: 50%; height: 345px;">
						<div class="form-group">
							<label for="Birth" class="col-sm-1 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">마감일</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="글로벌 캠퍼스" readonly />
							</div>
						</div>

						<div class="form-group">
							<label for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">모집인원</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="IT대학" readonly />
							</div>
						</div>

						<div class="form-group">
							<label id="proLabel" for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">성별</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="컴퓨터공학과" readonly />
							</div>
						</div>

						<div class="form-group">
							<label id="proLabel" for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">연령</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="컴퓨터공학과" readonly />
							</div>
						</div>

						<div class="form-group">
							<label for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">학력</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="4-402" readonly />
							</div>
						</div>

						<div class="form-group">
							<label for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">담당자</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="010-3324-2133" readonly />
							</div>

						</div>

						<div class="form-group">
							<label for="Birth" class="col-sm-2 control-label" style="margin-left: 0px; margin-bottom: 5px; width: 30%;">e메일</label>
							<div class="col-sm-4" style="width: 28%">
								<input class="form-control input-sm" type="text" value="tkhss@naver.com" readonly />
							</div>

						</div>
					</form>

					<div style="float: left; margin-top: 3%; width: 100%;">
						<h2 style="font-size: 10.5pt; margin-bottom: 0px;">▣ 업무내용 및 근무조건</h2>
						<hr>

						<form class="form-horizontal myform">
							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">근무형태</label>
								<div class="col-sm-4" style="width: 20%">
									<input class="form-control input-sm" type="text" value="김지연" readonly />
								</div>

								<label for="Birth" class="col-sm-2 control-label">업직종</label>
								<div class="col-sm-4" style="width: 40%">
									<input class="form-control input-sm" type="text" value="201133234" readonly />
								</div>
							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">근무요일</label>
								<div class="col-sm-4" style="width: 20%">
									<input class="form-control input-sm" type="text" value="글로벌캠퍼스" readonly />
								</div>

								<label for="Birth" class="col-sm-2 control-label">근무시간</label>
								<div class="col-sm-4" style="width: 40%">
									<input class="form-control input-sm" type="text" value="IT대학" readonly />
								</div>
							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">급여</label>
								<div class="col-sm-4" style="width: 20%">
									<input class="form-control input-sm" type="text" value="인터렉티브미디어학과" readonly />
								</div>

								<label for="Birth" class="col-sm-2 control-label">복리후생</label>
								<div class="col-sm-4" style="width: 40%">
									<input class="form-control input-sm" type="text" value="인터렉티브미디어학과" readonly />
								</div>

							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">근무지역</label>
								<div class="col-sm-4" style="width: 76.5%">
									<input class="form-control input-sm" type="text" value="인터렉티브미디어학과" readonly />
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div><!-- end.modal -->
</body>
</gachonTag:html>