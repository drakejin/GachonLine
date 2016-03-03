<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">


	<script type="text/javascript">
		//초기 로드 테이블
		$(document).ready(function() {
			selectMst();
			$("b").css("background", "yellow");
			$("table.mTable tr:eq(0)").css("background", "lightblue");
			$( "select" ).addClass( "input-sm" );
		});
		

		function selectMst() {
			var dataForm = {
				major : '${LOGIN_MEMBER.major}',
				year : '${LOGIN_MEMBER.year}',
				completeDivision : '${LOGIN_MEMBER.completeDivision}'
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_curriculum/curriculumMST.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#MST').bootstrapTable('load', response);

					var data = $('#MST').bootstrapTable('getData');

					for (var i = 0; i < data.length; i++) {
						if (data[i].schoolYear == "1") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "2") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						} else if (data[i].schoolYear == "3") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "4") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						}
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function selectYearMst(s_year) {
			var schoolYear = s_year;

			var dataForm = {
				major : "${LOGIN_MEMBER.major}",
				year : "${LOGIN_MEMBER.year}",
				schoolYear : schoolYear
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_curriculum/curriculumMST.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#MST').bootstrapTable('load', response);
					
					var data = $('#MST').bootstrapTable('getData');

					for (var i = 0; i < data.length; i++) {
						if (data[i].schoolYear == "1") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "2") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						} else if (data[i].schoolYear == "3") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "4") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						}
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function otherCurriMst(year) {
			var selectYear = year;

			var dataForm = {
				major : $("#otherMajor option:selected").val(),
				year : selectYear
			};
			$.ajax({
				type : "POST",
				url : "/admin/manage_curriculum/curriculumMST.json",
				cache : false,
				async : true,
				data : dataForm,
				dataType : "json",
				complete : function() {
				},
				success : function(response) {
					$('#MST').bootstrapTable('load', response);
					
					var data = $('#MST').bootstrapTable('getData');

					for (var i = 0; i < data.length; i++) {
						if (data[i].schoolYear == "1") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "2") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						} else if (data[i].schoolYear == "3") {
							$("table.mTable tbody tr").eq(i).css("background", "#FCFCFC");
						} else if (data[i].schoolYear == "4") {
							$("table.mTable tbody tr").eq(i).css("background", "#F6F6F6");
						}
					}
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}

		function majorFilter() {

			var dataForm = {
				grcode : 'MAJOR',			
				code : $("#otherDepartment option:selected").val()
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
					$('#otherMajor').html('');	// 기존 Label값 지워주고
					
					$.each(response, function(index, code) {	// index, code -> value, label
						$('#otherMajor').append('<option value='+code.value + '>' + code.label + '</option>');
					});
				},
				error : function(request, status, errorThrown) {
					GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
				}
			});
		}
	</script>

	<script type="text/javascript">
		function yearType(type) {
			if (type == "All") {
				inputTextInit("#MST");
				selectYearMst();
			} else if (type == "schoolYear1") {
				inputTextInit("#MST");
				selectYearMst("1");
			} else if (type == "schoolYear2") {
				inputTextInit("#MST");
				selectYearMst("2");
			} else if (type == "schoolYear3") {
				inputTextInit("#MST");
				selectYearMst("3");
			} else if (type == "schoolYear4") {
				inputTextInit("#MST");
				selectYearMst("4");
			}
		}
	</script>

	<script type="text/javascript">
		function otherYearFilter() {
			var selectYear = document.getElementById('otherYear').value;

			if (selectYear != "") {
				otherCurriMst(selectYear);
			} else {			
				otherCurriMst();
			}
		}
	</script>

	<script type="text/javascript">
		// issue!! 신입들이 자주 하는 실수... document 객체가 생성되기 이전에, hide와 show하라고 시킨 꼴!! 
		// 객체를 생성하고 나서 해주자!! 시점 조심!!!
		$(document).ready(function() {
			inputTextInit("#other_curri");
			$("#hide").click(function() {
				$("#MST").empty();
				$("#other_curri").hide();
			});

			$("#show").click(function() {
				$("#MST").empty();
				$("#other_curri").show();
			});
		});
	</script>

</gachonTag:script>

<body>
	<%@ taglib tagdir="/WEB-INF/tags/" prefix="GachonTag"%>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<div class="container">
		<form class="form-horizontal">
			<fieldset>
				<div class="page_title">교과과정</div>
				<hr />

				<p>
					교과과정표 상의 학년 표기는 <b>1학년은 당 해 학년도</b>이고, <b>2-3-4학년은 각 1년전의 학년도</b>
					입니다
				</p>
				<p>(예, 1학년 : 2013학년도, 2학년: 2012학년도, 3학년: 2011학년도, 4학년: 2010학년도)</p>

				<br />

				<!-- 상단 내커리큘럼 / 타과커리큘럼 바 -->
				<ul class="nav nav-tabs">
					<li class="dropdown active">
						<!-- <li class="dropdown active"> --> <a aria-expanded="false"
						class="dropdown-toggle" data-toggle="dropdown" id="hide">내
							커리큘럼 <span class="caret"></span>
					</a>

						<ul class="dropdown-menu">
							<li class="active"><a aria-expanded="true"
								onclick="yearType('All');" href="#" data-toggle="tab">전체 학년</a></li>
							<li class="divider"></li>

							<li><a href="#" data-toggle="tab"
								onclick="yearType('schoolYear1');">1학년</a></li>
							<li class="divider"></li>

							<li><a href="#" data-toggle="tab"
								onclick="yearType('schoolYear2');">2학년</a></li>
							<li class="divider"></li>

							<li><a href="#" data-toggle="tab"
								onclick="yearType('schoolYear3');">3학년</a></li>
							<li class="divider"></li>

							<li><a href="#" data-toggle="tab"
								onclick="yearType('schoolYear4');">4학년</a></li>
						</ul>
					</li>

					<li><a aria-expanded="false" href="#other_curri"
						data-toggle="tab" id="show">타과 커리큘럼</a></li>
				</ul>

				<!-- 타과 커리큘럼 선택 시, action -->
				<div id="myTabContent" class="tab-content">
					<!-- 타 학과 커리큘럼 선택시, -->
					<div class="tab-pane fade" id="other_curri">
						<div class="form-group" style="margin-top:1%;">
							<label class="col-md-2">학부/학과</label>
							<div class="col-md-2">
								<gachonTag:select code="${DEPARTMENT }"
									onChange="majorFilter();" id="otherDepartment"
									required="required" />
							</div>

							<label class="col-md-2">전공/학과</label>
							<div class="col-md-3">
								<gachonTag:select code="${MAJOR }" onChange="otherCurriMst();"
									id="otherMajor" required="required" />
							</div>

							<label class="col-md-1">입학년도</label>
							<div class="col-md-2">
								<gachonTag:select code="${YEAR }" onChange="otherYearFilter();"
									id="otherYear" initLabel="전체" />
							</div>
						</div>
					</div>
				</div>

				<table class="mTable" id="MST" data-toggle="table"
					data-show-columns="true" data-search="true"
					data-show-refresh="false" data-show-toggle="false"
					data-show-export="true" data-pagination="true" data-height="500">
					<thead>
						<tr>
							<th data-field="year">입학년도</th>
							<th data-field="courseNum">학수번호</th>
							<th data-field="courseName">교과목명</th>
							<th data-field="schoolYear" id="yearColor">학년</th>
							<th data-field="semester">학기</th>
							<th data-field="completeDivision_nm">이수구분</th>
							<th data-field="grade">학점</th>
						</tr>
					</thead>
				</table>
			</fieldset>
		</form>
	</div>
</body>
</gachonTag:html>

