<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES" jQueryUI="YES">

	<style>
table {
	table-layout: auto;
}

hr {
	border: 1px solid gray;
	margin: 0 0 2% 0;
}

.btn btn-info {
	font-size: 12px;
	width: 10%;
	height: 33px;
	font-weight: bold;
	float: left;
}

.form-horizontal .form-group {
	margin-left: -5%;
}

.th-inner {
	text-align: center;
}
</style>

	<script>
		$(document).ready(function(){
			listAllSelect();
			
			$( "#openDate" ).datepicker({
			    dateFormat: 'yy-mm-dd'
			  });
		});
	</script>

	<script data-for="다음 지도 API">
		function setMapApi(eventAddrApi, eventAddrApi2) {
			$('#myModal').on('shown.bs.modal', function() {
				$('#myInput').focus();
				
				var mapContainer = document.getElementById('staticMap'), // 지도를 표시할 div 
			    mapOption = { 
			        center: new daum.maps.LatLng(eventAddrApi, eventAddrApi2), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };
				
				var map = new daum.maps.Map(mapContainer, mapOption);
				
				var markerPosition  = new daum.maps.LatLng(eventAddrApi, eventAddrApi2); 
				
				var marker = new daum.maps.Marker({
				    position: markerPosition
				});
				
				marker.setMap(map);
			})
		}
	</script>

	<script data-for="이벤트 전체 리스트 가져오기">
		function listAllSelect() {
			$.ajax({
				type : "POST",
				url : "/outcommuniy/event/evnetList.json",
				cache : false,
				async : true,
				dataType : "JSON",
				success : function(response) {
					$('#eventTable').bootstrapTable('load', response);
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="이벤트 등록">
		function insert() {
			var dataForm = {
				boardTitle : $('#boardTitle').val(),
				eventAddr : $('#eventAddr').val(),
				eventAddrApi : $("#eventAddrApi").val(),
				eventAddrApi2 : $("#eventAddrApi2").val(),
				openDate : $('#openDate').val(),
				eventDetail : $('#eventDetail').val(),
				crtUser: "${LOGIN_MEMBER.memberName}",
				updtUser : "N"
			};

			if ($("input[id=boardTitle]").val() == "") {
				GachonNoty.showCustomNoty("제목을 입력하세요");
				$("input[id=boardTitle]").focus();
				return false;
			} else if ($("input[id=openDate]").val() == "") {
				GachonNoty.showCustomNoty("이벤트 일시를 입력하세요");
				$("#input[id=openDate]").focus();
				return false;
			} else if ($("input[id=eventAddr]").val() == "") {
				GachonNoty.showCustomNoty("이벤트 장소를 입력하세요");
				$("#input[id=eventAddr]").focus();
				return false;
			} else if ($("input[id=eventAddrApi]").val() == "") {
				GachonNoty.showCustomNoty("이벤트 장소의 API주소를 입력하세요");
				$("#input[id=eventAddrApi]").focus();
				return false;
			} else if ($("input[id=eventDetail]").val() == "") {
				GachonNoty.showCustomNoty("이벤트 장소의 API주소를 입력하세요");
				$("#input[id=eventDetail]").focus();
				return false;
			}

			$.ajax({
				type : "POST",
				url : "/outcommunity/event/eventInsert",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					$('#event_modal').modal('hide');
					$('#eventForm')[0].reset();			
					location.reload();
					
					if (response.RESULT_CODE >= 0) {
						getList();
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="이벤트 수정">
		function update() {
			var dataForm = {
				boardNum : $('#eventTable').bootstrapTable('getSelections')[0].eventBoardNum,
				boardTitle : $('#boardTitle').val(),
				eventAddr : $('#eventAddr').val(),
				eventAddrApi : $('#eventAddrApi').val(),
				eventAddrApi2 : $('#eventAddrApi2').val(),
				openDate : $('input[name="openDate"]').val(),
				eventDetail : $('textarea[name="eventDetail"]').val(),
				updtUser: "${LOGIN_MEMBER.memberName}"
			};

			$.ajax({
				type : "POST",
				url : "/outcommunity/event/updateEvent",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					$('#event_modal').modal('hide');
					location.reload();

					if (response.RESULT_CODE >= 0) {
						getList();
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script>
		function modalType(type) {
			inputTextInit("#event_modal");

			if (type == "write") {
				$('#saveEvent').attr('href', 'javascript:insert();');
				$("#event_modal").modal('show');
				$('h2[id="myModalLabel"]').html("이벤트 등록하기");

			} else if (type == "rewrite") {
				$(function() {
					var dataForm = {
						boardNum : $('#eventTable').bootstrapTable('getSelections')[0].eventBoardNum
					};
					$.ajax({
						type : "POST",
						url : "/outcommunity/event/updateLoadData",
						cache : false,
						async : true,
						data : dataForm,
						dataType : "JSON",
						success : function(response) {
							$.each(response, function(index, item) {
								var id = "${LOGIN_MEMBER.memberName}";
								if (id == item.crtUser || "${LOGIN_MEMBER.memberType}" == "ADM") {
									$("#event_modal").modal('show');
									$('h2[id="myModalLabel"]').html("이벤트 수정하기");
									
									$('input[id="boardTitle"]').val(item.boardTitle);
									$('input[id="openDate"]').val(item.openDate);
									$('input[id="eventAddr"]').val(item.eventAddr);
									$('input[id="eventAddrApi"]').val(item.eventAddrApi);
									$('input[id="eventAddrApi2"]').val(item.eventAddrApi2);
									$('textarea[id="eventDetail"]').val(item.eventDetail);
								} else {
									GachonNoty.showCustomNoty("수정 권한이 없습니다");
								}
							})
						},
						error : function(request, status, errorThrown) {
							GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
						}
					});
				})
				$('#saveEvent').attr('href', 'javascript:update();');
			}

		}
	</script>


	<script data-for="이벤트 내용 출력">
		$(function () {
			$('#eventTable').on('dbl-click-row.bs.table', function(e, row) {
				var boardNum = row.eventBoardNum;
				var updateLove = row.love;
				var boardNum = row.eventBoardNum;
				var dataForm = {
					boardNum : boardNum
				};

				$.ajax({
					type : "POST",
					url : "/outcommunity/event/updateLoadData",
					cache : false,
					async : true,
					data : dataForm,
					dataType : "JSON",
					success : function(response) {
						$("#myModal").modal('show');
						$('h2[id="eventTitle"]').html(response[0].boardTitle);
						$('input[id="eventOpenDate"]').val(response[0].openDate);
						$('input[id="loc"]').val(response[0].eventAddr);
						$('textarea[id="detail"]').val(response[0].eventDetail);
						$('#loveBtn').html("♡"+row.love);
						console.info(response[0].eventAddrApi);
						console.info(response[0].eventAddrApi2);
						
						setMapApi(response[0].eventAddrApi, response[0].eventAddrApi2);
					},
					error : function(request, status, errorThrown) {
						GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
					}
				});
				
				$("#loveBtn").click(function(){
					love(boardNum, ++updateLove);	

				}) 
			});
		})
	</script>


	<script data-for="이벤트 추천">
		function love(boardNum, updateLove){
			var a = boardNum;
			var b = updateLove
			var dataForm = {
					boardNum : a,
					love : b
			}
			 $.ajax({
				type : "POST",
				url : "/outcommunity/event/updateLove",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$('#loveBtn').html("♡"+b);
					listAllSelect();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	
	</script>


	<script data-for="이벤트 조회수">
	$(function(){
		$('#eventTable').on('dbl-click-row.bs.table', function(e,row){
			var updateHit = ++row.hit;
			var dataForm={
					boardNum : row.eventBoardNum,
					hit : updateHit
			};

			$.ajax({		
				type : "POST",
				url : "/outcommunity/event/updataHit",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$('#eventTable').bootstrapTable('load', response)
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});	
		})
	})
	</script>


	<script data-for="이벤트 삭제">
		$(function() {
			$("#deleteBtn").click(function() {
				var dataForm = {
					boardNum : $('#eventTable').bootstrapTable('getSelections')[0].eventBoardNum
				};

						if("${LOGIN_MEMBER.memberName}" == $('#eventTable').bootstrapTable('getSelections')[0].crtUser ||
								"${LOGIN_MEMBER.memberType}" == "ADM"){
							if(confirm("삭제하시겠습니까??")==true){
								$.ajax({
									type : "POST",
									url : "/outcommunity/event/deleteEvent",
									cache : false,
									async : true,
									data : dataForm,
									dataType : "JSON",
									success : function(response) {
										GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
										location.reload();
									},
									error : function(request, status, errorThrown) {
										GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
									}
								});
							}else{
								return;
							}
						}else {
					GachonNoty.showCustomNoty("삭제 권한이 없습니다");
					}
			})
		})
	</script>
</gachonTag:script>


<body>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}" />
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a06be78220061f3fc867e63e61abf9a0"></script>

	<div class="container">
		<div class="page_title">이벤트 정보</div>
		<hr />
		<table id="eventTable" data-toggle="table" data-show-columns="true" data-search="true" data-show-refresh="true" data-show-toggle="false"
			data-show-export="true" data-pagination="true" data-height="500">
			<thead>
				<tr>
					<th data-field="state" data-radio="true"></th>
					<th data-field="eventBoardNum">게시물번호</th>
					<th data-field="boardTitle">제목</th>
					<th data-field="crtUser">작성자</th>
					<th data-field="crtdt">작성일</th>
					<th data-field="hit">조회수</th>
					<th data-field="love">추천수</th>
				</tr>
			</thead>
		</table>

		<input type="button" class="btn btn-info" data-toggle="modal" onclick="modalType('write');" value="글쓰기"></input> <input type="button" class="btn btn-info"
			onclick="modalType('rewrite');" value="수정하기"></input> <input type="button" class="btn btn-info" id="deleteBtn" value="삭제하기"></input>
	</div>


	<!-- 이벤트 정보 입력하기 -->
	<div class="modal fade bs-example-modal-lg" id="event_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="myModalLabel" style="font-weight: bold; text-align: center;">이벤트 등록하기</h2>
				</div>

				<div class="modal-body" style="height: 60%;">
					<form class="form-horizontal myform" id="eventForm" action="javascript:insert();">
						<div class="form-group">
							<label for="boardTitle" class="col-sm-2 control-label">글제목</label>
							<div class="col-sm-4">
								<input id="boardTitle" class="form-control input-sm" type="text" />
							</div>

							<label for="openDate" class="col-sm-2 control-label">일시</label>
							<div class="col-sm-4">
								<input id="openDate" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="eventAddr" class="col-sm-2 control-label">장소</label>
							<div class="col-sm-4">
								<input id="eventAddr" class="form-control input-sm" type="text" />
							</div>

							<label for="eventAddrApi" class="col-sm-2 control-label">위치URL</label>
							<div class="col-sm-2">
								<input id="eventAddrApi" class="form-control input-sm" type="text" />
							</div>
							<div class="col-sm-2">
								<input id="eventAddrApi2" class="form-control input-sm" type="text" />
							</div>

						</div>

						<div class="form-group">
							<label for="eventDetail" class="col-sm-2 control-label">상세정보</label>
							<div class="col-sm-10">
								<textarea id="eventDetail" class="form-control" id="message-text" style="resize: none; height: 240px"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer" style="text-align: center;">
					<a href="#" id="saveEvent" class="btn btn-success">저장</a> <a href="#" class="btn btn-warning" data-dismiss="modal">닫기</a>
				</div>
			</div>
		</div>
	</div>
	</div>
	<!-- end.modal -->


	<!-- 이벤트 정보 모달 -->
	<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="eventTitle" style="font-weight: bold; text-align: center;"></h2>
				</div>
				<div class="modal-body" style="height: 85%;">

					<form class="form-horizontal myform">
						<div class="form-group">
							<label for="eventOpenDate" class="col-sm-2 control-label">일시</label>
							<div class="col-sm-9">
								<input class="form-control input-sm" id="eventOpenDate" type="text" readonly />
							</div>
						</div>

						<div class="form-group">
							<label for="loc" class="col-sm-2 control-label">장소</label>
							<div class="col-sm-9">
								<input class="form-control input-sm" id="loc" type="text" readonly />
							</div>
						</div>

						<div class="form-group">
							<label for="staticMap" class="col-sm-2 control-label">위치</label>
							<div class="col-sm-9">
								<div id="staticMap" style="width: 655px; height: 250px;"></div>
							</div>
						</div>

						<div class="form-group">
							<label for="detail" class="col-sm-2 control-label">상세정보</label>
							<div class="col-sm-9">
								<textarea class="form-control" id="detail" style="resize: none; height: 240px" disabled></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button id="loveBtn" type="button" class="btn btn-warning">♡0</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

				</div>

			</div>
		</div>
	</div>
	<!-- end.modal -->



</body>
</gachonTag:html>