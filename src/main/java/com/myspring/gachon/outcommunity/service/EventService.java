package com.myspring.gachon.outcommunity.service;

import java.util.List;

import net.sf.json.JSONObject;

import com.myspring.gachon.outcommunity.vo.EventVo;

public interface EventService {
	List<EventVo> eventAllSelect(); //게시판 리스트 전체 출력
	JSONObject eventMstInsert(EventVo eventVo);
	JSONObject eventDetInsert(EventVo eventVo);
	JSONObject selectevent_list_seq();
	List<EventVo> loadData(int boardNum); //데이터 수정 할 때 데이터 가져오기
	JSONObject eventMstUpdate(EventVo eventVo); //게시된 이벤트 수정 - Event_MST UPDATE
	JSONObject eventDetUpdate(EventVo eventVo); //게시된 이벤트 수정 - Event_DET UPDATE
	JSONObject eventMstUpdateHit(EventVo eventVo);
	JSONObject eventMstUpdateLove(EventVo eventVo);
	JSONObject eventMstDelete(int boardNum); //게시된 이벤트 삭제 - Event_MST DELETE
	JSONObject eventDetDelete(int boardNum); //게시된 이벤트 삭제 - Event_DET DELETE
}
