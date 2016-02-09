
/*
$(document).ready(function(){
	//여기에다가  기술하셔야만 합니당.ㄴ
	checkForm("#id1",10,15,"number");
	checkForm("#id2",10,15,"number");
	checkForm("#id3",10,15,"number");
	checkForm("#id4",10,15,"number");
	checkForm("#id5",10,15,"number");
	checkForm("#id6",10,15,"number");
}


@param1 : jquery의 양식을 따릅니다.
@param2 : 인풋에 들어가있는 text의 최소길이 체크합니다.
@param3 : 인풋에 들어가있는 text의 최대길이를 체크합니다.
@param4 : number/text/noneKr/  이 두가지의 형식만 들어갑니다.
 */


function checkForm(selector,minSize,maxSize,textType){
	if(minSize<=maxSize){
		selector.attr("title","Notice!!");
		selector.attr("data-placement","top");
		selector.attr("data-toggle","popover");
		selector.attr("data-trigger","focus");
		selector.attr("data-content","입력형식:["+textType+"]" +
										"[최소길이:"+minSize+"/최대길이:"+maxSize+"]");
		selector.popover();
		selector.focusout(function(event){
			var temp=selector.val();
			if(textType=="number"){
			//textType이 number 일경우
				if(/^\d+$/.test(temp)){
					//숫자일경우
					if(minSize<=temp.length){
						if(maxSize>=temp.length){
							selector.removeClass("input_fail").addClass("input_success"); 
						}else{
							selector.removeClass("input_success").addClass("input_fail"); 
						}
					}else{
						selector.removeClass("input_success").addClass("input_fail"); 
					}
				}else{
					selector.removeClass("input_success").addClass("input_fail"); 
				}
			}else if(textType=="noneKr"){
			//영어와 숫자만 입력하겠다.
				if((/^[A-Za-z0-9+]*$/.test(temp))){
					if(minSize<=temp.length){
						if(maxSize>=temp.length){
							selector.removeClass("input_fail").addClass("input_success"); 
						}else{
							selector.removeClass("input_success").addClass("input_fail"); 
						}
					}else{
						selector.removeClass("input_success").addClass("input_fail"); 
					}
				}else{
					selector.removeClass("input_success").addClass("input_fail"); 
				}
			}else{
			//text 일경우
				if(minSize<=temp.length){
					if(maxSize>=temp.length){
						selector.removeClass("input_fail").addClass("input_success"); 
					}else{
						selector.removeClass("input_success").addClass("input_fail"); 

					}
				}else{
					selector.removeClass("input_success").addClass("input_fail"); 
				}
			}
		});
	}else{
	}
}
//input type=text 가 들어가있는 Block의 id나 class 를 입력하면  <input type='text'> 태그의 모든 값을 초기화 시킨다.
// 사용방법 : inputTextInit("#courseInfo");
// 파라메터로는 jquery로 태그 찾을때 사용하는 구문을 작성해주면 된다. 
// 그리고 그 구문은 input이나 select를 포함하고 있는 전체 텍스트를 포함하고 있어야한다.
function inputTextInit(parent){
	$(parent+" input").val("");
	$(parent+" textarea").val("");
	var elem = $(parent+" select option");
	for(var i=(elem.size()-1);i>=0;i--){
		elem[i].selected=true;
	}
	//참고 url : http://stackoverflow.com/questions/1280499/jquery-set-select-index
	//$(parent+" select option")[0].prop('selected', true);
	//$(parent+" select option")[0].selected = true;
	//$('#selectBox option')[3].checked = true;
	//$(parent+" select option:first").prop('selected', true);
	//$(parent+" select option")[0].selected = true;
}







