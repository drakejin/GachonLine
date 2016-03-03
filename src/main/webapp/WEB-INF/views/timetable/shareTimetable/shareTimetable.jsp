<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>

<gachonTag:html title="시간표 공유하기">
<gachonTag:script>

	<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/component.css"/ >
	<script src="${PATH_PLUGIN }/whatIsThis/jquery.stickyheader.js"></script>
	
	<style>
	hr {
		border: 1px solid gray;
		margin: 0 0 3% 0;
	}
	
	td {
		font-size: 13px;
	}
	
	tbody > tr > th{
		background : #E7E7E7;
		color : black;
	}
	
	table{
		border: 2px solid #bbb;
		outline : none;
	} 
	</style>

	<script>
		$(document).ready(function() {
			myInfo();
			mytimetableInfo();
			myFnd();
		});
	</script>

	<script data-for="시간표 가져오기">
		function mytimetableInfo() {
			var dataForm = {
				memberId : '${LOGIN_MEMBER.memberId}'
			};
			
			var color = [ "#FFA7A7", "#FFC19E", "#FFE08C", "#CEF279", "#B7F0B1", "#D1B2FF", "#FFB2F5", "#B2EBF4"];
			$.ajax({
				type : "POST",
				url : "/timetable/showTimetable/selectTimetableInfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					// table refresh
					$('.scheduleTable td').text("").css("background-color", "white");
					
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
	</script>

	<script "data-for="내정보가져오기">
		function myInfo() {
			var dataForm = {
				memberId : '${LOGIN_MEMBER.memberId}'
			};
			$.ajax({
				type : "POST",
				url : "/timetable/showTitmetable/selectMyinfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						$("#memberName").val(item.memberName);
						$("#memberId").val(item.memberId);
						$("#college").val(item.college_nm);
						$("#department").val(item.department_nm);
						$("#major").val(item.major_nm);
					})
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="내친구가져오기">
		function myFnd() {
			var content = "";
			var dataForm = {
				memberId : '${LOGIN_MEMBER.memberId}'
			};
			$.ajax({
				type : "POST",
				url : "/timetable/shareTitmetable/selectMyfnd",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						content += "<option value=''>" + item.memberId + "/" + item.memberName + "</option>";
					});

					$('select[id="mySelect"]').append(content);

				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script data-for="내친구정보가져오기">
		function fndInfo() {
			var selectedId = $("#mySelect option:selected").text();
			var split = selectedId.split("/");
			var fndId = parseInt(split[0]);
			
			/* ★★★★★ selectbox의 option이 공백일 경우 처리해야함*/
			
			var dataForm = {
				memberId : fndId
			};
			$.ajax({
				type : "POST",
				url : "/timetable/shareTimetable/selectFndinfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						console.info(item);
						$("#fndMemberId").val(item.memberId);
						$("#fndMemberName").val(item.memberName);
						$("#fndCollege").val(item.college_nm);
						$("#fndDepartment").val(item.department_nm);
						$("#fndMajor").val(item.major_nm);
					});
					
					fndtimetableInfo(fndId);
					
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}

			});

		}
	</script>
	
	<script data-for="시간표 가져오기">
		function fndtimetableInfo(fndId) {
			var dataForm = {
				memberId : fndId
			};
			
			/*테이블 refresh*/
			$('#frtimetable td').text("");
			$('#frtimetable td').css("background-color", "white");
			
			$.ajax({
				type : "POST",
				url : "/timetable/showTimetable/selectTimetableInfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
					$.each(response, function(index, item) {
						var info = "[" + item.courseName + "]" + "<br/>" + item.lecRoom;

						var str = item.lecTime + "/";
						var sstr = str.split('/');
						var kssr = sstr[0].split(',');

						$('td[id=fnd' + kssr[0] + ']').html(info);
						$('td[id=fnd' + kssr[1] + ']').html(info);
						$('td[id=fnd' + kssr[2] + ']').html(info);
						$('td[id=fnd' + kssr[3] + ']').html(info);

						shareTimetableColor();
					});
					
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>
	
	<script data-for="시간표 비교해 배경 색칠하기">
		function shareTimetableColor(){
			var myTimetable = $('#mytimetable');	// 나의 테이블 선택
			var fndTimetable = $('#fndTimetable');	// 친구 테이블 선택
			var rowLength = myTimetable.find('tr').length;		// 나의 테이블의 tr 을 rowLength로, -1 해주어야 함 (범주)
			var colLength = myTimetable.find('tr').eq(0).children('th').length; // 나의 테이블의 0번째 th를 불러옴, -1 해주어야 함 (범주)
			
			// tr개수 12개 중 1번부터 row count
			// td개수 6개 중 1번부터 col count
			
			// table refresh (내꺼랑 친구꺼 모두 refresh)
			$('#mytimetable td').css("background-color", "white");
			$('#fndTimetable td').css("background-color", "white");
			
			for(var i=0; i<rowLength-1; i++){
				for(var j=0; j<colLength-1; j++){
					var obj_m = myTimetable.find('tr').eq(i+1).children('td').eq(j);
					var obj_f = fndTimetable.find('tr').eq(i+1).children('td').eq(j);
					var html_m = obj_m.text(); 				// 나의 테이블 내 모든 text를 가져와 html_m에 대입
					var html_f = obj_f.text();				// 친구 테이블 내 모든 text를 가져와 html_f에 대입
					
					if(html_m == "" && html_f == ""){					// 나와 친구가 모두 공강 일 때
						obj_m.css('background-color','#F8E6E0');
						obj_f.css('background-color','#F8E6E0');
					}else if(html_m == html_f){							// 나의 수업과 친구의 수업이 같을 때
						obj_m.css('background-color','#819FF7');
						obj_f.css('background-color','#819FF7');
					}else if(html_m != "" || html_f != ""){				// 각자 다른 수업을 듣고 있을 때
						obj_m.css('background-color','#FFE08C');		// 내가 듣는 수업
						obj_f.css('background-color','#FFC19E');		// 친구가 듣는 수업
						
						if(html_m == ""){
							obj_m.css('background-color','#FFC19E');	// 친구가 듣는데 난 안들을 때
						}else if(html_f == ""){
							obj_f.css('background-color','#FFE08C');	// 친구가 안듣는데 내가 들을때
						}
					}else{						// 전혀 둘다 겹치지 않는 시간 ex) 내가 수업이o, 친구는 x 또는 내가 수업이x, 친구가 o
						
					}
					
				}
			}
			
		}
	
	</script>
	
	

</gachonTag:script>
<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<!-- 학생 정보 출력 -->
	<div>
		<div style="margin-left: 7%; width: 42%; float: left;">
			<form class="form-horizontal">
				<div class="page_title">내 시간표 조회</div>
				<hr />
				<br>
				<div class="form-group">
					<label for="memberName" class="col-sm-2 control-label">이름</label>
					<div class="col-sm-4">
						<input id="memberName" class="form-control input-sm" type="text" readonly />
					</div>

					<label for="memberId" class="col-sm-2 control-label">학번</label>
					<div class="col-sm-4">
						<input id="memberId" class="form-control input-sm" type="text" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="college" class="col-sm-2 control-label">소속대학</label>
					<div class="col-sm-4">
						<input id="college" class="form-control input-sm" type="text" readonly />
					</div>

					<label for="department" class="col-sm-2 control-label">단과대학</label>
					<div class="col-sm-4">
						<input id="department" class="form-control input-sm" type="text" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="major" class="col-sm-2 control-label">학과</label>
					<div class="col-sm-4">
						<input id="major" class="form-control input-sm" type="text" readonly />
					</div>
				</div>
			</form>

			<div class="component">
				<table id="mytimetable">
					<tr>
						<th></th>
						<th>월요일</th>
						<th>화요일</th>
						<th>수요일</th>
						<th>목요일</th>
						<th>금요일</th>

					</tr>

					<tr>
						<th>1교시(09:00-09:50)<br>A교시(09:00-10:15)</th>
						<td id="MO1"></td>
						<td id="TU1"></td>
						<td id="WE1"></td>
						<td id="TH1"></td>
						<td id="FR1"></td>

					</tr>

					<tr>
						<th>2교시(10:00-10:50)<br>B교시(10:30-11:45)</th>
						<td id="MO2"></td>
						<td id="TU2"></td>
						<td id="WE2"></td>
						<td id="TH2"></td>
						<td id="FR2"></td>

					</tr>

					<tr>
						<th>3교시(11:00-11:50)<br></th>
						<td id="MO3"></td>
						<td id="TU3"></td>
						<td id="WE3"></td>
						<td id="TH3"></td>
						<td id="FR3"></td>

					</tr>

					<tr>
						<th>4교시(12:00-12:50)<br>C교시(12:00-13:15)</th>
						<td id="MO4"></td>
						<td id="TU4"></td>
						<td id="WE4"></td>
						<td id="TH4"></td>
						<td id="FR4"></td>

					</tr>

					<tr>
						<th>5교시(13:00-13:50)<br></th>
						<td id="MO5"></td>
						<td id="TU5"></td>
						<td id="WE5"></td>
						<td id="TH5"></td>
						<td id="FR5"></td>
					</tr>

					<tr>
						<th>6교시(14:00-14:50)<br>D교시(13:30-14:45)</th>
						<td id="MO6"></td>
						<td id="TU6"></td>
						<td id="WE6"></td>
						<td id="TH6"></td>
						<td id="FR6"></td>
					</tr>

					<tr>
						<th>7교시(15:00-15:50)<br>E교시(15:30-16:45)</th>
						<td id="MO7"></td>
						<td id="TU7"></td>
						<td id="WE7"></td>
						<td id="TH7"></td>
						<td id="FR7"></td>

					</tr>

					<tr>
						<th>8교시(16:00-16:50)<br></th>
						<td id="MO8"></td>
						<td id="TU8"></td>
						<td id="WE8"></td>
						<td id="TH8"></td>
						<td id="FR8"></td>

					</tr>

					<tr>
						<th>9교시(17:30-18:20)<br></th>
						<td id="MO9"></td>
						<td id="TU9"></td>
						<td id="WE9"></td>
						<td id="TH9"></td>
						<td id="FR9"></td>

					</tr>

					<tr>
						<th>10교시(18:25-19:15)<br></th>
						<td id="MO10"></td>
						<td id="TU10"></td>
						<td id="WE10"></td>
						<td id="TH10"></td>
						<td id="FR10"></td>
					</tr>

					<tr>
						<th>11교시(19:20-20:10)<br></th>
						<td id="MO11"></td>
						<td id="TU11"></td>
						<td id="WE11"></td>
						<td id="TH11"></td>
						<td id="FR11"></td>
					</tr>
				</table>
			</div>
			<!-- end .mytimetable -->
		</div>

		<div id="frtimetable" style="margin-left: 3%; width: 42%; float: left;">
			<form class="form-horizontal">
				<div class="page_title">친구 시간표 조회</div>
				<hr />
				<br>
				<div class="form-group">
					<label for="fndName" class="col-sm-2 control-label">이름</label>
					<div class="col-sm-4">
						<!-- select 를 bootstrap으로 바꾸기 -->
						<select class="form-control input-sm" id="mySelect" onchange="fndInfo();">
							<option value="N">검색할 친구를 선택하세요</option>
						</select>
					</div>

					<label for="fndMemberId" class="col-sm-2 control-label">학번</label>
					<div class="col-sm-4">
						<input id="fndMemberId" class="form-control input-sm" type="text" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="fndCollege" class="col-sm-2 control-label">소속대학</label>
					<div class="col-sm-4">
						<input id="fndCollege" class="form-control input-sm" type="text" readonly />
					</div>

					<label for="fndDepartment" class="col-sm-2 control-label">단과대학</label>
					<div class="col-sm-4">
						<input id="fndDepartment" class="form-control input-sm" type="text" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="fndMajor" class="col-sm-2 control-label">학과</label>
					<div class="col-sm-4">
						<input id="fndMajor" class="form-control input-sm" type="text" readonly />
					</div>
				</div>
			</form>


			<div class="component">
				<table id="fndTimetable">
					<tr>
						<th></th>
						<th>월요일</th>
						<th>화요일</th>
						<th>수요일</th>
						<th>목요일</th>
						<th>금요일</th>

					</tr>

					<tr>
						<th>1교시(09:00-09:50)<br>A교시(09:00-10:15)</th>
						<td id="fndMO1"></td>
						<td id="fndTU1"></td>
						<td id="fndWE1"></td>
						<td id="fndTH1"></td>
						<td id="fndFR1"></td>

					</tr>

					<tr>
						<th>2교시(10:00-10:50)<br>B교시(10:30-11:45)</th>
						<td id="fndMO2"></td>
						<td id="fndTU2"></td>
						<td id="fndWE2"></td>
						<td id="fndTH2"></td>
						<td id="fndFR2"></td>

					</tr>

					<tr>
						<th>3교시(11:00-11:50)<br></th>
						<td id="fndMO3"></td>
						<td id="fndTU3"></td>
						<td id="fndWE3"></td>
						<td id="fndTH3"></td>
						<td id="fndFR3"></td>
					</tr>

					<tr>
						<th>4교시(12:00-12:50)<br>C교시(12:00-13:15)</th>
						<td id="fndMO4"></td>
						<td id="fndTU4"></td>
						<td id="fndWE4"></td>
						<td id="fndTH4"></td>
						<td id="fndFR4"></td>

					</tr>

					<tr>
						<th>5교시(13:00-13:50)<br></th>
						<td id="fndMO5"></td>
						<td id="fndTU5"></td>
						<td id="fndWE5"></td>
						<td id="fndTH5"></td>
						<td id="fndFR5"></td>
					</tr>

					<tr>
						<th>6교시(14:00-14:50)<br>D교시(13:30-14:45)</th>
						<td id="fndMO6"></td>
						<td id="fndTU6"></td>
						<td id="fndWE6"></td>
						<td id="fndTH6"></td>
						<td id="fndFR6"></td>

					</tr>

					<tr>
						<th>7교시(15:00-15:50)<br>E교시(15:30-16:45)</th>
						<td id="fndMO7"></td>
						<td id="fndTU7"></td>
						<td id="fndWE7"></td>
						<td id="fndTH7"></td>
						<td id="fndFR7"></td>

					</tr>

					<tr>
						<th>8교시(16:00-16:50)<br></th>
						<td id="fndMO8"></td>
						<td id="fndTU8"></td>
						<td id="fndWE8"></td>
						<td id="fndTH8"></td>
						<td id="fndFR8"></td>

					</tr>

					<tr>
						<th>9교시(17:30-18:20)<br></th>
						<td id="fndMO9"></td>
						<td id="fndTU9"></td>
						<td id="fndWE9"></td>
						<td id="fndTH9"></td>
						<td id="fndFR9"></td>

					</tr>

					<tr>
						<th>10교시(18:25-19:15)<br></th>
						<td id="fndMO10"></td>
						<td id="fndTU10"></td>
						<td id="fndWE10"></td>
						<td id="fndTH10"></td>
						<td id="fndFR10"></td>
					</tr>

					<tr>
						<th>11교시(19:20-20:10)<br></th>
						<td id="fndMO11"></td>
						<td id="fndTU11"></td>
						<td id="fndWE11"></td>
						<td id="fndTH11"></td>
						<td id="fndFR11"></td>
					</tr>
				</table>
			</div>
			<!-- end .frtimetable -->
		</div>
		<!-- end container -->
</body>
</gachonTag:html>