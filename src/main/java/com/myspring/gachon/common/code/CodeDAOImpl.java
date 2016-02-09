package com.myspring.gachon.common.code;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CodeDAOImpl implements CodeDAO {
	@Autowired
	private SqlSession sqlSession;
	private static final String NS = "mapper." + CodeDAOImpl.class.getPackage().getName() + ".";

	@Override
	public List<CodeVO> selectCodeDet(String grcode) {
		return sqlSession.selectList(NS + "selectCodeDet", grcode);
	}
	
	@Override
	public List<CodeVO> selectCodeDetWithCodeLike(JSONObject param) {
		return sqlSession.selectList(NS + "selectCodeDetWithCodeLike", param);
	}

	@Override
	public List<CodeVO> selectCodeDetWithCodeLike2(Map<String, Object> param) {
		return sqlSession.selectList(NS + "selectCodeDetWithCodeLike2", param);
	}

}
