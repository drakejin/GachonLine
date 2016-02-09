<%@ page session="true" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html title="시간표보기">
<gachonTag:script>

<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/component.css"/ >
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/myform.css"/ >
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/pgwslideshow.min.css"/ >
<script src="${PATH_PLUGIN }/whatIsThis/pgwslideshow.min.js"></script>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a06be78220061f3fc867e63e61abf9a0"></script>

<style>

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
.form-horizontal .control-label {
	padding-top: 0px;
</style>
</style>


<script>
/*ImageModal*/
/*ImageModal*/
	$(document).ready(function() {
		$('#myModal').on('shown.bs.modal', function() {
			$('#myInput').focus();

			var staticMapContainer = document.getElementById('staticMap'), staticMapOption = {
				center : new daum.maps.LatLng(33.450701, 126.570667),
				level : 3,
				marker : {
					position : new daum.maps.LatLng(33.450401, 126.570647),// 좌표가 없으면 이미지 지도 중심에 마커가 표시된다.
					text : '마커 위에 텍스트가 함께 표시된다' // 지정하지 않으면 마커만 표시된다.
				}
			};

			var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);
		})
	})
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
			<input type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal"
				style="font-size: 14px; width: 100%; height: 30px; font-weight: bold; margin-left: 10px" value="정보보기"></input>
		</div>
	</div>
	


	<!-- 이벤트 정보 모달 -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="myModalLabel" style="font-weight: bold; text-align: center;">이벤트 리스트 제목</h2>
				</div>
				<div class="modal-body" style="height: 85%;">
						<form class="form-horizontal myform">
							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">제목</label>
								<div class="col-sm-4" style="width: 75%">
									<input class="form-control input-sm" type="text" value="김지연" readonly />
								</div>
							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">일시</label>
								<div class="col-sm-4" style="width: 75%">
									<input class="form-control input-sm" type="text" value="글로벌캠퍼스" readonly />
								</div>
							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">위치</label>
								<div class="col-sm-4">
									<div id="staticMap" style="width:620px;height:250px;"></div>
								</div>
							</div>

							<div class="form-group">
								<label for="Birth" class="col-sm-2 control-label">상세정보</label>
								<div class="col-sm-4" style="width: 75%">
									<textarea class="form-control" id="message-text" style="resize:none;height:240px" disabled></textarea>
								</div>
							</div>
							
					
						</form>
				</div>
				
			</div>
		</div>
	</div><!-- end.modal -->
</body>
</gachonTag:html>