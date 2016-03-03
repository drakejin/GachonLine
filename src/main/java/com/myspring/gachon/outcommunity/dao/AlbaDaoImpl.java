package com.myspring.gachon.outcommunity.dao;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.outcommunity.vo.AlbaVo;

@Repository
public class AlbaDaoImpl implements AlbaDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.outcommunity.alba.";

	@Override
	public List<AlbaVo> albaAllSelect() {
		return sqlSession.selectList(NS+"albaSelect");
	}

	@Override
	public JSONObject albaMstInsert(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"alba_mstInsert", albaVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "아르바이트 정보가 등록되었습니다");
		}
		return result;
	}

	@Override
	public JSONObject albaDetInsert(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"alba_detInsert", albaVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "아르바이트 정보가 등록되었습니다");
		}
		return result;
	}

	@Override
	public JSONObject albaImgInsert(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"alba_imgInsert", albaVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "아르바이트 정보가 등록되었습니다");
		}
		return result;
	}

	@Override
	public JSONObject selectalba_list_seq() {
		return sqlSession.selectOne(NS+"selectalba_list_seq");
	}
	
	@Override
	public List<AlbaVo> loadData(int boardNum) {
		return sqlSession.selectList(NS+"loadData", boardNum);
	}
	
	@Override
	public JSONObject albaMstUpdate(AlbaVo albaVo) {
		JSONObject result = new JSONObject();	
		result.put("RESULT_CODE", sqlSession.update(NS+"alba_mstUpdate", albaVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 수정되었습니다");
		}
		return result;
	}
	
	@Override
	public JSONObject albaDetUpdate(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"alba_detUpdate", albaVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 수정되었습니다");
		}
		return result;
	}
	
	@Override
	public JSONObject albaImgUpdate(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"alba_imgUpdate", albaVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 수정되었습니다");
		}
		return result;
	}
	
	@Override
	public JSONObject albaMstUpdateHit(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"alba_mstUpdateHit", albaVo));
		
		return result;
	}
	
	@Override
	public JSONObject albaMstUpdateLove(AlbaVo albaVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"alba_mstUpdateLove", albaVo));
		
		return result;
	}
	
	@Override
	public JSONObject albaMstDelete(int boardNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"alba_mstDelete", boardNum));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 삭제되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject albaDetDelete(int boardNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"alba_detDelete", boardNum));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 삭제되었습니다");
		}
		return result;
	}
	
	@Override
	public JSONObject albaImgDelete(int boardNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"alba_imgDelete", boardNum));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "아르바이트 정보가 삭제되었습니다");
		}
		return result;
	}

}
