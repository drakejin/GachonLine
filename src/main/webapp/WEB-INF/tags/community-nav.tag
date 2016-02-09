<%@ tag language="java" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%@ attribute name="divs" %>



<div id="community-nav" class="page_title">
	<c:choose>
		<c:when test="${divs eq 'gachon'}">
			가천대 게시판
		</c:when>
		<c:when test="${divs eq 'A'}">
			단대별 게시판_사회 과학 대학
		</c:when>
		<c:when test="${divs eq 'B'}">
			단대별 게시판_경영 대학
		</c:when>
		<c:when test="${divs eq 'C'}">
			단대별 게시판_인문 대학
		</c:when>
		<c:when test="${divs eq 'D'}">
			단대별 게시판_법과 대학
		</c:when>
		<c:when test="${divs eq 'E'}">
			단대별 게시판_건축 대학
		</c:when>
		<c:when test="${divs eq 'F'}">
			단대별 게시판_공과 대학
		</c:when>
		<c:when test="${divs eq 'G'}">
			단대별 게시판_바이오나노 대학
		</c:when>
		<c:when test="${divs eq 'H'}">
			단대별 게시판_IT대학
		</c:when>
		<c:when test="${divs eq 'I'}">
			단대별 게시판_한의과 대학
		</c:when>
		<c:when test="${divs eq 'J'}">
			단대별 게시판_예술 대학
		</c:when>
		<c:when test="${divs eq 'K'}">
			단대별 게시판_글로벌 교양 대학
		</c:when>
				
		<c:when test="${divs eq '1'}">
			학년별 게시판_1 학년
		</c:when>
		<c:when test="${divs eq '2'}">
			학년별 게시판_2 학년
		</c:when>
		<c:when test="${divs eq '3'}">
			학년별 게시판_3 학년
		</c:when>
		<c:when test="${divs eq '4'}">
			학년별 게시판_4 학년
		</c:when>
		<c:when test="${divs eq '5'}">
			학년별 게시판_5 학년
		</c:when>

		<c:when test="${divs eq 'study_club'}">
			동아리 게시판_학술 분과
		</c:when>
		<c:when test="${divs eq 'music_club'}">
			동아리 게시판_음악 분과
		</c:when>
		<c:when test="${divs eq 'religion_club'}">
			동아리 게시판_종교 분과
		</c:when>
		<c:when test="${divs eq 'physical_club'}">
			동아리 게시판_체육 분과
		</c:when>
		<c:when test="${divs eq 'performance_club'}">
			동아리 게시판_공연 행사 분과
		</c:when>
		<c:when test="${divs eq 'socialScience_club'}">
			동아리 게시판_사회 과학 분과
		</c:when>
		<c:when test="${divs eq 'create_club'}">
			동아리 게시판_전시 창작 분과
		</c:when>
		<c:when test="${divs eq 'hobby_club'}">
			동아리 게시판_취미 봉사 분과
		</c:when>
		
		<c:when test="${divs eq 'noname'}">
			익명 게시판
		</c:when>

		<c:when test="${divs eq 'sell'}">
			가천장터_판매
		</c:when>
		<c:when test="${divs eq 'buy'}">
			가천장터_구매
		</c:when>

		<c:when test="${divs eq 'thunder'}">
			번개 모임
		</c:when>
		
		<c:when test="${divs eq 'sinmungo'}">
			신 문 고
		</c:when>
		
		<c:when test="${divs eq 'group_buy'}">
			공동 구매
		</c:when>
		
		<c:otherwise>
			에러
		</c:otherwise>
	</c:choose>
</div>
<hr/>


<c:choose>
	<c:when test="${divs eq 'sell'||divs eq 'buy' || divs eq 'group_buy' }">
		<ul class="nav nav-tabs">
			<li class="dropdown <c:if test="${divs eq 'sell' || divs eq 'buy'}">active</c:if>"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">가천 장터
				<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li ><a href="/community?divs=sell">팝니다</a></li>
					<li ><a href="/community?divs=buy">삽니다</a></li>
				</ul>
			</li>
			<li role="presentation" class="<c:if test="${divs eq 'group_buy'}">active</c:if>">
				<a href="/community?divs=group_buy">공동 구매</a>
			</li>
		</ul>
	</c:when>
	
	<c:otherwise>
		<ul class="nav nav-tabs">
			<li role="presentation" class="<c:if test="${divs eq 'gachon'}">active</c:if>">
				<a href="/community?divs=gachon">가천대 게시판</a>
			</li>
			
			<li class="dropdown <c:if test="${divs eq 'A' || divs eq 'B' || divs eq 'C' || divs eq 'D' || divs eq 'E' || divs eq 'F' || divs eq 'G' || divs eq 'H' || divs eq 'I' || divs eq 'J' ||divs eq 'K'}">active</c:if>">
				<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false">단대별  게시판
						<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li ><a href="/community?divs=A">사회 과학 대학</a></li>
					<li ><a href="/community?divs=B">경영 대학</a></li>
					<li ><a href="/community?divs=C">인문 대학</a></li>
					<li ><a href="/community?divs=D">법과 대학</a></li>
					<li ><a href="/community?divs=E">건축 대학</a></li>
					<li ><a href="/community?divs=F">공과 대학</a></li>
					<li ><a href="/community?divs=G">바이오나노 대학</a></li>
					<li ><a href="/community?divs=H">IT 대학</a></li>
					<li ><a href="/community?divs=I">한의과 대학</a></li>
					<li ><a href="/community?divs=J">예술 대학</a></li>
					<li ><a href="/community?divs=K">글로벌 교양 대학</a></li>
				</ul>
			</li>
			<li class="dropdown <c:if test="${divs eq '1' || divs eq '2' || divs eq '3' ||	divs eq '4' || divs eq '5'}">active</c:if>">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
				role="button" aria-expanded="false">학년별 게시판
						<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li ><a href="/community?divs=1">1 학년</a></li>
					<li ><a href="/community?divs=2">2 학년</a></li>
					<li ><a href="/community?divs=3">3 학년</a></li>
					<li ><a href="/community?divs=4">4 학년</a></li>
					<li ><a href="/community?divs=5">5 학년</a></li>
				</ul>
			</li>
			
			<li class="dropdown <c:if test="${divs eq 'study_club' ||divs eq 'music_club'||divs eq 'religion_club' || divs eq 'physical_club' || divs eq 'performance_club' ||divs eq 'socialScience_club' || divs eq 'create_club' || divs eq 'hobby_club' }">active</c:if>">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" 
				role="button" aria-expanded="false">동아리 게시판
						<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li ><a href="/community?divs=study_club">학술 분과</a></li>
					<li ><a href="/community?divs=music_club">음악 분과</a></li>
					<li ><a href="/community?divs=religion_club">종교 분과</a></li>
					<li ><a href="/community?divs=physical_club">체육 분과</a></li>
					<li ><a href="/community?divs=performance_club">공연 행사 분과</a></li>
					<li ><a href="/community?divs=socialScience_club">사회 과학 분과</a></li>
					<li ><a href="/community?divs=create_club">전시 창작 분과</a></li>
					<li ><a href="/community?divs=hobby_club">취미 봉사 분과</a></li>
				</ul>
			</li>
			<li role="presentation" class="<c:if test="${divs eq 'noname'}">active</c:if>">
				<a href="/community?divs=noname">익명 게시판</a>
			</li>
			<li role="presentation" class="<c:if test="${divs eq 'thunder'}">active</c:if>">
				<a href="/community?divs=thunder">번개 모임</a>
			</li>
			<li role="presentation" class="<c:if test="${divs eq 'sinmungo'}">active</c:if>">
				<a href="/community?divs=sinmungo">신 문 고</a>
			</li>
		</ul>
	</c:otherwise>
</c:choose>

