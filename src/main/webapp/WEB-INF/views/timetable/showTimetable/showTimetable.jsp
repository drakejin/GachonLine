<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html title="시간표보기">
<gachonTag:script>
	<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/component.css"/ >
	<script src="${PATH_PLUGIN }/whatIsThis/jquery.stickyheader.js"></script>

<style>
hr {
	border: 1px solid gray;
	margin: 0 0 2% 0;
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
	<script data-for="시간표 가져오기">
		function timetableInfo() {
			var dataForm = {
				memberId : "${LOGIN_MEMBER.memberId}"
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

					$.each(response, function(index, item) {
						var info = "[" + item.courseName + "]" + "<br/>" + item.lecRoom;

						var str = item.lecTime + "/";
						var sstr = str.split('/');
						var kssr = sstr[0].split(',');

						$('td[id=' + kssr[0] + ']').html(info);
						$('td[id=' + kssr[1] + ']').html(info);
						$('td[id=' + kssr[2] + ']').html(info);
						$('td[id=' + kssr[3] + ']').html(info);

						var lec = "";
						var stn = "";
						var lecSplit = "";
						for (var i = 0; i < response.length; i++) {
							lec = response[i].lecTime;
							if (i != 0) {
								lec = response[i].lecTime;
								stn += "," + lec;
							} else {
								lec = response[i].lecTime;
								stn += lec;
							}

						}
						
						lecSplit = stn.split(',');
						for (var j = 0; j < lecSplit.length; j++) {
							for (var k = 0; k < lecSplit.length; k++) {
								if ($('td[id=' + lecSplit[j] + ']').text() == $('td[id=' + lecSplit[k] + ']').text()) {
									$('td[id=' + lecSplit[k] + ']').css("background-color", color[j / 4]);
								}
							}
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
				memberId : "${LOGIN_MEMBER.memberId}"
			};
			$.ajax({
				type : "POST",
				url : "/timetable/showTitmetable/selectMyinfo",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "JSON",
				success : function(response) {
				
					// .each() 함수를 사용한 방식
					$.each(response, function(index, item) {
// 						console.log(item);
						if(item.memberId == "${LOGIN_MEMBER.memberId}"){
							console.log(item.memberId);
	 						$("#memberName").val(item.memberName);
	 						$("#memberId").val(item.memberId);
	 						$("#college_nm").val(item.college_nm);
	 						$("#department_nm").val(item.department_nm);
	 						$("#major_nm").val(item.major_nm);
						}

					})
					
					// (기존 방식) 각각의 Element Id에 response의 내용을 대입하는 방식 
// 					document.getElementById("memberName").value = response[0].memberName;
// 					document.getElementById("memberId").value = response[0].memberId;
// 					document.getElementById("college_nm").value = response[0].college_nm;
// 					document.getElementById("department_nm").value = response[0].department_nm;
// 					document.getElementById("major_nm").value = response[0].major_nm;
					
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
		myInfo();
		timetableInfo();
	</script>
</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<!-- 학생 정보 출력 -->
	<div class="container">
		<div class="page_title">내 시간표 조회</div>
		<hr/>
		<br>
		<form class="form-horizontal">
			<div class="form-group">
				<label for="memberName" class="col-sm-2 control-label" style="margin-left: 3%;">이름</label>
				<div class="col-sm-3">
					<input id="memberName" class="form-control input-sm" type="text" readonly />
				</div>

				<label for="memberId" class="col-sm-2 control-label">학번</label>
				<div class="col-sm-3">
					<input id="memberId" class="form-control input-sm" type="text" readonly />
				</div>
			</div>

			<div class="form-group">
				<label for="college" class="col-sm-2 control-label" style="margin-left: 3%;">소속대학</label>
				<div class="col-sm-3">
					<input id="college_nm" class="form-control input-sm" type="text" readonly />
				</div>

				<label for="department" class="col-sm-2 control-label">단과대학</label>
				<div class="col-sm-3">
					<input id="department_nm" class="form-control input-sm" type="text" readonly />
				</div>
			</div>

			<div class="form-group">
				<label for="major" class="col-sm-2 control-label" style="margin-left: 3%;">학과</label>
				<div class="col-sm-3">
					<input id="major_nm" class="form-control input-sm" type="text" readonly />
				</div>
			</div>
		</form>

		<div class="component">
			<table class="MST">
				<tr>
					<th></th>
					<th>월요일</th>
					<!-- MO -->
					<th>화요일</th>
					<!-- TU -->
					<th>수요일</th>
					<!-- WE -->
					<th>목요일</th>
					<!-- TH -->
					<th>금요일</th>
					<!-- FR -->
				</tr>

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
			</table>
		</div>
	</div>
</body>
</gachonTag:html>