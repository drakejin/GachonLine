package com.myspring.gachon.course.dao;

import java.util.List;

import net.sf.json.JSONObject;

import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.course.vo.ChangeCourseVO;

public interface ChangeCourseDao {

	List<ChangeCourseVO> selectChangeCourseList(ChangeCourseVO vo);
	
	List<ChangeCourseVO> selectWriteform(AdminCourseAllVO vo);
	
	JSONObject insertWriteform(ChangeCourseVO vo);
	
	int selectValidationCourse(AdminCourseAllVO vo);
	
	JSONObject updateCourse(AdminCourseAllVO vo);

	JSONObject updateCHANGE_COURSE_MST(AdminCourseAllVO vo);
}
