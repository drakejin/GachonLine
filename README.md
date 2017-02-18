# GachonLine

  기존에 없던 가천대학교 사설 커뮤니티를 만들어 보자 하면서 시작된 프로젝트

# 운영 주소

 [가천라인 바로가기](http://likemilk.fun25.co.kr:15405)

# 실행 화면

 ![시간표 조회](https://github.com/drake-jin/GachonLine/raw/master/docs/%EC%8B%9C%EA%B0%84%ED%91%9C%20%EC%A1%B0%ED%9A%8C.JPG)
 ![메인 화면](https://github.com/drake-jin/GachonLine/raw/master/docs/UI_%EB%A9%94%EC%9D%B8%ED%99%94%EB%A9%B4.JPG)

# 프로젝트 특징
 1. 커스텀 태그를 활용한 UI 구성
 2. 공통 코드를 이용하여 웹페이지 구축
 3. 데이터베이스를 제어하는 시스템 관리자 페이지 존재 

# 주요 코드
 
  1. tags.SelectTag.java 

    - 호출 코드
``` html
  <gachonTag:select id="phone2_1" code="${TEL}" className="attr_name" required="required" />
``` 
    - 수행 코드
``` java
	@Override
	public int doStartTag() throws JspException {
		try {
			JspWriter out = pageContext.getOut();
			sb = new StringBuffer();

			sb.append("<select ");
			if (!this.id.isEmpty()) {
				sb.append("id='" + this.id + "' name='" + this.id + "' ");
			}
			if (!this.className.isEmpty()) {
				sb.append("class='form-control " + this.className + "'");
			} else {
				sb.append("class='form-control'");
			}
			if (!this.onChange.isEmpty()) {
				sb.append("onChange='" + this.onChange + "' ");
			}
			sb.append(">");

			if (!this.required.equals("required")) {
				sb.append("<option value='");
				if (!this.initValue.isEmpty()) {
					sb.append(this.initValue);
				}
				sb.append("'>");
				if (!this.initLabel.isEmpty()) {
					sb.append(this.initLabel);
				}

				sb.append("</option>");
			}
			
			if (!this.code.isEmpty()) {
				JSONArray jsonArray = JSONArray.fromObject(this.code);
				for (int i = 0; i < jsonArray.size(); i++) {
					sb.append("<option value='" + jsonArray.getJSONObject(i).getString("value") + "'");
					if (!this.selected.isEmpty() && this.selected.equals(jsonArray.getJSONObject(i).getString("value"))) {
						sb.append(" selected");
					}
					sb.append(">" + jsonArray.getJSONObject(i).getString("label") + "</option>");
				}
			}
			
			appendln("</select>");
			appendln("");

			out.print(sb.toString());

		} catch (IOException ioe) {
			throw new JspException("Error: " + ioe.getMessage());
		}
		return EVAL_BODY_INCLUDE;
	}
```

# 기술 스택
 - Repo. : SVN (naver....)
 - OS : Linux CentOS 7
 - DB : Oracle
 - WebClient : Bootstrap, jquery
 - WAS : Tomcat7
 - Framework : Spring3.x, Mybatis, logback
 - Tools : Toad for Oracle

# 산출 문서

 - [기능명세 및 업무 분담표](https://github.com/drake-jin/GachonLine/raw/master/docs/%EA%B0%80%EC%B2%9C%EB%9D%BC%EC%9D%B8_%EA%B8%B0%EB%8A%A5.xlsx)
 - [가천라인 제안 및 설계](https://github.com/drake-jin/GachonLine/raw/master/docs/gachonline.pdf)
 - [코드리스트.pdf](https://github.com/drake-jin/GachonLine/raw/master/docs/%EC%BD%94%EB%93%9C%20%EB%A6%AC%EC%8A%A4%ED%8A%B8.pdf)

# 참여자
 - 08 김동준[멘토]
 - 10 김태수[팀장]
 - 11 조용진[팀원]
 - 10 김지연[팀원]


