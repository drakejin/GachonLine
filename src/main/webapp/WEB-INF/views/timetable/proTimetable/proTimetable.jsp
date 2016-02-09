<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">


<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/component.css"/ >
<link rel="stylesheet" href="${PATH_PLUGIN }/whatIsThis/myform.css"/ >
<script src="${PATH_PLUGIN }/whatIsThis/jquery.stickyheader.js"></script>


<style>

tbody > tr > th{
	background : #E7E7E7;
/* 	#E7E7E7; */
	color : black;
}

table{
	border: 1px solid #bbb;
	outline : none;
} 

.nameTag{
	border: 2px solid #bbb;
	outline : none;
}

.formGroupMargin{
	margin: 5% 0 0 1%;
}

.formGroupMarginBottom{
	margin: 5% 0 9% 1%;
}
</style>

<script>
	$('#myModal').on('shown.bs.modal', function() {
		$('#myInput').focus()
	});
</script>

<script>

//초기 로드 테이블
$(document).ready(function() {
	inputTextInit("#initData");
	inputTextInit("#initData1");
});



<!-- 학부전공 필터링 Ajax -->
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
	
	
	function profInfo(){		
		
		var dataForm = {
			college : $("#college_s option:selected").val(),
			memberName : $("#prof_name").val(),
			major : $("#major_s option:selected").val()
		};
		$.ajax({
			type : "POST",
			url : "/member/my_info/myInfo.select",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				if(response == ''){
					alert("해당 소속 교수님이 없습니다.");
				}else{
					var transName = response[0].memberName + '  교수';
					var content;
					
					// form insert data
					document.getElementById("profNameTag").value = transName;
					document.getElementById("college_p").value = response[0].college_nm;
					document.getElementById("department_p").value = response[0].department_nm;
					document.getElementById("major_p").value = response[0].major_nm;
					document.getElementById("addr_p").value = response[0].address;
					document.getElementById("phone_p").value = response[0].phone;
					document.getElementById("email_p").value = response[0].email;
					
					content = "<img src="+ "/" + response[0].profileImgPath+" style='width: 240px; height: 325px;'/>";
				
					$('.profPic').html(content);
					timetableInfo();
				}
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	
	// 시간표 가져오기
	function timetableInfo() {
		var dataForm = {
			memberName : $("#prof_name").val(),
			major : $("#major_s option:selected").val()
		};

		var color = [ "#FFA7A7", "#FFC19E", "#FFE08C", "#CEF279", "#B7F0B1", "#D1B2FF", "#FFB2F5", "#B2EBF4"];
		$.ajax({
			type : "POST",
			url : "/timetable/pro_timetable/selectTimetableInfo",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "JSON",
			success : function(response) {
				
				// table refresh
				$('table td').text("");
				$('table td').css("background-color", "white");
				
				// timetable draw
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

</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="noname" id="noname" />

	<!-- 교수님 선택 -->
	<div class="container">
		<div class="page_title">교수님 시간표 보기</div>
		<hr />
		<br>
		<form class="form-horizontal">
			<fieldset>
				<div class="form-group" style="margin: 0;">
					<div class="row">
						<div class="col-md-2">
							<label>소속 캠퍼스</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>

						<div class="col-md-3">
							<label>단과대학</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-4">
							<label>전공</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
						<div class="col-md-2">
							<label>교수명</label>
							<div class="glyphicon glyphicon-ok"></div>
						</div>
					</div>

				</div>

				<div class="form-group" style="margin: 0%">
					<div class="row">
						<div id="initData">
							<!-- 1. 소속캠퍼스 -->
							<div class="col-md-2">
								<!-- 셀렉트박스 쓰는법... -->
								<gachonTag:select code="${COLLEGE }" id="college_s"
									required="required" />
								<!-- initLabel="전체" 를 넣어주면, 전체 항목 생성. initLabel은 SelectTag.java 참고 -->
							</div>

							<!-- 2. 단과대학 -->
							<div class="col-md-3">
								<gachonTag:select code="${DEPARTMENT }" id="department_s"
									onChange="majorFilter();" initLabel="전체" />
							</div>

							<!-- 3. 전공 -->
							<div class="col-md-4">
								<gachonTag:select code="${MAJOR }" id="major_s" initLabel="전체" />
							</div>

							<!-- 4. 교수명 -->
							<div class="col-md-2">
								<input type="text" class="form-control" id="prof_name"
									placeholder="교수명을 입력하세요">
							</div>
						</div>
						<!-- 5. 검색 버튼 -->
						<div class="col-md-1">
							<input type="button" class="btn btn-info" onclick="profInfo();" value="검색">
							</input>
						</div>
					</div>
				</div>
			</fieldset>
		</form>

		<div class="nameTag" style="margin-top:3.5em; float: left; width: 28%; height: 70%;">
			<div>
				<div>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div id="initData1" style="height: 44%;">
					<div class="profPic" style='border:solid 1px gray; width: 240px; height: 325px; float: left; margin:5% 0 5% 12.5%;'> </div>
					<div style="float:left; margin-left:25%;">
<!-- 						<h2>황보택근 교수</h2> -->
						<input class="form-control input-sm" id="profNameTag" type="text" style="text-align: center;" readonly />
					</div>
					
					<form class="form-horizontal myform1" id="form-wrapper" style="float: left; margin-left: 3%; margin-bottom: 0px;">
						<div class="form-group formGroupMargin">
							<label for="Birth" class="col-md-4 control-label">소속대학</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="college_p" type="text" readonly />
							</div>
						</div>

						<div class="form-group formGroupMargin">
							<label for="Birth" class="col-md-4 control-label">단과대학</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="department_p" type="text" readonly />
							</div>
						</div>
						
						<div class="form-group formGroupMargin">
							<label for="Birth" class="col-md-4 control-label">학과</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="major_p" type="text" readonly />
							</div>
						</div>
						
						<div class="form-group formGroupMargin">
							<label for="Birth" class="col-md-4 control-label">사무실</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="addr_p" type="text" readonly />
							</div>
						</div>
						
						<div class="form-group formGroupMargin">
							<label for="Birth" class="col-md-4 control-label">연락처</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="phone_p" type="text" readonly />
							</div>
						</div>
						
						<div class="form-group formGroupMarginBottom">
							<label for="Birth" class="col-md-4 control-label">이메일</label>
							<div class="col-md-8">
								<input class="form-control input-sm" id="email_p" type="text" readonly />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div style="padding: 3.5em 0 3em; float: right; width: 70%; height: 70%;">
			<table id="timeTable">
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