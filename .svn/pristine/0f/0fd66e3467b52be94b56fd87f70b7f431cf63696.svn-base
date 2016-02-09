package com.myspring.gachon.admin.menu.dao;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.myspring.gachon.admin.member.dao.AdminMemberDAO;
import com.myspring.gachon.admin.member.vo.AdminMemberVO;
import com.myspring.gachon.admin.menu.vo.AdminMenuVO;
import com.myspring.gachon.content.ContentKey;

@Repository
public class AdminMenuDAOImpl implements AdminMenuDAO{
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	PlatformTransactionManager transactionManager;
	private static final String NS = "mapper.com.myspring.gachon.admin.menu.";
	@Override
	public List<AdminMenuVO> getMenuList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + "getMenuList");
	}
	@Override
	public JSONObject setMenuSubmit(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		JSONObject data = new JSONObject();
		try{
			if(sqlSession.insert(NS+"setMenuSubmit",vo)!=1){
				data.put(ContentKey.RESULT_MSG,ContentKey.JDBC_CONNECTION_ERROR);
			}else{
				data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_SUCCESS);
			}
		}catch(Exception e){
			e.printStackTrace();
			data.put(ContentKey.RESULT_MSG,ContentKey.JDBC_CONNECTION_ERROR);
			return data;
		}
		return data;
	}
	
	
	@Override
	public JSONObject getMenuShow(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		JSONObject data = JSONObject.fromObject(sqlSession.selectOne(NS+"getMenuShow",vo));
		if(!data.isNullObject()&&data.get("menuId").equals(vo.getMenuId())){
			data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_SUCCESS);
		}else{
			data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_FAIL);
		}
		return data;
	}
	@Override
	public JSONObject setMenuModify(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		JSONObject data = new JSONObject();
		if(sqlSession.insert(NS+"setMenuModify",vo)!=1){
			data.put(ContentKey.RESULT_MSG,ContentKey.JDBC_CONNECTION_ERROR);
		}else{
			data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_SUCCESS);
		}
		return data;
	}
	
	@Override
	public int setMenuDelete(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert(NS+"setMenuDelete",vo);
	}
	@Override
	public int getMenuChildCount(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		System.out.println(sqlSession.selectOne(NS + "getMenuChildCount",vo));
		return sqlSession.selectOne(NS + "getMenuChildCount",vo);
	}
	@Override
	public int setMenuAllDelete(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.delete(NS+"setMenuAllDelete",vo);
	}
	@Override
	public JSONArray getParentMenuId() {
		// TODO Auto-generated method stub
		return JSONArray.fromObject(sqlSession.selectList(NS+"getParentMenuId"));
	}


}
