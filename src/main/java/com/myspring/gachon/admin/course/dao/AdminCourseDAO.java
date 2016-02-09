package com.myspring.gachon.admin.course.dao;

import java.util.List;

import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.admin.course.vo.AdminCourseApplicantVO;
import com.myspring.gachon.admin.course.vo.AdminCourseDetailVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMajorMapVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMasterVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface AdminCourseDAO {
	JSONObject getDrawCode();

	JSONObject setCourseSubmit(AdminCourseDetailVO detVO, AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO);

	JSONArray getCourseList(AdminCourseAllVO vo);

	JSONObject getCourseShow(AdminCourseMajorMapVO mapVO);

	JSONObject setCourseModify(AdminCourseDetailVO detVO, AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO);

	JSONObject setCourseDelete(AdminCourseMajorMapVO mapVO);

	// 신청자 현황보기
	List<AdminCourseApplicantVO> selectApplicantState(AdminCourseApplicantVO vo);
	JSONObject insertApplicantState(AdminCourseApplicantVO vo);
	JSONObject deleteApplicantState(AdminCourseApplicantVO vo);

	// 가상시간표 보기
	List<AdminCourseApplicantVO> selectTemporarySchedule(AdminCourseAllVO vo);
	JSONObject insertTemporarySchedule(AdminCourseAllVO vo);
	JSONObject deleteTemporarySchedule(AdminCourseAllVO vo);

	
}
