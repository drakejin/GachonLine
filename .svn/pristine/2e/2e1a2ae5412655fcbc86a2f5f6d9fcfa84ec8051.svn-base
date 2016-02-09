package com.myspring.gachon.outcommunity.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.outcommunity.service.EventService;
import com.myspring.gachon.outcommunity.vo.EventVo;

@Controller
public class EventController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	private EventService eventServiceImpl;
	@Autowired
	PlatformTransactionManager platformTransactionManager;

	/* 이벤트 정보 보기 */
	@RequestMapping(value = "/outCommunity/event", method = RequestMethod.GET)
	public String eventList() {
		return "/outCommunity/event/event";
	}

	/* 전체 이벤트 리스트 가져오기 */
	@RequestMapping(value = "/outcommuniy/event/evnetList.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray eventAllSelect() {
		return JSONArray.fromObject(eventServiceImpl.eventAllSelect());
	}

	/* 이벤트 등록하기(글쓰기) */
	@RequestMapping(value = "/outcommunity/event/eventInsert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject eventInsert(EventVo eventVo) {
		String crtUser = "글쓴이";
		eventVo.setCrtUser(crtUser);
		String updtUser = "김지연";
		eventVo.setUpdtUser(updtUser);

		//seq 가져오기
		JSONObject seq = eventServiceImpl.selectevent_list_seq();
		eventVo.setEventBoardNum(seq.getInt("EVENT_LIST_SEQ"));

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(EventController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = eventServiceImpl.eventMstInsert(eventVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = eventServiceImpl.eventDetInsert(eventVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}

	/* 데이터 로드해오기 */
	@RequestMapping(value = "/outcommunity/event/updateLoadData", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray loadData(int boardNum) {
		return JSONArray.fromObject(eventServiceImpl.loadData(boardNum));
	}

	/* 등록된 이벤트 수정하기 */
	@RequestMapping(value = "/outcommunity/event/updateEvent", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject eventUpdate(EventVo eventVo, int boardNum) {
		int eventBoardNum = Integer.parseInt(request.getParameter("boardNum"));
		eventVo.setEventBoardNum(eventBoardNum);

		String updt_user = "수정자"; // 세션처리!!!
		eventVo.setUpdtUser(updt_user);

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(EventController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = eventServiceImpl.eventMstUpdate(eventVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = eventServiceImpl.eventDetUpdate(eventVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}

	/* 이벤트 게시글 삭제하기 */
	@RequestMapping(value = "/outcommunity/event/deleteEvent", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject eventDelete(int boardNum) {
		int eventBoardNum = Integer.parseInt(request.getParameter("boardNum"));

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(EventController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = eventServiceImpl.eventMstDelete(eventBoardNum);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = eventServiceImpl.eventDetDelete(eventBoardNum);
		}

		platformTransactionManager.commit(status);

		return obj;
	}
	
}