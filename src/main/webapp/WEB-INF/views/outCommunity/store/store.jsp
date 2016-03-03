<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>

<gachonTag:html title="상점정보">
<gachonTag:script>
	<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/portfolio.css"/ >
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a06be78220061f3fc867e63e61abf9a0"></script>

	<style>
#storeTitle {
	width: 270px;
	height: 260px;
}

.overlay {
	width: 160px;
	height: 160px;
	background-color: #0B0B0B;
	opacity: 0.8;
	z-index: 1;
	position: absolute;
	top: 0;
	left: 0;
	display: none;
}

hr {
	border: 1px solid gray;
	margin: 0 0 2% 0;
}

.Img {
	position: relative;
}
</style>

	<script>
		$(document).ready(function() {
			storeAllSelect();

		});
	</script>

	<script data-for="전체 상점 리스트 출력">
		function storeAllSelect() {
			var content = "";
			$.ajax({
				type : "POST",
				url : "/admin/manage_store/adminStoreList.json",
				cache : false,
				async : true,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						content += "<div class='Img'>";
						content += "<a class='hoverTrigger' href='javascript:load(" + item.shopNum + ");'>";
						content += "<div class='overlay'>";
						content += "<h2 style='color:white; text-align:center; margin-top:45%;'>" + item.shopName + "</h2>";
						content += "</div>";
						content += "<img id='shopTitlePicPath' src='<c:url value='/resources/image/shop/"+item.shopTitlePicPath+"'/>'>";
						content += "</a>";
						content += "</div>";
						numOfReview = index + 1;
					})

					if (numOfReview == 0) {
						$("#portfolio-list").append("<h4>No Result");
					} else {
						$("#portfolio-list").append(content);
					}

					if (numOfReview > 7) {
						var n = 8;
						$(".Img").slice(8, numOfReview).css("display", "none");

						$("#loadMore").click(function() {
							$('.Img').slice(n, n + 8).show();
							n = n + 8;
							//alert(numOfReview<n);

							if (numOfReview < n) {
								alert("결과가 더이상 존재하지 않습니다.");
							}
						})
					}

					/*사진 크기 조절*/
					$('img#shopTitlePicPath').css({
						'width' : '259px',
						'height' : '250px'
					});

					/* hoverTrigger */
					$('.hoverTrigger').on("mouseenter", function() {
						$(this).find('.overlay').show();
					});
					$('.hoverTrigger').on("mouseleave", function() {
						$(this).find('.overlay').hide();
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="상점 정보 로드">
		function load(num) {
			var shopNum = num;
			var dataForm = {
				shopNum : shopNum
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_store/adminStore",
				data : dataForm,
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$("#myModal").modal('show');
					for (var i = 0; i < response.length; i++) {

						$(".modal-title").html(response[i].shopName);
						$("#shopName").val(response[i].shopName);
						$("#shopAddr").val(response[i].shopAddr);
						$("#shopHp").val(response[i].shopHp);
						$("#shopTel").val(response[i].shopTel);
						$("#shopDetailDesc").val(response[i].shopDetailDesc);
						setMapApi(response[i].shopAddrApi1, response[i].shopAddrApi2);
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="다음 지도 API">
		function setMapApi(shopAddrApi, shopAddrApi2) {
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();

				var mapContainer = document.getElementById('staticMap'), // 지도를 표시할 div 
				mapOption = {
					center : new daum.maps.LatLng(shopAddrApi, shopAddrApi2), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				var map = new daum.maps.Map(mapContainer, mapOption);

				var markerPosition = new daum.maps.LatLng(shopAddrApi, shopAddrApi2);

				var marker = new daum.maps.Marker({
					position : markerPosition
				});

				marker.setMap(map);
			})
		}
	</script>

</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}" />

	<div class="container">
		<div class="page_title">상점보기</div>
		<hr />
		<!-- 포트폴리오 시작 -->
		<div class="boundingBox" id="content">
			<ul id="portfolio-list" class="listDiv">

			</ul>
		</div>
	</div>
	<input type="button" class="btn btn-info" id="loadMore" style="width: 15%; height: 40px; font-weight: bold; margin-left: 43%" value="More"></input>


	<!-- 상점별 보기-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="storeInfoModal"></h4>
				</div>
				<div class="modal-body"></div>
				<form class="form-horizontal myform">
					<div class="form-group">
						<label class="col-sm-2 control-label">상점명</label>
						<div class="col-sm-3">
							<input class="form-control input-sm" id="shopName" type="text" readonly />
						</div>

						<label class="col-sm-2 control-label">주소</label>
						<div class="col-sm-4">
							<input class="form-control input-sm" id="shopAddr" type="text" readonly />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">전화번호</label>
						<div class="col-sm-3">
							<input class="form-control input-sm" id="shopTel" type="text" readonly />
						</div>

						<label class="col-sm-2 control-label">홈페이지</label>
						<div class="col-sm-4">
							<input class="form-control input-sm" id="shopHp" type="text" readonly />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">상점소개</label>
						<div class="col-sm-9">
							<textarea class="form-control" id="shopDetailDesc" style="resize: none; height: 180px" disabled></textarea>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">위치</label>
						<div class="col-sm-9">
							<div id="staticMap" style="width: 660px; height: 240px;"></div>
						</div>
					</div>
				</form>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</gachonTag:html>