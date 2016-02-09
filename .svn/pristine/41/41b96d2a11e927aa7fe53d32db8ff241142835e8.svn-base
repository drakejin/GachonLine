package com.myspring.gachon.timetable.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.timetable.vo.ProTimetableVo;

@Repository
public class ProTimetableDaoImpl implements ProTimetableDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.timetable.proTimetable.";
	
	@Override
	public List<ProTimetableVo> selectProTimetableinfo(ProTimetableVo vo) {
		return sqlSession.selectList(NS+"proTimetableInfo", vo);
	}
}