<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES" jQueryUI="YES">
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=a06be78220061f3fc867e63e61abf9a0"></script>

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

.pgwSlideshow .ps-current .ps-next {
	right: 1;
	top: 40%;
}

.pgwSlideshow {
	margin-left: 2%;
	width: 49%;
}

.pgwSlideshow.narrow .ps-list .ps-next {
	display: none;
}

.pgwSlideshow.narrow .ps-list .ps-prev {
	display: none;
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
	height: 400px;
	margin-left: 2px;
	margin-top: 2px;
}

.ps-list {
	border-left: 1px groove #F8F8F8;
	border-top: 1px groove #F8F8F8;
	border-right: 1px groove #F8F8F8;
	border-bottom: 1px groove #F8F8F8;
}

.th-inner {
	text-align: center;
}
</style>

	<script>
		$(document).ready(function() {
			listAllSelect();

			$("#openDate").datepicker({
				dateFormat : 'yy-mm-dd'
			});

			var pgwSlideshow;
			$('#albaInfo').on('shown.bs.modal', function() {
				pgwSlideshow = $('.pgwSlideshow').pgwSlideshow();
				pgwSlideshow.reload();
				$('.ps-list .ps-prev').css("display", "none");
				$('.ps-list .ps-next').css("display", "none");
			});

			$('#albaInfo').on('hidden.bs.modal', function() {
				pgwSlideshow.destroy(true);
				return false;
			});
		});
	</script>



	<script data-for="전체 아르바이트 리스트 가져오기">
		function listAllSelect() {
			$.ajax({
				type : "POST",
				url : "/outCommunity/alba/albaList.json",
				cache : false,
				async : true,
				dataType : "JSON",
				success : function(response) {
					$('#albaTable').bootstrapTable('load', response).on('check.bs.table', function(e, row) {
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="아르바이트 정보 등록">
		function insert() {
			var formData = new FormData();
			formData.append("boardTitle", $('#boardTitle').val());
			formData.append("corporate", $('#corporate').val());
			formData.append("emailAddr", $('#emailAddr').val());
			formData.append("recuritNum", $('#recuritNum').val());
			formData.append("albaAddrApi1", $('#albaAddrApi1').val());
			formData.append("albaAddrApi2", $('#albaAddrApi2').val());
			formData.append("closeDate", $('#closeDate').val());
			formData.append("gender", $("#gender option:selected").text());
			formData.append("age", $('#age').val());
			formData.append("academicBg", $('#academicBg').val());
			formData.append("workForm", $("#workForm option:selected").text());
			formData.append("workDay", $("#workDay option:selected").text());
			formData.append("workTime", $('#workTime').val());
			formData.append("pay", $('#pay').val());
			formData.append("workType", $('#workType').val());
			formData.append("empWalfare", $('#empWalfare').val());
			formData.append("workArea", $('#workArea').val());
			formData.append("corPicPath1", $("input[name=corPicPath]")[0].files[0]);
			formData.append("corPicPath2", $("input[name=corPicPath]")[1].files[0]);
			formData.append("corPicPath3", $("input[name=corPicPath]")[2].files[0]);
			formData.append("crtUser", "${LOGIN_MEMBER.memberName}");
			formData.append("updtUser", "N");

			$.ajax({
				type : "POST",
				url : "/outCommunity/alba/albaInsert",
				cache : false,
				async : true,
				data : formData,
				dataType : "JSON",
				processData : false,
				contentType : false,
				success : function(response) {
					GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
					$('#event_modal').modal('hide');
					$('#albaForm')[0].reset();
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

	<script data-for="아르바이트 공고 수정">
		function update() {
			var dataForm = {
				boardNum : $('#albaTable').bootstrapTable('getSelections')[0].albaBoardNum,
				boardTitle : $('#boardTitle').val(),
				corporate : $('#corporate').val(),
				emailAddr : $("#emailAddr").val(),
				recuritNum : $('#recuritNum').val(),
				albaAddrApi1 : $('#albaAddrApi1').val(),
				albaAddrApi2 : $('#albaAddrApi2').val(),
				closeDate : $('#closeDate').val(),
				gender : $("#gender option:selected").text(),
				age : $('#age').val(),
				academicBg : $('#academicBg').val(),
				workForm : $("#workForm option:selected").text(),
				workDay : $("#workDay option:selected").text(),
				workTime : $('#workTime').val(),
				pay : $('#pay').val(),
				workType : $('#workType').val(),
				workArea : $('#workArea').val(),
				empWalfare : $('#empWalfare').val(),
				corPicPath1 : $('#corPicPath1').val(),
				corPicPath2 : $('#corPicPath2').val(),
				corPicPath3 : $('#corPicPath3').val(),
				updtUser : "${LOGIN_MEMBER.memberName}"
			};

			$.ajax({
				type : "POST",
				url : "/outcommunity/alba/updateAlba",
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

	<script data-for="아르바이트 공고 삭제">
		$(function() {
			$("#deleteBtn").click(function() {
				var dataForm = {
					boardNum : $('#albaTable').bootstrapTable('getSelections')[0].albaBoardNum
				};

				if ("${LOGIN_MEMBER.memberName}" == $('#albaTable').bootstrapTable('getSelections')[0].crtUser || "${LOGIN_MEMBER.memberType}" == "ADM") {
					if (confirm("삭제하시겠습니까??") == true) {
						$.ajax({
							type : "POST",
							url : "/outcommunity/alba/deleteAlba",
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
					} else {
						return;
					}
				} else {
					GachonNoty.showCustomNoty("삭제 권한이 없습니다");
				}
			})
		})
	</script>


	<script>
		function modalType(type) {
			inputTextInit("#event_modal");

			if (type == "write") {
				$('#saveEvent').attr('href', 'javascript:insert();');
				$("#event_modal").modal('show');

			} else if (type == "rewrite") {
				$(function() {
					var dataForm = {
						boardNum : $('#albaTable').bootstrapTable('getSelections')[0].albaBoardNum
					};

					$.ajax({
						type : "POST",
						url : "/outcommunity/alba/updateLoadData",
						cache : false,
						async : true,
						data : dataForm,
						dataType : "JSON",
						success : function(response) {
							$.each(response, function(index, item) {
								$("#event_modal").modal('show');
								$('h2[id="myModalLabel"]').html("아르바이트 공고 수정하기");
								$('input[id="boardTitle"]').val(item.boardTitle);
								$('input[id="corporate"]').val(item.corporate);
								$('input[id="closeDate"]').val(item.closeDate);
								$('input[id="recuritNum"]').val(item.recuritNum);
								$('input[id="albaAddrApi1"]').val(item.albaAddrApi1);
								$('input[id="albaAddrApi2"]').val(item.albaAddrApi2);
								$('#gender option:selected').text(item.gender);
								$('input[id="age"]').val(item.age);
								$('input[id="academicBg"]').val(item.academicBg);
								$('input[id="emailAddr"]').val(item.emailAddr);
								$('#workForm option:selected').text(item.workForm);
								$('input[id="workType"]').val(item.workType);
								$('#workDay option:selected').text(item.workDay);
								$('input[id="workTime"]').val(item.workTime);
								$('input[id="pay"]').val(item.pay);
								$('input[id="empWalfare"]').val(item.empWalfare);
								$('input[id="workArea"]').val(item.workArea);
								$('input[id="corPicPath1"]').val(item.corPicPath1);
								$('input[id="corPicPath2"]').val(item.corPicPath2);
								$('input[id="corPicPath3"]').val(item.corPicPath3);

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


	<script data-for="아르바이트 정보 출력">
		$(function() {
			var content = "";
			$('#albaTable').on(
					'dbl-click-row.bs.table',
					function(e, row) {
						var boardNum = row.albaBoardNum;
						var updateLove = row.love;
						var dataForm = {
							boardNum : boardNum
						};
						$.ajax({
							type : "POST",
							url : "/outcommunity/alba/updateLoadData",
							cache : false,
							async : true,
							data : dataForm,
							dataType : "JSON",
							success : function(response) {
								$.each(response, function(index, item) {
									$("#albaInfo").modal('show');
									$('h2[id="albaInfoh2"]').html(item.boardTitle);
									$('input[id="corporate"]').val(item.corporate);
									$('input[id="closeDate"]').val(item.closeDate);
									$('input[id="recuritNum"]').val(item.recuritNum);
									$('input[id="gender"]').val(item.gender);
									$('input[id="age"]').val(item.age);
									$('input[id="academicBg"]').val(item.academicBg);
									$('input[id="emailAddr"]').val(item.emailAddr);
									$('input[id="workForm"]').val(item.workForm);
									$('input[id="workType"]').val(item.workType);
									$('input[id="workDay"]').val(item.workDay);
									$('input[id="workTime"]').val(item.workTime);
									$('input[id="pay"]').val(item.pay);
									$('input[id="empWalfare"]').val(item.empWalfare);
									$('input[id="workArea"]').val(item.workArea);
									$('#loveBtn').html("♡" + row.love);
									setMapApi(item.albaAddrApi1, item.albaAddrApi2);

									content += "<li><img id='corPicPath' src='<c:url value='/resources/image/alba/"+item.corPicPath1+"'/>' alt='"
											+ item.corporate + "'></li>";
									content += "<li><img id='corPicPath' src='<c:url value='/resources/image/alba/"+item.corPicPath2+"'/>'></li>";
									content += "<li><img id='corPicPath' src='<c:url value='/resources/image/alba/"+item.corPicPath3+"'/>'></li>";
									$("#pg").html(content);

									content = "";

								})
							},
							error : function(request, status, errorThrown) {
								alert("${AJAX_CONNECTION_ERROR}");
							}
						});

						$("#loveBtn").click(function() {
							love(boardNum, ++updateLove);

						})
					});
		})
	</script>

	<script data-for="다음 지도 API">
		function setMapApi(albaAddrApi1, albaAddrApi2) {
			$('#albaInfo').on('shown.bs.modal', function() {
				$('#myInput').focus();

				var mapContainer = document.getElementById('staticMap'), // 지도를 표시할 div 
				mapOption = {
					center : new daum.maps.LatLng(albaAddrApi1, albaAddrApi2), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};

				var map = new daum.maps.Map(mapContainer, mapOption);

				var markerPosition = new daum.maps.LatLng(albaAddrApi1, albaAddrApi2);

				var marker = new daum.maps.Marker({
					position : markerPosition
				});

				marker.setMap(map);
			})
		}
	</script>



	<script data-for="아르바이트 공고 추천수">
		function love(boardNum, updateLove) {
			var a = boardNum;
			var b = updateLove
			var dataForm = {
				boardNum : a,
				love : b
			}
			$.ajax({
				type : "POST",
				url : "/outcommunity/alba/updateLove",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$('#loveBtn').html("♡" + b);
					listAllSelect();
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>


	<script data-for="아르바이트 공고 조회수">
		$(function() {
			$('#albaTable').on('dbl-click-row.bs.table', function(e, row) {
				var albaHit = ++row.hit;
				var dataForm = {
					boardNum : row.albaBoardNum,
					hit : albaHit
				};
				$.ajax({
					type : "POST",
					url : "/outcommunity/alba/updateHit",
					cache : false,
					async : true,
					data : dataForm,
					dataType : "JSON",
					success : function(response) {
						$('#albaTable').bootstrapTable('load', response)
					},
					error : function(request, status, errorThrown) {
						GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
					}
				});
			})
		})
	</script>
</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<link rel="stylesheet" href="${PATH_PLUGIN}/whatIsThis/pgwslideshow.min.css" />
	<script src="${PATH_PLUGIN}/whatIsThis/pgwslideshow.min.js"></script>

	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}" />


	<div class="container">
		<div class="page_title">아르바이트 공고</div>
		<hr />
		<table id="albaTable" data-toggle="table" data-show-columns="true" data-search="true" data-show-refresh="true" data-show-toggle="false"
			data-show-export="true" data-pagination="true" data-height="500">
			<thead>
				<tr id=tr>
					<th data-field="state" data-radio="true"></th>
					<th data-field="albaBoardNum">게시물번호</th>
					<th data-field="boardTitle">제목</th>
					<th data-field="crtUser">작성자</th>
					<th data-field="crtdt">작성일</th>
					<th data-field="hit">조회수</th>
					<th data-field="love">추천수</th>
				</tr>
			</thead>
		</table>

		<input type="button" class="btn btn-info" data-toggle="modal" onclick="modalType('write');" value="글쓰기"></input> <input type="button" class="btn btn-info"
			onclick="modalType('rewrite');" style="margin-left: 1%;" value="수정하기"></input> <input type="button" class="btn btn-info" id="deleteBtn"
			style="margin-left: 1%;" value="삭제하기"></input>
	</div>

	<!-- 아르바이트 공고 등록하기 -->
	<div class="modal fade bs-example-modal-lg" id="event_modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="myModalLabel" style="font-weight: bold; text-align: center;">아르바이트 공고 등록하기</h2>
				</div>
				<div class="modal-body" style="height: 80%;">
					<form id="albaForm" class="form-horizontal myform" method="POST" enctype="multipart/form-data">
						<div class="form-group">
							<label for="boardTitle" class="col-sm-2 control-label">글제목</label>
							<div class="col-sm-4">
								<input id="boardTitle" class="form-control input-sm" type="text" />
							</div>

							<label for=corporate class="col-sm-2 control-label" style="margin-left: -3%">회사명</label>
							<div class="col-sm-4">
								<input id="corporate" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="emailAddr" class="col-sm-2 control-label">담당자 연락처</label>
							<div class="col-sm-4">
								<input id="emailAddr" class="form-control input-sm" type="text" />
							</div>

							<label for="recuritNum" class="col-sm-2 control-label" style="margin-left: -3%">모집인원</label>
							<div class="col-sm-4">
								<input id="recuritNum" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="emailAddr" class="col-sm-2 control-label">위치(API주소)</label>
							<div class="col-sm-4">
								<input id="albaAddrApi1" class="form-control input-sm" type="text" />
							</div>

							<label for="recuritNum" class="col-sm-2 control-label" style="margin-left: -3%">위치(API주소)</label>
							<div class="col-sm-4">
								<input id="albaAddrApi2" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="closeDate" class="col-sm-2 control-label">마감일</label>
							<div class="col-sm-4">
								<input id="closeDate" class="form-control input-sm" type="text" />
							</div>

							<label for="gender" class="col-sm-2 control-label" style="margin-left: -3%">성별</label>
							<div class="col-sm-4">
								<select id="gender" style="width: 100%; background-color: white;">
									<option value="">여성</option>
									<option value="">남성</option>
									<option value="">무관</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="age" class="col-sm-2 control-label">연령</label>
							<div class="col-sm-4">
								<input id="age" class="form-control input-sm" type="text" />
							</div>

							<label for="academicBg" class="col-sm-2 control-label" style="margin-left: -3%">학력</label>
							<div class="col-sm-4">
								<input id="academicBg" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="workForm" class="col-sm-2 control-label">근무형태</label>
							<div class="col-sm-4">
								<select id="workForm" style="width: 100%; background-color: white;">
									<option value="">정규직</option>
									<option value="">파트타이머</option>
								</select>
							</div>

							<label for="workDay" class="col-sm-2 control-label" style="margin-left: -3%">근무요일</label>
							<div class="col-sm-4">
								<select id="workDay" style="width: 100%; background-color: white;">
									<option value="">주5일(월~금)</option>
									<option value="">주말(토,일)</option>
									<option value="">추후협의</option>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="workTime" class="col-sm-2 control-label">근무시간</label>
							<div class="col-sm-4">
								<input id="workTime" class="form-control input-sm" type="text" />
							</div>

							<label for="pay" class="col-sm-2 control-label" style="margin-left: -3%">급여</label>
							<div class="col-sm-4">
								<input id="pay" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="workType" class="col-sm-2 control-label">업직종</label>
							<div class="col-sm-4">
								<input id="workType" class="form-control input-sm" type="text" />
							</div>

							<label for="workArea" class="col-sm-2 control-label" style="margin-left: -3%">근무지역</label>
							<div class="col-sm-4">
								<input id="workArea" class="form-control input-sm" type="text" />
							</div>
						</div>

						<div class="form-group">
							<label for="empWalfare" class="col-sm-2 control-label">복리후생</label>
							<div class="col-sm-10">
								<textarea id="empWalfare" class="form-control input-sm" type="text"></textarea>
							</div>
						</div>
						<!-- textarea 사이즈 조정하기 -->

						<div class="form-group">
							<label for="corPicPath1" class="col-sm-2 control-label">사진 첨부파일1</label>
							<div class="col-sm-9">
								<input id="corPicPath1" type="file" name="corPicPath" class="btn btn-default" style="font-weight: bold; font-size: 11px; width: 108%;"></input>
							</div>
						</div>

						<div class="form-group">
							<label for="corPicPath2" class="col-sm-2 control-label">사진 첨부파일2</label>
							<div class="col-sm-9">
								<input id="corPicPath2" type="file" name="corPicPath" class="btn btn-default" style="font-weight: bold; font-size: 11px; width: 108%;"> </input>
							</div>
						</div>

						<div class="form-group">
							<label for="corPicPath3" class="col-sm-2 control-label">사진 첨부파일3</label>
							<div class="col-sm-9">
								<input id="corPicPath3" type="file" name="corPicPath" class="btn btn-default" style="font-weight: bold; font-size: 11px; width: 108%;"> </input>
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

	<!-- 알바 채용 정보 모달 -->
	<div class="modal fade bs-example-modal-lg" id="albaInfo" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h2 class="modal-title" id="albaInfoh2" style="font-weight: bold; text-align: center;"></h2>
				</div>
				<div class="modal-body" style="height: 100%">
					<div class="row">
						<div class="from-group">
							<div class="col-sm-6">
								<div id="slideDiv">
									<h2 id="map" style="font-size: 10.5pt; margin-bottom: 0px;">▣ 매장 전경</h2><hr />
									<ul id="pg" class="pgwSlideshow" style="margin: 0%;"></ul>
								</div>
							</div>
							
							<div class="col-sm-6">
								<h2 id="map" style="font-size: 10.5pt; margin-bottom: 0px;">▣ 위치 상세지도</h2><hr />
								<div id="staticMap" style="width: 100%; height: 360px;"></div>
							</div>
						</div>
						
						<div class="form-group">
							<div>
								<form class="form-horizontal" style="width:95%; margin-left:2.5%;">
									<h2 style="font-size: 11pt; margin-bottom: 0px; margin-top: 60%;">▣ 업무내용 및 근무조건</h2><hr />
									<div class="form-group">
										<label for="corporate" class="col-sm-2 control-label">회사명</label>
										<div class="col-sm-4">
											<input id="corporate" class="form-control input-sm"
												type="text" readonly />
										</div>

										<label for="closeDate" class="col-sm-2 control-label">마감일</label>
										<div class="col-sm-4">
											<input id="closeDate" class="form-control input-sm"
												type="text" readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="recuritNum" class="col-sm-2 control-label">모집인원</label>
										<div class="col-sm-4">
											<input id="recuritNum" class="form-control input-sm"
												type="text" readonly />
										</div>
										<label id="gender" for="Birth" class="col-sm-2 control-label">성별</label>
										<div class="col-sm-4">
											<input id="gender" class="form-control input-sm" type="text"
												readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="age" class="col-sm-2 control-label">나이</label>
										<div class="col-sm-4">
											<input id="age" class="form-control input-sm" type="text"
												readonly />
										</div>
										<label id="academicBg" for="Birth"
											class="col-sm-2 control-label">학력</label>
										<div class="col-sm-4">
											<input id="academicBg" class="form-control input-sm"
												type="text" readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="emailAddr" class="col-sm-2 control-label">담당자
											연락처</label>
										<div class="col-sm-4">
											<input id="emailAddr" class="form-control input-sm"
												type="text" readonly />
										</div>
										<label id="workForm" for="Birth"
											class="col-sm-2 control-label">근무형태</label>
										<div class="col-sm-4">
											<input id="workForm" class="form-control input-sm"
												type="text" readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="workType" class="col-sm-2 control-label">업직종</label>
										<div class="col-sm-4">
											<input id="workType" class="form-control input-sm"
												type="text" readonly />
										</div>
										<label id="workDay" for="Birth" class="col-sm-2 control-label">근무요일</label>
										<div class="col-sm-4">
											<input id="workDay" class="form-control input-sm" type="text"
												readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="workTime" class="col-sm-2 control-label">근무시간</label>
										<div class="col-sm-4">
											<input id="workTime" class="form-control input-sm"
												type="text" readonly />
										</div>
										<label id="pay" for="Birth" class="col-sm-2 control-label">시급</label>
										<div class="col-sm-4">
											<input id="pay" class="form-control input-sm" type="text"
												readonly />
										</div>
									</div>

									<div class="form-group">
										<label for="empWalfare" class="col-sm-2 control-label">복리후생</label>
										<div class="col-sm-4">
											<input id="empWalfare" class="form-control input-sm"
												type="text" readonly />
										</div>
										<label id="workArea" for="Birth"
											class="col-sm-2 control-label">근무지역</label>
										<div class="col-sm-4">
											<input id="workArea" class="form-control input-sm"
												type="text" readonly />
										</div>
									</div>
								</form>

							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button id="loveBtn" type="button" class="btn btn-warning">♡0</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end.modal -->

</body>
</gachonTag:html>