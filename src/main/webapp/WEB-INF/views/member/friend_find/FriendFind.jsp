<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">

<link rel="stylesheet" href="/resources/demos/style.css">

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
}

.friendList tbody tr {
	border: solid 1px #E7E7E7;
}

.verticalMargin {
	margin-bottom: 3%;
}

<!-- modal내 시간표 css -->
/* --- The Table Structure --- */
.scheduleTable {
	border-collapse: separate;
	border-spacing: 0;
	width: 100%;
}

.scheduleTable  tr  th,.scheduleTable  tr  td {
	border-right: 1px solid #bbb;
	border-bottom: 1px solid #bbb;
	box-shadow: 2px 2px 1px #e5dfcc;
	text-align: center;
}

.scheduleTable  tr  th:first-child,.scheduleTable  tr  td:first-child {
	border-left: 1px solid #bbb;
}

.scheduleTable  tr  th {
	border-top: 1px solid #bbb;
}

/* top-left border-radius */
.scheduleTable  tr:first-child  th:first-child {
	border-top-left-radius: 6px;
}

/* top-right border-radius */
.scheduleTable  tr:first-child  th:last-child {
	border-top-right-radius: 6px;
}

/* bottom-left border-radius */
.scheduleTable  tr:last-child  td:first-child {
	border-bottom-left-radius: 6px;
}

/* bottom-right border-radius */
.scheduleTable  tr:last-child  td:last-child {
	border-bottom-right-radius: 6px;
}

/* -- The Stlyes -- 
	body {
		margin: 30px;
		background: #ECEAE3;
		font-family: 'Muli', Serif;
	} */
.scheduleTable  th,.scheduleTable  td {
	padding: 8px 20px;
}

.scheduleTable  th {
	background: #E5E6EB;
	color: #111;
}

.scheduleTable  td {
	background: #EFF1F6;
}

<!-- modal내 시간표 끝 -->

<!-- CSS -->



<!-- CSS 끝 -->

</style>


	<script>
		//초기 로드 테이블
		$(document).ready(function() {
			selectMst();
		});
	</script>

	<!--  selectFnd MST 테이블 Ajax -->
	<script>
		function selectMst() {
			var sessionId = '${LOGIN_MEMBER.memberId}';
			
			var dataForm = {
				memberId : sessionId
			};
			$.ajax({
				type : "POST",
				url : "/member/friend_find/selectFriendFindInfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					
					drawList(response);
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		
		<!-- 선택한 친구의 modal 내용 정보 -->
		function selectModalInfo(id) {
			var selectId = id;
			
			var dataForm = {
				memberId : selectId
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_member/friendInfo.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					drawModal(response);
					document.getElementById("user").value = response[0].memberName;
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		
		<!-- 선택한 친구의 modal 시간표 데이터 가져오기 -->	
		function selectFriendSchedule(id) {
			var selectId = id;
			
			// refresh
			$('.scheduleTable tbody td').html('');
			$(".scheduleTable tbody td").removeAttr("style");
			
			var dataForm = {
				memberId : selectId	
			};
			var color = [ "#FFA7A7", "#FFC19E", "#FFE08C", "#CEF279", "#B7F0B1", "#D1B2FF", "#FFB2F5", "#B2EBF4" ];
			$.ajax({
				type : "POST",
				url : "/admin/manage_course/applicantState.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						var kssr = item.lecTime.split(',');
						
						for(var i=0 in kssr){
							$('td[id=' + kssr[i] + ']').html("[" + item.courseName + "]" + "<br/>" + item.lecRoom).css('background-color', color[index]);
						} 
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		
		<!-- 친구 정보 리스트를 draw -->
		function drawList(response) {			
			var strHtml="";		// 묶어줄 녀석
			var friendCount="";
			
			if(response.length==0){
				friendCount += "<p>검색된 결과가 없습니다.</p>";
			}else{
				friendCount += "<p>"+response.length+"명이 검색되었습니다.</p>";
				
				for(var i=0; i<response.length; i++){
					strHtml += "<div id='list' class='list-group-item'>"
					strHtml += "<img class='img-circle' style='width:110px; height:110px; float:left; margin-right:20px;' src="+ "/" + response[i].profileImgPath+"/>"
					strHtml += "<p class='list-group-item-text'>"+response[i].memberName+"</p>"
					strHtml += "<p class='list-group-item-text'>"+response[i].memberId+"</p>"
	 				strHtml += "<p class='list-group-item-text'>"+response[i].department_nm+"</p>"
	 				strHtml += "<p class='list-group-item-text' style='margin-bottom:5px;'>"+response[i].major_nm+"</p>"
	 				
					if(response[i].isFnd === 'Y'){		// 현재 친구인 애들은 ... 이렇게 처리
						strHtml += "<div class='btn-group'>"
						strHtml += "<button type='button' class='btn btn-sm btn-info'>✔ &nbsp; 친구</button>"
						strHtml += "<button type='button' class='btn btn-sm btn-info dropdown-toggle' data-toggle='dropdown' style='margin-right:2px;'><span class='caret'></span></button>"
						strHtml += "<ul class='dropdown-menu'>"
						strHtml += "<li><a href='#' onclick='deleteFnd("+response[i].memberId+");return false;' style='color:black; width:90px;'>친구 끊기</a></li>"
						strHtml += "</ul></div>"

					}else{					// 현재 친구가 아닌애들은... 이렇게 처리
						strHtml += "<button type='button' class='btn btn-sm btn-default' style='margin-right:2px; width:90px;' onclick='insertFnd("+response[i].memberId+");return false;'>친구추가</button>"
					}
					strHtml += "<button type='button' data-toggle='modal' data-target='#friendInfo' onclick='selectModalInfo("+response[i].memberId+"); selectFriendSchedule("+response[i].memberId+");' class='btn btn-sm btn-warning' style='width:90px;'>친구정보</button></p></div>"
					isFriend=0;
				}
			}
			$('#list').html(strHtml);
			$('.friendCounter').html(friendCount);
		}
		
		function drawModal(response) {
			var strHtml="";		// 묶어줄 녀석
			
			strHtml += "<div class='list-group-item'>"
			strHtml += "<img style='width:130px; height:130px; float:left; margin-right:30%;' src="+ "/" + response[0].profileImagePath+"/>"
			strHtml += "<p class='list-group-item-text' style='font-weight:bold; float:left; margin-right:15%;'>이름</p>"
			strHtml += "<p class='list-group-item-text' style='margin-bottom:3%;'>"+response[0].memberName+"</p>"
			strHtml += "<p class='list-group-item-text' style='font-weight:bold; float:left; margin-right:15%;'>학번</p>"
			strHtml += "<p class='list-group-item-text' style='margin-bottom:3%;'>"+response[0].memberId+"</p>"
			strHtml += "<p class='list-group-item-text' style='font-weight:bold; float:left; margin-right:9%;'>단과대학</p>"
	 		strHtml += "<p class='list-group-item-text' style='margin-bottom:3%;'>"+response[0].department_nm+"</p>"
	 		strHtml += "<p class='list-group-item-text' style='font-weight:bold; float:left; margin-right:15%;'>전공</p>"
	 		strHtml += "<p class='list-group-item-text'>"+response[0].major_nm+"</p>"
	 		
	 		// 시간표

			$('.modal-group').html(strHtml);
		}
	</script>
	
	<!-- 친구끊기 alert 할수있으면 하기~ -->
	<script>
	function alert(){
		
		
	}
	
	</script>

	<!-- 학부전공 필터링 Ajax -->
	<script>
		function majorFilter() {

			var dataForm = {
				grcode : 'MAJOR',
				code : $("#department_s option:selected").val()
			};
			$.ajax({
				type : "POST",
				url : "/common/code/codeDETWithCode.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#major_s').html('');

					$('#major_s').append('<option value="">전체</option>');
					$.each(response, function(index, code) {
						$('#major_s').append('<option value='+code.value + '>' + code.label + '</option>');

					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>
	
	<!-- 검색 필터 selectMst() -->
	<script>
	function selectFilterMst() {			
			var dataForm = {
				sessionId : '${LOGIN_MEMBER.memberId}',
				memberId :  $('#memberNum_s').val(),
				memberName : $('#memberName_s').val(),
				memberType : $("#memberType_s option:selected").val(),
				college : $("#college_s option:selected").val(),
				major : $("#major_s option:selected").val()
			};
			$.ajax({
				type : "POST",
				url : "/member/friend_find/selectFilterFnd",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#list').html('');
					$('.friendCounter').html('');
					drawList(response);
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>
	
	<!-- insertFnd(response[i].memberId) 친구추가 -->
	<script>
	function insertFnd(memberId){
		var sessionId = '${LOGIN_MEMBER.memberId}';
		var fndId = memberId;
		
		var dataForm = {
				memberId : sessionId,
				fndMemberId : fndId,
				updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/member/friend_find/insertFriendFindInfo.insert", 
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				$('#list').html('');
				$('.friendCounter').html('');
				
				selectMst();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	</script>
	
	
	<!-- deleteFnd(response[i].memberId) 친구삭제-->
	<script>
	function deleteFnd(memberId) {
		var sessionId = '${LOGIN_MEMBER.memberId}';
		var fndId = memberId;
		
		var dataForm = {
			memberId : sessionId,
			fndMemberId : fndId,
			updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/member/friend_find/deleteFriendFindInfo.delete",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				$('#list').html('');
				$('.friendCounter').html('');
				
				selectMst();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	</script>
</gachonTag:script>
<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<div class="page_title">친구 찾기</div>
		<hr />
		<div class="col-sm-8">

			<p class="attr_name friendCounter"></p>
			
			<div class="verticalMargin"></div>
			<div class="content-side">
				<div id="list" class="list-group"></div>
			</div>
		</div>
		
		
		<!-- Side Controller -->
		<div class="col-sm-4">
			<div class="attr_name">친구 탐색기</div>
			<br>
			<div class="content-controller">
				<div class="row form-group">
					<div class="row form-group">
						<div class="col-sm-4 attr_name">이름</div>
						<div class="col-sm-8">
							<input type="text" id="memberName_s" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name">학번</div>
						<div class="col-sm-8">
							<input type="text" id="memberNum_s" class="form-control" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name">회원 구분</div>
						<div class="col-sm-8">
							<gachonTag:select code="${MEMBER_TYPE }" id="memberType_s"
								initLabel="전체" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name">소속대학</div>
						<div class="col-sm-8">
							<gachonTag:select code="${COLLEGE }" id="college_s"
								initLabel="전체" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name">단과대학</div>
						<div class="col-sm-8">
							<gachonTag:select code="${DEPARTMENT }" onChange="majorFilter();"
								id="department_s" initLabel="전체" />
						</div>
					</div>
					<div class="row form-group">
						<div class="col-sm-4 attr_name">전공</div>
						<div class="col-sm-8">
							<gachonTag:select code="${MAJOR }" id="major_s" initLabel="전체" />
						</div>
					</div>

					<hr />
					<div class="row form-group" style="text-align: center;">
						<button type="button" class="btn btn-info" onclick="selectFilterMst();">검색</button>
						<button type="button" class="btn btn-warning" onclick="refresh();">취소</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 친구정보 modal -->
		<div class="modal fade" id="friendInfo"
			tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<input class="modal-title" type="text" id="user" style="font-size: 14pt; color: #3163C9; font-weight:bold; border:0px;">
					</div>
					<div class="modal-body">
						<div class="modal-group"></div>
						<br>
						<section class="invoice">
							<table class="scheduleTable" style="width:100%; font-size:11px;">
								<thead>
									<tr>
										<th>시간/요일</th>
										<th>월</th>
										<!-- MO -->
										<th>화</th>
										<!-- TU -->
										<th>수</th>
										<!-- WE -->
										<th>목</th>
										<!-- TH -->
										<th>금</th>
										<!-- FR -->
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>1교시(09:00-09:50)<br>A교시(09:00-10:15)
										</th>
										<td id="MO1"></td>
										<!-- 월 -->
										<td id="TU1"></td>
										<!-- 화 -->
										<td id="WE1"></td>
										<!-- 수 -->
										<td id="TH1"></td>
										<!-- 목 -->
										<td id="FR1"></td>
										<!-- 금 -->
									</tr>
									<tr>
										<th>2교시(10:00-10:50)<br>B교시(10:30-11:45)
										</td>
										<td id="MO2"></td>
										<!-- 월 -->
										<td id="TU2"></td>
										<!-- 화 -->
										<td id="WE2"></td>
										<!-- 수 -->
										<td id="TH2"></td>
										<!-- 목 -->
										<td id="FR2"></td>
										<!-- 금 -->
									</tr>
									<tr>
										<th>3교시(11:00-11:50)<br>
										</td>
										<td id="MO3"></td>
										<!-- 월 -->
										<td id="TU3"></td>
										<!-- 화 -->
										<td id="WE3"></td>
										<!-- 수 -->
										<td id="TH3"></td>
										<!-- 목 -->
										<td id="FR3"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>4교시(12:00-12:50)<br>C교시(12:00-13:15)
										</td>
										<td id="MO4"></td>
										<!-- 월 -->
										<td id="TU4"></td>
										<!-- 화 -->
										<td id="WE4"></td>
										<!-- 수 -->
										<td id="TH4"></td>
										<!-- 목 -->
										<td id="FR4"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>5교시(13:00-13:50)<br>
										</td>
										<td id="MO5"></td>
										<!-- 월 -->
										<td id="TU5"></td>
										<!-- 화 -->
										<td id="WE5"></td>
										<!-- 수 -->
										<td id="TH5"></td>
										<!-- 목 -->
										<td id="FR5"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>6교시(14:00-14:50)<br>D교시(13:30-14:45)
										</td>
										<td id="MO6"></td>
										<!-- 월 -->
										<td id="TU6"></td>
										<!-- 화 -->
										<td id="WE6"></td>
										<!-- 수 -->
										<td id="TH6"></td>
										<!-- 목 -->
										<td id="FR6"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>7교시(15:00-15:50)<br>E교시(15:30-16:45)
										</td>
										<td id="MO7"></td>
										<!-- 월 -->
										<td id="TU7"></td>
										<!-- 화 -->
										<td id="WE7"></td>
										<!-- 수 -->
										<td id="TH7"></td>
										<!-- 목 -->
										<td id="FR7"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>8교시(16:00-16:50)<br>
										</td>
										<td id="MO8"></td>
										<!-- 월 -->
										<td id="TU8"></td>
										<!-- 화 -->
										<td id="WE8"></td>
										<!-- 수 -->
										<td id="TH8"></td>
										<!-- 목 -->
										<td id="FR8"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>9교시(17:30-18:20)<br>
										</td>
										<td id="MO9"></td>
										<!-- 월 -->
										<td id="TU9"></td>
										<!-- 화 -->
										<td id="WE9"></td>
										<!-- 수 -->
										<td id="TH9"></td>
										<!-- 목 -->
										<td id="FR9"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>10교시(18:25-19:15)<br>
										</td>
										<td id="MO10"></td>
										<!-- 월 -->
										<td id="TU10"></td>
										<!-- 화 -->
										<td id="WE10"></td>
										<!-- 수 -->
										<td id="TH10"></td>
										<!-- 목 -->
										<td id="FR10"></td>
										<!-- 금 -->
									</tr>

									<tr>
										<th>11교시(19:20-20:10)<br>
										</td>
										<td id="MO11"></td>
										<!-- 월 -->
										<td id="TU11"></td>
										<!-- 화 -->
										<td id="WE11"></td>
										<!-- 수 -->
										<td id="TH11"></td>
										<!-- 목 -->
										<td id="FR11"></td>
										<!-- 금 -->
									</tr>
								</tbody>
							</table>
						</section>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</gachonTag:html>