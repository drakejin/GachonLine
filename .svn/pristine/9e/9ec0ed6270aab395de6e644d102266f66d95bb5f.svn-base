package com.myspring.gachon.friendFind.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.friendFind.vo.FriendInfoVO;
import com.myspring.gachon.friendFind.dao.FriendFindDao;

@Service
public class FriendFindServiceImpl implements FriendFindService {

	@Autowired
	private FriendFindDao FriendFindDao;

	@Override
	public List<FriendInfoVO> selectFriendFindinfo(FriendInfoVO vo) {
		return FriendFindDao.selectFriendFindinfo(vo);
	}
	
	@Override
	public List<FriendInfoVO> selectFilterFnd(FriendInfoVO vo) {
		return FriendFindDao.selectFilterFnd(vo);
	}
	
	@Override
	public JSONObject insertFriendFindinfo(FriendInfoVO vo) {
		return FriendFindDao.insertFriendFindinfo(vo);
	}

	@Override
	public JSONObject deleteFriendFindinfo(FriendInfoVO vo) {
		return FriendFindDao.deleteFriendFindinfo(vo);
	}
}



