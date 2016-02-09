package com.myspring.gachon.friendFind.dao;

import java.util.List;

import net.sf.json.JSONObject;

import com.myspring.gachon.friendFind.vo.FriendInfoVO;

public interface FriendFindDao {
	List<FriendInfoVO> selectFriendFindinfo(FriendInfoVO vo);
	
	List<FriendInfoVO> selectFilterFnd(FriendInfoVO vo);
	
	JSONObject insertFriendFindinfo(FriendInfoVO vo);
	
	JSONObject deleteFriendFindinfo(FriendInfoVO vo);
	
}
