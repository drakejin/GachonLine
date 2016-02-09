function navBarTag(){
	$.ajax({
		type : "POST",
		url : "/tags/navbar.json",
		cache : false,
		async : true,
		dataType : "JSON",
		success : function(response) {
			setNavBarTag(response);
		},
	});
}

function setNavBarTag(items){
//	console.log(items);
	var navBarTag = document.getElementById("navBarTag");
	

	//<li class="dropdown">
	//<a href="#" class="dropdown-toggle"
	//data-toggle="dropdown" role="button" aria-expanded="false">
	//	학생서비스
	//<span class="caret"></span></a>
	//<ul class="dropdown-menu" role="menu">
//		<li><a href="/member/my_info">내 정보보기</a></li>
//		<li><a href="/member/friend_find">친구 찾기</a></li>
//		<li><a href="/course/course">수강조회</a></li>
//		<li><a href="/course/curriculum">커리큘럼보기</a></li>
//		<li><a href="/course/change_course">수업교환하기</a></li>
//		<li><a href="/timetable/show_timetable">나의 시간표 보기</a></li>
//		<li><a href="/timetable/share_timetable">친구와 공유</a></li>
//		<li><a href="/timetable/pro_timetable">교수님 시간표</a></li>
	//</ul>
	//</li>
	//
	
	var depth = 0;
	var parentMenuId=[];
	var group = [];
	var child = [];
	
	var count=0;
	
	for(var i=0;i<items.length;i++){
		var tempParentMenuId = "";
		for(var j=0;j<items.length;j++){
			if(items[i].parentMenuId!=items[j].parentMenuId){
				tempParentMenuId=items[j].parentMenuId;
//				console.log(count++);
				break;
			}
		}
		if(parentMenuId.length==0){
			parentMenuId.push(tempParentMenuId);
		}else{
			for(var k=0;k<parentMenuId.length;k++){
				if(parentMenuId[k]!=tempParentMenuId){
					parentMenuId.push(tempParentMenuId);
				}
			}
		}
		//depth 출력 완료
		if(depth<items[i].level){
			depth=items[i].level;
		}
	}
	
	for(var l=0;l<parentMenuId.length;l++){
//		console.log(parentMenuId[l]+"\t 입니다.");
	}
//	console.log("");
	
	
//	if(temp.level==2){
//		var li = document.createElement("li");
//		var ul = document.createElement("ul");
//		var a = document.createElement("a");
//		var span = document.createElement("span");
//		var parentLi = li;
//		var parentA = a;
//		var parentSpan = span;
//		parentLi.className="dropdown";
//		
//		parentA.className="dropdown-toggle";
//		parentA.setAttribute("data-toggle","dropdown");
//		parentA.setAttribute("role","button");
//		parentA.setAttribute("aria-expanded","false");
//		parentSpan.className="caret";
//		console.log(items[i]);
//		parentA.innerHTML=items[i].menuName;
//		parentA.appendChild(parentSpan);
//		parentLi.appendChild(parentA);
//		navBarTag.appendChild(parentLi);
//	}else if(temp.level==3){
//		
//	}
}













/*
 
 




function menuTypeTag(index){
	console.log(index);
	switch(index){
	case 'P':
		var beforeParentMenuId = document.getElementById('parentMenuId');
		
		var afterParentMenuId = document.createElement('select');
		afterParentMenuId.id='parentMenuId';
		afterParentMenuId.className='form-control';
		afterParentMenuId.readOnly = false;
		for(var i=0;i<parents.length;i++){
			var tempOption = document.createElement("option");	
			tempOption.text=parents[i];
			afterParentMenuId.add(tempOption);
		}
		if(document.getElementById('menuId').hasAttribute("onChange")){
			console.log("onChange빼버림!");
			document.getElementById('menuId').attributes.removeNamedItem("onChange");// onChange이벤트 삭제
		}

		
		beforeParentMenuId .innerHTML = afterParentMenuId.innerHTML;  //내용을 변경해준다.
		beforeParentMenuId.parentNode.insertBefore(afterParentMenuId, beforeParentMenuId); //바꿔준다.
		beforeParentMenuId.parentNode.removeChild(beforeParentMenuId); //삭제
		break;
		
	default:
		
		if(!document.getElementById('menuId').hasAttribute("onChange")){
			console.log("onChange넣음!");
			document.getElementById('menuId').setAttribute("onChange", "menuIdTag(this.value);");
		}
		var beforeParentMenuId = document.getElementById('parentMenuId');
		var afterParentMenuId = document.createElement('input');
		afterParentMenuId.id='parentMenuId';
		afterParentMenuId.className='form-control';
		afterParentMenuId.type='text';
		afterParentMenuId.readOnly = true;

		document.getElementById('menuId').onChange='menuIdTag(this.value);';
		beforeParentMenuId .innerHTML = afterParentMenuId.innerHTML;  //내용을 변경해준다.
		beforeParentMenuId.parentNode.insertBefore(afterParentMenuId, beforeParentMenuId); //바꿔준다.
		beforeParentMenuId.parentNode.removeChild(beforeParentMenuId); //삭제
		menuIdTag(document.getElementById('menuId').value);
		
		break;
	}
}
function menuIdTag(value){
	document.getElementById('parentMenuId').value=value;
}








 */

//<!--  조용진  -->
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">커뮤니티<span
//	class="caret"></span></a>
//<ul class="dropdown-menu" role="menu">
//	<li><a href="/community?divs=gachon">가천대 게시판</a></li>
//	<li><a href="/community?divs=it">단대별 게시판</a></li>
//	<li><a href="/community?divs=1">학년별 게시판</a></li>
//	<li><a href="/community?divs=music_club">동아리 게시판</a></li>
//	<li><a href="/community?divs=noname">익명게시판</a></li>
//	<!-- 우뮴뮤뮤뮤뮤뮤 -->
//	<li><a href="/community?divs=sell">가천 장터</a></li>
//	<li><a href="/community?divs=thunder">번개모임</a></li>
//	<li><a href="/community?divs=sinmungo">신문고</a></li>
//	<li><a href="/community?divs=group_buy">공동구매</a></li>
//</ul>
//</li>
//
//<!-- 지연누나 -->
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">외부
//	커뮤니티<span class="caret"></span>
//</a>
//<ul class="dropdown-menu" role="menu">
//	<li><a href="/outCommunity/store">상점 보기</a></li>
//	<li><a href="/outCommunity/alba">알바 공고</a></li>
//	<li><a href="/outCommunity/event">이벤트 정보</a></li>
//</ul>
//</li>
//
//
//<!-- 관리자  -->
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">관리자<span
//	class="caret"></span></a>
//<ul class="dropdown-menu" role="menu">
//	<li><a href="/admin/manage_member">회원관리</a></li>
//	<li><a href="/admin/manage_code">코드관리</a></li>
//	<li><a href="/admin/manage_menu">메뉴관리</a></li>
//	<li><a href="/admin/manage_store">상점관리</a></li>
//	<li><a href="/admin/manage_curriculum">커리큘럼관리</a></li>
//	<li><a href="/admin/manage_course">수강관리</a></li>
//</ul>
//</li>
//
//
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">기타<span
//	class="caret"></span></a>
//<ul class="dropdown-menu" role="menu">
//	<li><a href="/common/show_all">서비스 한눈에 보기</a></li>
//</ul>
//</li>
//
//<!-- 자유롭게 만져도 되는부분 -->
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">개발자
//	샘플<span class="caret"></span>
//</a>
//<ul class="dropdown-menu" role="menu">
//	<li><a href="#">조용진 샘플 ㅋ </a></li>
//	<li><a href="#">태수형 샘플 ㅋ </a></li>
//	<li><a href="#">지연누나 샘플 ㅋ </a></li>
//	<li><a href="#">동준이형 샘플 ㅋ </a></li>
//
//</ul>
//</li>
//
//<!-- 자유롭게 만져도 되는부분 -->
//<li class="dropdown"><a href="#" class="dropdown-toggle"
//data-toggle="dropdown" role="button" aria-expanded="false">참고사이트<span
//	class="caret"></span></a>
//<ul class="dropdown-menu" role="menu">
//	<li><a
//		href="http://www.w3schools.com/bootstrap/bootstrap_ref_css_tables.asp">W3schools.com</a></li>
//	<li><a href="http://getbootstrap.com/components/#navbar">bootstrap.com</a></li>
//	<li><a href="http://www.codecademy.com/">www.codeacademy.com</a></li>
//
//</ul>
//</li>
//</ul>
//<ul class="nav navbar-nav navbar-right">
//<li><a href="#"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
//${name}님 </a></li>
//<li><a href="/logout"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
//로그아웃 </a></li>
//</ul>
//</div>
//</div>
//</nav>
//
//
//<li><a href="/common/show_all">
//서비스 한눈에 보기</a>
//
//</li>	