package com.myspring.gachon.timetable.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.timetable.vo.ShareTimetableVo;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

@Repository
public class ShareTimetableDaoImpl implements ShareTimetableDao {
	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.timetable.shareTimetable.";
	
	@Override
	public List<ShareTimetableVo> selectMyfnd(int memberId) {
		return sqlSession.selectList(NS+"myFnd", memberId);
	}
	
	@Override
	public List<ShareTimetableVo> selectFndInfo(int memberId) {
		return sqlSession.selectList(NS+"fndInfo", memberId);
	}

}

