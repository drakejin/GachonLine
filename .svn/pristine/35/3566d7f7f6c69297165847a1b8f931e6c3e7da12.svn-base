function selectTag(items,id,isNull){
	var dataForm={
		grcode:items
	};
	$.ajax({
		type : "POST",
		url : "/tags/select.json",
		cache : false,
		async : true,
		data : dataForm,
		dataType : "JSON",
		success : function(response) {
			$("#"+id).empty();
			var afterParentMenuId = document.getElementById(id);
			if(isNull=='F'){
				var tempOption = document.createElement("option");	
				tempOption.text="선택해주세요";
				tempOption.value="";
				tempOption.selected=true;
				afterParentMenuId.add(tempOption);
			}
			for(var i=0;i<response.length;i++){
				if(isNull=='T'&&i==0){
					var tempOption = document.createElement("option");	
					tempOption.text=response[i].codeName;
					tempOption.value=response[i].code;	
					tempOption.selected=true;
					afterParentMenuId.add(tempOption);
				}else{
					var tempOption = document.createElement("option");	
					tempOption.text=response[i].codeName;
					tempOption.value=response[i].code;	
					afterParentMenuId.add(tempOption);
				}
			}
		},
		error : function(request, status, errorThrown) {
			GachonNoty.showAjaxErrorNoty(request, status, errorThrown);
		}
	});
}

/*
selectTag 사용법 .
1, 코드 관리에 들어가서 그룹 코드를 추가한다.
2, 그룹코드에 자식의 코드가 셀렉트 박스의 옵션값이 된다.
3, 무튼 자식 코드들도 추가한다.
4, 	<gachonTag:select id="menuType" code="MENU_TYPE" isNull="F" onChange="menuTypeTag(this.value);"/>
@param1[필수]:   id를 작성하면 name 과 이름이 같이 선언된다.
@param2[필수]:   code는 그룹코드[grcode 의 이름을 쓰면 된다.]
@param3    :   isNull은 넣고자 하는 DB칼럼에 null을 허용하지 않는다면 isNull="F"를 작성해주면 된다. 기본값으로는 T가 들어가 있다.
@param4    :   onChange="" onChange 에 대한 이벤트 자바스크립트를 기술해주면 된다. 
@param5    :   className="" 기본적으로는 form-control 이 들어가 있는데 만약 추가적으로 뭔가 더 넣고싶으면 여기다가 넣으시면 됩니다.				
@param6    :   disabled 만들고자 하는 select 태그의 초기값이 disabled 인지 아닌지를 설정할 수 있다 기본값은 F 로 되어있다 사용하려거든 disabled="T"를 하면된다.

5, 마지막으로  <gachonTag:script bootstrapTable="YES" select="YES"> 
에다가 select="YES"를 작성해준다. 
 */

