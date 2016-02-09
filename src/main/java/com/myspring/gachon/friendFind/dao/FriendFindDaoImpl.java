package com.myspring.gachon.friendFind.dao;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.common.exception.GachonDaoException;
import com.myspring.gachon.friendFind.vo.FriendInfoVO;

@Repository
public class FriendFindDaoImpl implements FriendFindDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.member.friendinfo.";
	
	@Override
	public List<FriendInfoVO> selectFriendFindinfo(FriendInfoVO vo) {
		return sqlSession.selectList(NS+"selectFriendInfo_MST", vo);
	}
	
	@Override
	public List<FriendInfoVO> selectFilterFnd(FriendInfoVO vo) {
		return sqlSession.selectList(NS+"selectFilterFriend_MST", vo);
	}
	
	@Override
	public JSONObject insertFriendFindinfo(FriendInfoVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertFriendInfo_MST", vo);
	}

	@Override
	public JSONObject deleteFriendFindinfo(FriendInfoVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteFriendInfo_MST", vo);
	}
}