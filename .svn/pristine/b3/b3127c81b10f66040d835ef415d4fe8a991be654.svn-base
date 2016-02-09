package com.myspring.gachon.member.myinfo.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.member.myinfo.vo.MyInfoVO;
import com.myspring.gachon.content.ContentKey;

@Repository
public class MyInfoDaoImpl implements MyInfoDao {

	@Autowired
	private SqlSession sqlSession;
	// end must be point .
	private static final String NS = "mapper.com.myspring.gachon.member.myinfo.";

	@Override
	public List<MyInfoVO> selectMyInfo_MST(MyInfoVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NS + "selectMyInfo_MST", vo);
	}

	@Override
	public JSONObject updateMyInfo_MST(HttpSession session, MyInfoVO vo) {

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("RESULT_CODE", sqlSession.update(NS + "updateMyInfo_MST", vo));
		if (jsonObject.getInt("RESULT_CODE") > 0) {
			jsonObject.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		} else {
			jsonObject.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
		}
		return jsonObject;
	}
}
