package com.myspring.gachon.outcommunity.dao;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.outcommunity.vo.EventVo;

@Repository
public class EventDaoImpl implements EventDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.outcommunity.event.";

	/* 게시판 리스트 가져오기 */
	public List<EventVo> eventAllSelect() {
		return sqlSession.selectList(NS+"eventSelect");
	}
	
	@Override
	public JSONObject eventMstInsert(EventVo eventVo) {		
		
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"event_mstInsert", eventVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "이벤트가 등록되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject eventDetInsert(EventVo eventVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"event_detInsert", eventVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "이벤트가 등록되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject selectevent_list_seq(){
		return sqlSession.selectOne(NS+"selectevent_list_seq");
	}
	
	@Override
	public List<EventVo> loadData(int boardNum) {
		return sqlSession.selectList(NS+"loadData", boardNum);
	}
	
	@Override
	public JSONObject eventMstUpdate(EventVo eventVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"event_mstUpdate", eventVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "이벤트가 수정되었습니다");
		}
		return result;
	}
	
	@Override
	public JSONObject eventDetUpdate(EventVo eventVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"event_detUpdate", eventVo));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "이벤트가 수정되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject eventMstUpdateHit(EventVo eventVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"event_mstUpdateHit", eventVo));
		return result;
	}
	
	@Override
	public JSONObject eventMstUpdateLove(EventVo eventVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"event_mstUpdateLove", eventVo));
		return result;
	}
	
	@Override
	public JSONObject eventMstDelete(int boardNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"event_mstDelete", boardNum));
		if(result.getInt("RESULT_CODE") >0){
			result.put("RESULT_MSG", "이벤트가 삭제되었습니다.");
		}
		return result;
	}

	@Override
	public JSONObject eventDetDelete(int boardNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"event_detDelete", boardNum));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "이벤트가 삭제되었습니다.");
		}

		return result;
	}
	
}
