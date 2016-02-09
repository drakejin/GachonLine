package com.myspring.gachon.friendFind.service;

import java.util.List;

import net.sf.json.JSONObject;

import com.myspring.gachon.friendFind.vo.FriendInfoVO;

public interface FriendFindService {

	List<FriendInfoVO> selectFriendFindinfo(FriendInfoVO vo);
	
	List<FriendInfoVO> selectFilterFnd(FriendInfoVO vo);

	JSONObject insertFriendFindinfo(FriendInfoVO vo);
	
	JSONObject deleteFriendFindinfo(FriendInfoVO vo);
}
