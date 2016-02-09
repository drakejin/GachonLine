<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@include file="/resources/include/include.jsp"%>

<!DOCTYPE html>
<mytag:html>
<mytag:script jqGrid="${KEY_YES }" magnific_popup="${KEY_YES }"></mytag:script>
<script>
<!-- 데이터 리스트 로드 -->
$(document).ready(function() {
	var delDialog_gridList = {
			recreateForm: true,
			reloadAfterSubmit:true,
			width:"500",modal:true,
			closeAfterDel:true,
			beforeShowForm: function(form) {
				MY_JQGRID.drawDialogToBootstrapStyle(form);
				jQuery("#gridList").setGridParam({ editurl: "${DOMAIN_NAME}/course/change_course/change_course.do" });
			},
			onclickSubmit: function (params) {
				var ajaxData = {};
				
				var data = $("#gridList").getRowData($("#gridList").getGridParam('selrow'));
				
				ajaxData = {
					${ACTION_ID}:"${ACTION_DELETE}"
					,board_no: data.BOARD_NO
				};
				return ajaxData;
			},
		 	afterComplete: function (response) {
				var json = $.parseJSON(response.responseText);
				var code = json.RESULT_CODE;
				var resultMsg = json.RESULT_MSG;
				MY_NOTY.common_result_noty(code, resultMsg);
				
				searchList();
		   	}
	};
	
	jQuery("#gridList").jqGrid({
		datatype: "local",
		width:$('#container').width(),
	   	colNames:['게시글번호','글 제목', '내어줄 과목','원하는 과목','종료여부','거래자', '조회수','작업 일시','작업자','','','',''],
	   	colModel:[
	  	   		{name:'BOARD_NO',index:'BOARD_NO', fixed:true, width:100, align:'center'},
		   		{name:'TITLE',index:'TITLE', fixed:true, width:350},
		   		{name:'COURSE_FROM_NM',index:'COURSE_FROM_NM', fixed:true, width:300},
		   		{name:'COURSE_TO_NM',index:'COURSE_TO_NM', fixed:true, width:300},
		   		{name:'FINISHED',index:'FINISHED', fixed:true, width:80,  align:"center", formatter: "select", formoptions: {elmprefix : "<span class='glyphicon glyphicon-star'></span>"}
		   			,stype: "select", searchoptions: {value: MY_JQGRID.getJqgridSelectboxForSearchBar($('#USE_YN> option'))}
	   				,edittype: "select", editoptions: {value: MY_JQGRID.getJqgridSelectboxForDialogWindow($('#USE_YN> option'))}},
		   		{name:'TO_USER_NM',index:'TO_USER_NM', fixed:true, width:130},
		   		{name:'VIEW_COUNT',index:'VIEW_COUNT', fixed:true, width:80, align:'right'},
		   		{name:'UPDTDT',index:'UPDTDT', fixed:true, width:150, align:"center"},
		   		{name:'UPDT_USER_NM',index:'UPDT_USER_NM', fixed:true, width:130}
		   		,{name:'COURSE_FROM',index:'COURSE_FROM', hidden:true}
		   		,{name:'COURSE_TO',index:'COURSE_TO', hidden:true}
		   		,{name:'TO_USER',index:'TO_USER', hidden:true}
		   		,{name:'UPDT_USER',index:'UPDT_USER', hidden:true}
		],
		rowNum:100,
	   	rowList:[100,200,300],
	   	pager: "#gridListToolbar",
	   	sortname: 'menu_id',
	    sortorder: "desc",
	    viewrecords: true,
	    shrinkToFit: false,
	    caption:"수강신청 교환하기",
	    ondblClickRow: function(rowid, iRow, iCol, e){
	    	var data = $("#gridList").getRowData(rowid);
	    	
	    	if(data.FINISHED == 'Y'){
	    		MY_NOTY.show_custom_noty('이미 종료된 교환입니다.', 'warning');
	    		return;
	    	}
	    	
	    	var dataForm = {
	    			${ACTION_ID} : "${ACTION_GET_SELECT_3}"
	    		};
	    		$.ajax({
	    			type : "POST",
	    			url : "${DOMAIN_NAME}/course/change_course/change_course.do",
	    			cache : false,
	    			async : false,
	    			data : dataForm,
	    			dataType : "json",
	    			complete : function() {

	    			},
	    			success : function(response) {
	    				arr_course_from = new Array();
	    				arr_course_to = new Array();
	    				
	    				var html_course_from = "";
	    				var html_course_to = "";
	    				for(var i=0 in response){
	    					html_course_from += "<option value='"+response[i].COURSE_NUM+"'>"+response[i].COURSE_NAME+"</option> ";
	    					
	    					var str_course_from = "";
	    					str_course_from += "학수번호: " + response[i].COURSE_NUM + "<br />";
	    					str_course_from += "과목명: " + response[i].COURSE_NAME + "<br />";
	    					str_course_from += "담당교수: " + response[i].PROFESSOR + "<br />";
	    					str_course_from += "학점: " + response[i].GRADE + "<br />";
	    					str_course_from += "강의시간: " + response[i].LEC_TIME + "<br />";
	    					str_course_from += "강의실: " + response[i].LEC_ROOM + "<br />";
	    					str_course_from += "사이버여부: " + response[i].CYBER_YN + "<br />";
	    					str_course_from += "수강가능인원: " + response[i].CAPACITY + "<br />";
	    					arr_course_from.push(str_course_from);
	    					
	    					
	    					
	    					html_course_to += "<option value='"+response[i].COURSE_NUM+"'>"+response[i].COURSE_NAME+"</option> ";
    						
    						var str_course_to = "";
    						str_course_to += "학수번호: " + response[i].COURSE_NUM + "<br />";
    						str_course_to += "과목명: " + response[i].COURSE_NAME + "<br />";
    						str_course_to += "담당교수: " + response[i].PROFESSOR + "<br />";
    						str_course_to += "학점: " + response[i].GRADE + "<br />";
    						str_course_to += "강의시간: " + response[i].LEC_TIME + "<br />";
    						str_course_to += "강의실: " + response[i].LEC_ROOM + "<br />";
    						str_course_to += "사이버여부: " + response[i].CYBER_YN + "<br />";
    						str_course_to += "수강가능인원: " + response[i].CAPACITY + "<br />";
    						arr_course_to.push(str_course_to);
	    					
	    				}
	    				$('#course_from').html(html_course_from).select2();
	    				$('#course_to').html(html_course_to).select2();
	    			},
	    			error : function(request, status, errorThrown) {
	    				MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
	    			}
	    		});
	    		
	    	$('#btn_finish').show();
	    	$('#btn_save').hide();

	    	$('#title').val(data.TITLE).attr('readonly','readonly');
	    	$('#course_from').val(data.COURSE_FROM).attr('disabled','disabled').select2().trigger('change');
	    	$('#course_to').val(data.COURSE_TO).attr('disabled','disabled').select2().trigger('change');
	    	$('.popup-with-form').magnificPopup('open');
	    }
	});
	jQuery("#gridList").jqGrid("filterToolbar",{stringResult: true, searchOnEnter : false, defaultSearch : "cn"});
	jQuery("#gridList").jqGrid("navGrid", "#gridListToolbar",{edit: false, add: false, del: true, view: false, search: false, refresh: false},
			null, null, delDialog_gridList, {}, {});	
	MY_JQGRID.getGridHeight([$('#gridList')]);
});
</script>
<script>

var arr_course_from;
var arr_course_to;
function searchList(){
	var dataForm = {
		${ACTION_ID} : "${ACTION_GET_LIST}"
	};
	$.ajax({
		type : "POST",
		url : "${DOMAIN_NAME}/course/change_course/change_course.do",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "json",
		complete : function() {

		},
		success : function(response) {
			MY_JQGRID.drawLocalGridList_Pager(response, $('#gridList'));
		},
		error : function(request, status, errorThrown) {
			MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
		}
	});
}
function showWindow(){
	var dataForm = {
			${ACTION_ID} : "${ACTION_GET_SELECT}"
			,member_id: '${LOGIN_MEMBER.member_id}'
		};
		$.ajax({
			type : "POST",
			url : "${DOMAIN_NAME}/course/change_course/change_course.do",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				arr_course_from = new Array();
				
				var html_course_from = "";
				for(var i=0 in response){
					html_course_from += "<option value='"+response[i].COURSE_NUM+"'>"+response[i].COURSE_NAME+"</option> ";
					
					var str_course_from = "";
					str_course_from += "학수번호: " + response[i].COURSE_NUM + "<br />";
					str_course_from += "과목명: " + response[i].COURSE_NAME + "<br />";
					str_course_from += "담당교수: " + response[i].PROFESSOR + "<br />";
					str_course_from += "학점: " + response[i].GRADE + "<br />";
					str_course_from += "강의시간: " + response[i].LEC_TIME + "<br />";
					str_course_from += "강의실: " + response[i].LEC_ROOM + "<br />";
					str_course_from += "사이버여부: " + response[i].CYBER_YN + "<br />";
					str_course_from += "수강가능인원: " + response[i].CAPACITY + "<br />";
					arr_course_from.push(str_course_from);
				}
				$('#course_from').html(html_course_from);
				$('#course_from').select2().trigger('change');
			},
			error : function(request, status, errorThrown) {
				MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
			}
		});
		var dataForm = {
			${ACTION_ID} : "${ACTION_GET_SELECT_2}"
			,member_id: '${LOGIN_MEMBER.member_id}'
		};
		$.ajax({
			type : "POST",
			url : "${DOMAIN_NAME}/course/change_course/change_course.do",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				arr_course_to = new Array();
				
				var html_course_to = "";
				for(var i=0 in response){
					html_course_to += "<option value='"+response[i].COURSE_NUM+"'>"+response[i].COURSE_NAME+"</option> ";
					
					var str_course_to = "";
					str_course_to += "학수번호: " + response[i].COURSE_NUM + "<br />";
					str_course_to += "과목명: " + response[i].COURSE_NAME + "<br />";
					str_course_to += "담당교수: " + response[i].PROFESSOR + "<br />";
					str_course_to += "학점: " + response[i].GRADE + "<br />";
					str_course_to += "강의시간: " + response[i].LEC_TIME + "<br />";
					str_course_to += "강의실: " + response[i].LEC_ROOM + "<br />";
					str_course_to += "사이버여부: " + response[i].CYBER_YN + "<br />";
					str_course_to += "수강가능인원: " + response[i].CAPACITY + "<br />";
					arr_course_to.push(str_course_to);
				}
				$('#course_to').html(html_course_to);
				$('#course_to').select2().trigger('change');
			},
			error : function(request, status, errorThrown) {
				MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
			}
		});
		
	$('#btn_finish').hide();
	$('#btn_save').show();
	
	$('#title').val('').removeAttr('readonly');
	$('#course_from').val('').removeAttr('disabled').select2();
	$('#course_to').val('').removeAttr('disabled').select2();
	
	$('#panel_course_from_title').html('');
	$('#panel_course_from_body').html('');
	$('#panel_course_to_title').html('');
	$('#panel_course_to_body').html('');
	
	$('.popup-with-form').magnificPopup('open');//글수정 열기	
}

function save(){
	var dataForm = {
			${ACTION_ID} : "${ACTION_INSERT}"
			,title: $('#title').val()
			,course_from: $('#course_from').val()
			,course_to: $('#course_to').val()
		};
		$.ajax({
			type : "POST",
			url : "${DOMAIN_NAME}/course/change_course/change_course.do",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				var code = response.RESULT_CODE;
				var resultMsg = response.RESULT_MSG;
				MY_NOTY.common_result_noty(code, resultMsg);
				
				if(code >= 0){
					$('.popup-with-form').magnificPopup('close');
				}
				
				searchList();
			},
			error : function(request, status, errorThrown) {
				MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
			}
		});
}
function finish(){
	var data = $("#gridList").getRowData($("#gridList").getGridParam('selrow'));
	console.info(data);
	
	var dataForm = {
			${ACTION_ID} : "${ACTION_UPDATE}"
			,course_from: $('#course_from').val()
			,course_to: $('#course_to').val()
			,updt_user: data.UPDT_USER
			,board_no: data.BOARD_NO
			
		};
		$.ajax({
			type : "POST",
			url : "${DOMAIN_NAME}/course/change_course/change_course.do",
			cache : false,
			async : true,
			data : dataForm,
			dataType : "json",
			complete : function() {

			},
			success : function(response) {
				var code = response.RESULT_CODE;
				var resultMsg = response.RESULT_MSG;
				MY_NOTY.common_result_noty(code, resultMsg);
				
				if(code >= 0){
					$('.popup-with-form').magnificPopup('close');
				}
				
				searchList();
			},
			error : function(request, status, errorThrown) {
				MY_NOTY.common_ajax_error_noty(request, status, errorThrown);
			}
		});
}
</script>
<body>
	<form:select id="USE_YN" path="USE_YN" items="${USE_YN}" style="display:none;" />
	<mytag:menu></mytag:menu>
	<div class="container" id="container">
		<table id="gridList"></table>
		<div id="gridListToolbar"></div>

		<div class="blank10"></div>

		<button type="button" class="btn btn-primary pull-right" onclick="javascript: showWindow(); return false;">글쓰기</button>
	</div>

	<!-- 글작성하기 -->
	<a class="popup-with-form" href="#write-form_main"></a>
	<form id="write-form_main" class="white-popup-block mfp-hide form-horizontal container panel panel-default" style="clear: both; padding-bottom: 20px;">
		<input type="hidden" id="board_no" />
		<fieldset style="padding=20px; margin-top:60px;">
			<div class="form-group" style="position:relative;right:48px;">
				<label for="title" class="col-md-2 control-label">제목</label>
				<div class="col-md-10">
					<input class="form-control" id="title" type="text" maxlength="100">
				</div>
			</div>
			<div class="form-group" style="position:relative;right:48px;">
				<label for="course_from" class="col-md-2 control-label">내어줄 과목</label>
				<div class="col-md-4">
					<select id="course_from" class="form-control"></select>
				</div>
				<label for="course_to" class="col-md-2 control-label">원하는 과목</label>
				<div class="col-md-4">
					<select id="course_to" class="form-control"></select>
				</div>
			</div>
			<div class="form-group" style="position:relative;right:48px;">
				<label for="course_from" class="col-md-2 control-label">상세</label>
				<div class="col-md-4">
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3 id="panel_course_from_title" class="panel-title"></h3>
						</div>
						<div id="panel_course_from_body" class="panel-body"></div>
					</div>
				</div>
				<label for="course_to" class="col-md-2 control-label">상세</label>
				<div class="col-md-4">
					<div class="panel panel-warning">
						<div class="panel-heading">
							<h3 id="panel_course_to_title" class="panel-title"></h3>
						</div>
						<div id="panel_course_to_body" class="panel-body"></div>
					</div>
				</div>
			</div>
			<div class="form-group" style="text-align: center;">
				<button type="button" class="btn btn-default blank20" onclick="javascript: $('.popup-with-form').magnificPopup('close'); return false;">목록</button>
				<button type="button" id="btn_save" class="btn btn-primary blank20" onclick="javascript: save();">작성하기</button>
				<button type="button" id="btn_finish" class="btn btn-primary blank20" onclick="javascript: finish();">교환하기</button>
			</div>
		</fieldset>
	</form>
</body>
<script>
$(document).ready(function() {
	$('.popup-with-form').magnificPopup({
		type: 'inline',
		preloader: false,

		// When elemened is focused, some mobile browsers in some cases zoom in
		// It looks not nice, so we disable it:
		callbacks: {
			beforeOpen: function() {
			}
		}
	});
});
	$(window).load(function() {
		searchList();
		
		$('#course_from').change(function(){
			var index = $("#course_from option").index($("#course_from option:selected"));
			var text = $("#course_from option:selected").text();
			$('#panel_course_from_title').html(text);
			$('#panel_course_from_body').html(arr_course_from[index]);
		})
		$('#course_to').change(function(){
			var index = $("#course_to option").index($("#course_to option:selected"));
			var text = $("#course_to option:selected").text();
			$('#panel_course_to_title').html(text);
			$('#panel_course_to_body').html(arr_course_to[index]);
		})
	});
</script>
</mytag:html>