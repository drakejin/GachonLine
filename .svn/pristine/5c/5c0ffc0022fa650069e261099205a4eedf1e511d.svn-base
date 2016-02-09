package com.myspring.gachon.timetable.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.timetable.vo.ShowTimetableVo;

@Repository
public class ShowTimetableDaoImpl implements ShowTimetableDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.timetable.showTimetable.";

	@Override
	public List<ShowTimetableVo> selectTimetableinfo(int memberId) {
		return sqlSession.selectList(NS+"timetableInfo", memberId);
	}
}
