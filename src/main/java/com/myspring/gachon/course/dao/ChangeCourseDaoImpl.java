package com.myspring.gachon.course.dao;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.common.exception.GachonDaoException;
import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.course.vo.ChangeCourseVO;

@Repository
public class ChangeCourseDaoImpl implements ChangeCourseDao {

	@Autowired
	private SqlSession sqlSession;
	// end must be point .

	private static final String NS = "mapper.com.myspring.gachon.course.changeCourse.";
//			"mapper." + ChangeCourseDaoImpl.class.getPackage().getName() + ".";
	
	// select table_mst
	@Override
	public List<ChangeCourseVO> selectChangeCourseList(ChangeCourseVO vo) {
		
		return sqlSession.selectList(NS + "selectChangeCourse_MST", vo);
	}
	
	// select writeForm_mst
	@Override
	public List<ChangeCourseVO> selectWriteform(AdminCourseAllVO vo) {
		
		
		
		return sqlSession.selectList(NS + "selectWriteform_MST", vo);
	}

	
	// insert writeForm_mst
	@Override
	public JSONObject insertWriteform(ChangeCourseVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertWriteform_MST", vo);
	}
	
	
	@Override
	public int selectValidationCourse(AdminCourseAllVO vo) {
		return sqlSession.selectOne(NS + "selectValidationCourse_MST", vo);
	}
	
	
	
	// update course (수업교환 하기)
	@Override
	public JSONObject updateCourse(AdminCourseAllVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.UPDATE, NS + "updateCourse_MST", vo);
	}	
	
	@Override
	public JSONObject updateCHANGE_COURSE_MST(AdminCourseAllVO vo){
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.UPDATE, NS + "updateCHANGE_COURSE_MST", vo);
	}
}
