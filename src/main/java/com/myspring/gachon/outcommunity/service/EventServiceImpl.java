package com.myspring.gachon.outcommunity.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.outcommunity.dao.EventDao;
import com.myspring.gachon.outcommunity.vo.EventVo;

@Service
public class EventServiceImpl implements EventService {
	@Autowired
	private EventDao eventDaoImpl;
	
	public List<EventVo> eventAllSelect() {
		
		return eventDaoImpl.eventAllSelect();
	}
	
	@Override
	public JSONObject eventMstInsert(EventVo eventVo) {
		return eventDaoImpl.eventMstInsert(eventVo);
	}
	
	@Override
	public JSONObject eventDetInsert(EventVo eventVo) {
		return eventDaoImpl.eventDetInsert(eventVo);
	}
	
	@Override
	public JSONObject selectevent_list_seq() {
		return eventDaoImpl.selectevent_list_seq();
	}
	
	@Override
	public List<EventVo> loadData(int boardNum) {
		return eventDaoImpl.loadData(boardNum);
	}
	
	@Override
	public JSONObject eventMstUpdate(EventVo eventVo) {
		return eventDaoImpl.eventMstUpdate(eventVo);
	}
	
	@Override
	public JSONObject eventDetUpdate(EventVo eventVo) {
		return eventDaoImpl.eventDetUpdate(eventVo);
	}
	
	@Override
	public JSONObject eventMstUpdateHit(EventVo eventVo) {
		return eventDaoImpl.eventMstUpdateHit(eventVo);
	}
	
	@Override
	public JSONObject eventMstUpdateLove(EventVo eventVo) {
		return eventDaoImpl.eventMstUpdateLove(eventVo);
	}
	
	@Override
	public JSONObject eventMstDelete(int boardNum) {
		return eventDaoImpl.eventMstDelete(boardNum);
	}
	
	@Override
	public JSONObject eventDetDelete(int boardNum) {
		return eventDaoImpl.eventDetDelete(boardNum);
	}
}
