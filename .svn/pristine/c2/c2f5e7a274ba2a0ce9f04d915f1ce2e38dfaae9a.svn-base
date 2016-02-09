package com.myspring.gachon.admin.course.service;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.admin.course.dao.AdminCourseDAO;
import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.admin.course.vo.AdminCourseApplicantVO;
import com.myspring.gachon.admin.course.vo.AdminCourseDetailVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMajorMapVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMasterVO;

@Service
public class AdminCourseServiceImpl implements AdminCourseService{
	
	@Autowired
	private AdminCourseDAO adminCourseDAO;
		
	@Override
	public JSONObject getDrawCode() {
		// TODO Auto-generated method stub
		return adminCourseDAO.getDrawCode();
	}

	@Override
	public JSONObject setCourseSubmit(AdminCourseDetailVO detVO, 
			AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		return adminCourseDAO.setCourseSubmit(detVO,mstVO,mapVO);
	}

	@Override
	public JSONArray getCourseList(AdminCourseAllVO vo) {
		// TODO Auto-generated method stub
		return adminCourseDAO.getCourseList(vo);
	}

	@Override
	public JSONObject getCourseShow(AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		return adminCourseDAO.getCourseShow(mapVO);
	}

	@Override
	public JSONObject setCourseModify(AdminCourseDetailVO detVO,
			AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		return adminCourseDAO.setCourseModify(detVO, mstVO, mapVO);
	}

	@Override
	public JSONObject setCourseDelete(AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		return adminCourseDAO.setCourseDelete(mapVO);
	}

	//  신청자 현황보기
	@Override
	public List<AdminCourseApplicantVO> selectApplicantState(AdminCourseApplicantVO vo) {
		System.out.println("*****Service까지 넘어 온 courseNum 값*******"+vo.getCourseNum()+"********");
		
		return adminCourseDAO.selectApplicantState(vo);
	}

	@Override
	public JSONObject insertApplicantState(AdminCourseApplicantVO vo) {
		return adminCourseDAO.insertApplicantState(vo);
	}
	
	@Override
	public JSONObject deleteApplicantState(AdminCourseApplicantVO vo) {
		return adminCourseDAO.deleteApplicantState(vo);
	}

	// 가상시간표 보기
	@Override
	public List<AdminCourseApplicantVO> selectTemporarySchedule(AdminCourseAllVO vo) {
		return adminCourseDAO.selectTemporarySchedule(vo);
	}

	@Override
	public JSONObject insertTemporarySchedule(AdminCourseAllVO vo) {
		return adminCourseDAO.insertTemporarySchedule(vo);
	}

	@Override
	public JSONObject deleteTemporarySchedule(AdminCourseAllVO vo) {
		return adminCourseDAO.deleteTemporarySchedule(vo);
	}

}
