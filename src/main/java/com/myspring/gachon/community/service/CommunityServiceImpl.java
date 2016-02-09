package com.myspring.gachon.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.community.dao.CommunityDAO;
import com.myspring.gachon.community.vo.CommunityNormalContentVO;
import com.myspring.gachon.community.vo.CommunityNormalListVO;
import com.myspring.gachon.community.vo.CommunityNormalReplyVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class CommunityServiceImpl implements CommunityService{
	
	@Autowired
	CommunityDAO communityDao;
	
	@Override
	public JSONArray getBoardList(String divs) {
		// TODO Auto-generated method stub
		communityDao.getBoardList(divs);
		
		return communityDao.getBoardList(divs);
		
	}

	@Override
	public JSONObject setWriteSubmit(CommunityNormalListVO list,CommunityNormalContentVO content) {
		// TODO Auto-generated method stub
		return communityDao.setWriteSubmit(list,content);
	}

	@Override
	public JSONObject getBoard(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		return communityDao.getBoard(vo);
	}

	@Override
	public JSONObject setReply(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		return communityDao.setReply(vo);
	}

	@Override
	public JSONArray getReply(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		return communityDao.getReply(vo);
	}

	@Override
	public JSONObject setReplyUpdate(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		return communityDao.setReplyUpdate(vo);
	}

	@Override
	public JSONObject setReplyDelete(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		return communityDao.setReplyDelete(vo);
	}

	@Override
	public JSONObject setBoardDelete(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		return communityDao.setBoardDelete(vo);
	}

	@Override
	public JSONObject setBoardUpdateSubmit(CommunityNormalContentVO content,CommunityNormalListVO list) {
		// TODO Auto-generated method stub
		return communityDao.setBoardUpdateSubmit(content,list);
	}

	
	
}
