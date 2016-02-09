<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>
<gachonTag:html>
<gachonTag:script bootstrapTable="YES">

<script type="text/javascript">
	// 초기 로드 테이블
	$(document).ready(function() {
		selectMst(); // 맨처음에 selectMST를 불러온 다음에 insertMST 시, 성공시 selectMST를 다시 부르도록 따로 빼둠v
	});

	// show, hide modal
	function showModal(modalId){
		$('#'+modalId).modal('show');
	}
	function hideModal(modalId){
		$('#'+modalId).modal('hide');
	}
	
	// draw table (insert, update 구현 후에 다시 그려주는 파트)
	function drawDetTable(){
		selectDet($('#MST').bootstrapTable('getSelections')[0].grcode);
	}

	function modalType(type) {
		inputTextInit("#GroupCode_modal");
		inputTextInit("#GroupDetail_modal");

		if (type == "addMst") {
			$('#saveMaster').attr('href', 'javascript:insertMst();');
			$('h4[id="myModalLabel"]').html("그룹코드 추가");
			$("input[id=grcode]").attr("readonly", false);
			showModal('GroupCode_modal');

		} else if (type == "modifyMst") {
			// 특정 ajax 태우기
			$('#saveMaster').attr('href', 'javascript:updateMst();');

			// 타이틀 수정
			$('h4[id="myModalLabel"]').html("그룹코드 수정");

			// select된 row 데이터 받아오기
			document.getElementById("grcode").value = $('#MST').bootstrapTable('getSelections')[0].grcode;
			document.getElementById("grcodeName").value = $('#MST').bootstrapTable('getSelections')[0].grcodeName;

			// 변경하면 안되는 input box 막기
			$("input[id=grcode]").attr("readonly", true); // disabled도 동일

			showModal('GroupCode_modal');

		} else if (type == "addDet") {
			$('#saveDetail').attr('href', 'javascript:insertDet();');
			$('h4[id="myModalLabel"]').html("코드상세정보 추가");

			document.getElementById("grcode_det").value = $('#MST').bootstrapTable('getSelections')[0].grcode;
			$("input[id=grcode_det]").attr("readonly", true); // disabled도 동일
			$("input[id=code]").attr("readonly", false); // disabled도 동일
			showModal('GroupDetail_modal');

		} else if (type == "modifyDet") {
			$('#saveDetail').attr('href', 'javascript:updateDet();');
			$('h4[id="myModalLabel"]').html("코드상세정보 수정");

			document.getElementById("grcode_det").value = $('#MST').bootstrapTable('getSelections')[0].grcode;
			document.getElementById("code").value = $('#DET').bootstrapTable('getSelections')[0].code;
			document.getElementById("codeName").value = $('#DET').bootstrapTable('getSelections')[0].codeName;
			document.getElementById("sortSeq").value = $('#DET').bootstrapTable('getSelections')[0].sortSeq;

			$("input[id=grcode_det]").attr("readonly", true); // disabled도 동일
			$("input[id=code]").attr("readonly", true); // disabled도 동일

			// 			document.getElementById("useYn_select").value = row.useYn;
			showModal('GroupDetail_modal');
		}
	}
	/* MST 테이블 (상단) */

	function selectMst() {
		var dataForm = {};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeMST.json",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				$('#MST').bootstrapTable('load', response).on(
						'click-row.bs.table', function(e, row, $element) {
							selectDet(row.grcode); // det 호출(parameter로 row의 grcode를 넘김)
						});
				// 맨처음에는 DET 테이블이 빈 상태
				// MST의 row를 클릭시, 해당 row의 grcode에 해당하는 det 테이블을 뿌려주도록 해야 함
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	function insertMst() {
		var dataForm = {
			grcode : $('#grcode').val(),
			grcodeName : $('#grcodeName').val(),
			updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeMST.insert", // insert는 임의 지정
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				hideModal('GroupCode_modal');
				selectMst();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	function updateMst() {

		var dataForm = {
			grcode : $('#MST').bootstrapTable('getSelections')[0].grcode,
			grcodeName : $('#grcodeName').val(),
			updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeMST.update",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				hideModal('GroupCode_modal');
				selectMst();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	

	function deleteMst() {
		var dataForm = {
			grcode : $('#MST').bootstrapTable('getSelections')[0].grcode
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeMST.delete",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				selectMst();
				
				// MST를 지웠을깨 row : 1 success가 뜨지만,
				// MST를 지운 것은 아니므로 det db테이블은 row : 0 이 떨어져서 request_code가 0보다 크지않으므로 fail떨어짐.
				// 처리 방법 : daoimpl에서 det 부분의 requset_code를 >= 0 으로 수정
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	/* DET 테이블 (하단) */
	function selectDet(grcode) {

		var rowGrcode = grcode;

		var dataForm = {
			grcode : rowGrcode
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeDET.json",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				$('#DET').bootstrapTable('load', response);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
	
	// sortSeq는 필수로 입력받도록 not null을 No로 지정하는 것이 맞다.
	// 안넣어도 에러가 뜨지 않으려면 jdbcType을 db테이블의 type과 동일하게 맞춰줘야 null값이 떨어져도, 에러가 뜨지 않는다.
	
	function insertDet() {
		var dataForm = {
			grcode : $('#MST').bootstrapTable('getSelections')[0].grcode,
			code : $('#code').val(),
			codeName : $('#codeName').val(),
			sortSeq : $('#sortSeq').val(),
			useYn : $("#useYn_select option:selected").val(),
			updtUser : 'test'
		};

		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeDET.insert", // insert는 임의 지정
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				hideModal('GroupDetail_modal');

				drawDetTable();
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	function updateDet() {
		var dataForm = {
			grcode : $('#MST').bootstrapTable('getSelections')[0].grcode,
			code : $('#DET').bootstrapTable('getSelections')[0].code,
			codeName : $('#codeName').val(),
			sortSeq : $('#sortSeq').val(),
			useYn : $("#useYn_select option:selected").val(),
			updtUser : 'test'
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeDET.update",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				hideModal('GroupDetail_modal');
				selectDet($('#MST').bootstrapTable('getSelections')[0].grcode);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}

	function deleteDet() {

		var dataForm = {
			grcode : $('#MST').bootstrapTable('getSelections')[0].grcode,
			code : $('#DET').bootstrapTable('getSelections')[0].code,
		};
		$.ajax({
			type : "POST",
			url : "/admin/manage_code/grcodeDET.delete",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {
			},
			success : function(response) {
				GachonNoty.showResultNoty(response.RESULT_CODE, response.RESULT_MSG);
				selectDet($('#MST').bootstrapTable('getSelections')[0].grcode);
			},
			error : function(request, status, errorThrown) {
				GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
			}
		});
	}
</script>
</gachonTag:script>

<body>
	<GachonTag:nav-bar name="${LOGIN_MEMBER.memberName}" type="${LOGIN_MEMBER.memberType}"/>

	<!-- MST PART  -->
	
	<div class="container">
		<div class="table-responsive">
			<div class="page_title">그룹코드 마스터 정보</div>
			<hr />

			<table id="MST" data-toggle="table" data-url="#"
				data-show-columns="false" data-search="false"
				data-show-refresh="false" data-show-toggle="false"
				data-show-export="true" data-pagination="true" data-height="400"
				data-click-to-select="true" data-select-item-name="radioName">
				<thead>
					<tr>
						<th data-field="state" data-radio="true"></th>
						<th data-field="grcode">그룹코드</th>
						<th data-field="grcodeName">그룹코드명</th>
						<th data-field="updtdt">작업일시</th>
						<th data-field="updtUser">작업자</th>
					</tr>
				</thead>
			</table>

			<!-- 그룹코드 마스터 정보에 해당하는 버튼 3 -->
			<div style="margin-top: 1%; margin-bottom: 3%;">
				<!-- Button trigger modal 1 -->
				<input type="button" class="btn btn-info" data-toggle="modal"
					onclick="modalType('addMst');" value="추가">
				</input>


<!-- 				onclick="showModal('GroupCode_modal');" -->
				<!-- Button trigger modal 2 -->
				<input type="button" class="btn btn-info" data-toggle="modal"
					onclick="modalType('modifyMst');" value="수정">
				</input>

				<!-- Button trigger modal 3 -->
				<a id="get-selections" class="btn btn-info" href="javascript:deleteMst();">삭제</a>
			</div>
			
			<!-- Modal.1-1 : 그룹마스터정보 추가하기 -->
			<!-- modal.1-2 : 그룹마스터정보 수정하기 -->
			<div class="modal fade" id="GroupCode_modal" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">title</h4>
						</div>
						<div class="modal-body">
							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">그룹코드
									<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-9">
									<input id="grcode" class="form-control input-sm"
										placeholder="GroupCode" type="text">
								</div>
							</div>

							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">그룹코드명
									<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-9">
									<input id="grcodeName" class="form-control input-sm"
										placeholder="GroupCodeName" type="text">
								</div>
							</div>
						</div>
						<div class="modal-footer" style="text-align: center;">
							<a href="#" id="saveMaster" class="btn btn-success">저장</a>
							<a href="#" class="btn btn-warning" data-dismiss="modal">닫기</a>
						</div>
					</div>
				</div>
			</div>
			
			<!-- DET PART  -->
			
			<div class="page_title">그룹코드 상세정보</div>
			<hr />
			<table id="DET" data-toggle="table" data-url="#"
				data-show-columns="false" data-search="true"
				data-show-refresh="false" data-show-toggle="false"
				data-show-export="true" data-pagination="true" 
				data-page-size="25" data-page-list="[25, 50, 100]"
				data-height="600" data-click-to-select="true" data-select-item-name="radioName">
				<thead>
					<tr>
						<th data-field="state" data-radio="true"></th>
						<th data-field="code">코드</th>
						<th data-field="codeName">코드명</th>
						<th data-field="sortSeq">정렬순서</th>
						<th data-field="useYn">사용여부</th>
						<th data-field="updtdt">작업일시</th>
						<th data-field="updtUser">작업자</th>
					</tr>
				</thead>
			</table>

			<!-- 그룹코드 상세정보에 해당하는 버튼 3 -->
			<div style="margin-top: 1%; margin-bottom: 3%;">
				<!-- Button trigger modal 1 -->
				<input type="button" class="btn btn-info" data-toggle="modal"
					onclick="modalType('addDet');" value="추가">
				</input>

				<!-- Button trigger modal 2 -->
				<input type="button" class="btn btn-info" data-toggle="modal"
					onclick="modalType('modifyDet');" value="수정">
				</input>

				<!-- Button trigger modal 3 -->
				<a id="get-selections" class="btn btn-info" href="javascript:deleteDet();">삭제</a>
			</div>

			<!-- Modal.2-1 : 그룹코드 상세 추가하기 -->
			<!-- Modal.2-2 : 그룹코드 상세 수정하기 -->
			<div class="modal fade" id="GroupDetail_modal" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">title</h4>
						</div>
						<div class="modal-body">
							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">그룹코드
									<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-9">
									<input id="grcode_det" class="form-control input-sm"
										placeholder="GroupCode" type="text" disabled>
								</div>
							</div>
							
							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">코드
									<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-9">
									<input id="code" class="form-control input-sm" placeholder="Code"
										type="text">
								</div>
							</div>

							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">코드명
									<div class="glyphicon glyphicon-ok"></div>
								</label>
								<div class="col-sm-9">
									<input id="codeName" class="glyphicon glyphicon-star form-control input-sm"
										placeholder="CodeName" type="text">
								</div>
							</div>

							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">정렬순서</label>
								<div class="col-sm-9">
									<input id="sortSeq" class="glyphicon glyphicon-star form-control input-sm"
										placeholder="Sort" type="text">
								</div>
							</div>

							<div class="row form-group">
								<label for="Category" class="col-sm-3 control-label"
									style="margin-top: 1%; text-align: right;">사용여부
									<div class="glyphicon glyphicon-ok"></div>
								</label>
<!-- 								onChange="javascript:selectValue(this)" -->
								<div class="col-sm-9">
									<select id="useYn_select" name="select" class="form-control" 
										style="height: 5%; font-size: 11px;">
										<option value="Y" selected>예</option>
										<option value="N">아니오</option>
									</select>
								</div>
							</div>
						</div>
						<div class="modal-footer" style="text-align: center;">
							<a href="#" id="saveDetail" class="btn btn-success">저장</a> 
							<a href="#" class="btn btn-warning" data-dismiss="modal">닫기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</gachonTag:html>
