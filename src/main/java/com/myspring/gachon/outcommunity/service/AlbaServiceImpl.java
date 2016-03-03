package com.myspring.gachon.outcommunity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sf.json.JSONObject;

import com.myspring.gachon.outcommunity.dao.AlbaDao;
import com.myspring.gachon.outcommunity.vo.AlbaVo;

@Service
public class AlbaServiceImpl implements AlbaService {
	@Autowired
	private AlbaDao albaDaoImpl;
	
	
	@Override
	public List<AlbaVo> albaAllSelect() {
		return albaDaoImpl.albaAllSelect();
	}
	
	@Override
	public JSONObject albaMstInsert(AlbaVo albaVo) {
		return albaDaoImpl.albaMstInsert(albaVo);
	}
	
	@Override
	public JSONObject albaDetInsert(AlbaVo albaVo) {
		return albaDaoImpl.albaDetInsert(albaVo);
	}

	@Override
	public JSONObject albaImgInsert(AlbaVo albaVo) {
		return albaDaoImpl.albaImgInsert(albaVo);
	}
	
	@Override
	public JSONObject selectalba_list_seq() {
		return albaDaoImpl.selectalba_list_seq();
	}
	
	@Override
	public List<AlbaVo> loadData(int boardNum) {
		return albaDaoImpl.loadData(boardNum);
	}
	
	@Override
	public JSONObject albaMstUpdate(AlbaVo albaVo) {
		return albaDaoImpl.albaMstUpdate(albaVo);
	}
	
	@Override
	public JSONObject albaDetUpdate(AlbaVo albaVo) {
		return albaDaoImpl.albaDetUpdate(albaVo);
	}
	
	@Override
	public JSONObject albaImgUpdate(AlbaVo albaVo) {
		return albaDaoImpl.albaImgUpdate(albaVo);
	}
	
	@Override
	public JSONObject albaMstUpdateHit(AlbaVo albaVo) {
		return albaDaoImpl.albaMstUpdateHit(albaVo);
	}
	
	@Override
	public JSONObject albaMstUpdateLove(AlbaVo albaVo) {
		return albaDaoImpl.albaMstUpdateLove(albaVo);
	}
	
	@Override
	public JSONObject albaMstDelete(int boardNum) {
		return albaDaoImpl.albaMstDelete(boardNum);
	}
	
	@Override
	public JSONObject albaDetDelete(int boardNum) {
		return albaDaoImpl.albaDetDelete(boardNum);
	}
	
	@Override
	public JSONObject albaImgDelete(int boardNum) {
		return albaDaoImpl.albaImgDelete(boardNum);
	}
}
