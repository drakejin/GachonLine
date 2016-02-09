package com.myspring.gachon.member.myinfo.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.member.myinfo.dao.MyInfoDao;
import com.myspring.gachon.member.myinfo.vo.MyInfoVO;

@Service
public class MyInfoServiceImpl implements MyInfoService {

	@Autowired
	private MyInfoDao myinfoDao;
		
	@Override
	public List<MyInfoVO> selectMyInfo_MST(MyInfoVO vo) {
		return myinfoDao.selectMyInfo_MST(vo);
	}

	@Override
	public JSONObject updateMyInfo_MST(HttpSession session, MyInfoVO vo) {
		return myinfoDao.updateMyInfo_MST(session, vo);
	}
}
