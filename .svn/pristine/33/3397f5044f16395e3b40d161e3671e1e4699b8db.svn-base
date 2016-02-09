package com.myspring.gachon.admin.code.dao;

import java.util.List;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.common.exception.GachonDaoException;
import com.myspring.gachon.admin.code.vo.ManagementCodeVO;

import net.sf.json.JSONObject;

@Repository
public class ManagementCodeDaoImpl implements ManagementCodeDao {

	@Autowired
	private SqlSession sqlSession;
	// end must be point .
	private static final String NS = "mapper.com.myspring.gachon.admin.code.";

	@Override
	public List<ManagementCodeVO> selectCode_MST() {
		return sqlSession.selectList(NS + "selectCode_MST");
	}

	@Override
	public JSONObject insertCode_MST(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertCode_MST", vo);
	}

	@Override
	public JSONObject updateCode_MST(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.UPDATE, NS + "updateCode_MST", vo);
	}

	// RESULT_MSG는 .jsp view단에서 메시지 alert를 하는데 사용됨. 모든 MAP은 키(KEY)와 값(VALUE)를
	// 갖는다.
	@Override
	public JSONObject deleteCode_MST(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteCode_MST", vo);
	}

	@Override
	public List<ManagementCodeVO> selectCode_DET(ManagementCodeVO vo) {
		return sqlSession.selectList(NS + "selectCode_DET", vo);
	}

	@Override
	public JSONObject insertCode_DET(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertCode_DET", vo);
	}

	@Override
	public JSONObject updateCode_DET(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.UPDATE, NS + "updateCode_DET", vo);
	}

	@Override
	public JSONObject deleteCode_DET(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteCode_DET", vo);
	}

	@Override
	public JSONObject deleteCode_MDET(ManagementCodeVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteCode_MDET", vo);
	}
}
