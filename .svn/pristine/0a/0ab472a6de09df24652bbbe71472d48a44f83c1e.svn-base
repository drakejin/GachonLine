package com.myspring.gachon.tags.navbar.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.tags.navbar.vo.TagsNavbarVO;

@Repository
public class TagsNavbarDAOImpl implements TagsNavbarDAO{
	@Autowired
	private SqlSession sqlSession;
	private static final String NS = "mapper.com.myspring.gachon.tags.navbar.";
	@Override
	public JSONArray getMenu(TagsNavbarVO vo, HttpServletRequest request) {
		// TODO Auto-generated method stub
		JSONArray ary = new JSONArray();
		JSONObject obj = new JSONObject();
		HttpSession session = request.getSession();
		Object data = session.getAttribute(ContentKey.LOGIN_MEMBER);
		
		if(data != null){
		
			JSONObject temp = JSONObject.fromObject(data);
			if(temp.get("memberType").equals("STD")){
				obj.put("power", "STD");
			}else if(temp.get("memberType").equals("PRO")){
				obj.put("power", "PRO");
			}else if(temp.get("memberType").equals("ETC")){
				obj.put("power", "ETC");
			}else if(temp.get("memberType").equals("ADM")){
				obj.put("power", "ADM");
			}else{
				obj.put("power", "ALL");
			}
		}
		
		return JSONArray.fromObject(sqlSession.selectList(NS+"getMenu",obj));
	}

}
