package com.myspring.gachon.outcommunity.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.myspring.gachon.outcommunity.vo.AlbaVo;

public interface AlbaService {
	List<AlbaVo> albaAllSelect();
	JSONObject albaMstInsert(AlbaVo albaVo);
	JSONObject albaDetInsert(AlbaVo albaVo);
	JSONObject albaImgInsert(AlbaVo albaVo);
	JSONObject selectalba_list_seq(); //테이블 연결하는 seq 가져오기
	List<AlbaVo> loadData(int boardNum); //데이터 수정 할 때 데이터 가져오기
	JSONObject albaMstUpdate(AlbaVo albaVo); 
	JSONObject albaDetUpdate(AlbaVo albaVo);
	JSONObject albaImgUpdate(AlbaVo albaVo);
	JSONObject albaMstUpdateHit(AlbaVo albaVo);
	JSONObject albaMstUpdateLove(AlbaVo albaVo);
	JSONObject albaMstDelete(int boardNum);
	JSONObject albaDetDelete(int boardNum); 
	JSONObject albaImgDelete(int boardNum); 
}
