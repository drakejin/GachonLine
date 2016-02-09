package com.myspring.gachon.admin.course.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.admin.controller.AdminController;
import com.myspring.gachon.admin.course.service.AdminCourseService;
import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.admin.course.vo.AdminCourseApplicantVO;
import com.myspring.gachon.admin.course.vo.AdminCourseDetailVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMajorMapVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMasterVO;
import com.myspring.gachon.admin.member.service.AdminMemberService;
import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.content.ContentKey;


@Controller
public class AdminCourseController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	private AdminCourseService adminCourseService;
		
	@RequestMapping(value = "/admin/manage_course", method = RequestMethod.GET)
	public String manageCourse(Locale locale, Model model) {
		logger.info("AdminController -> manageCourse", locale);
		model.addAttribute("PAGE",adminCourseService.getDrawCode());
		model.addAttribute("GRADE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("GRADE")));
		model.addAttribute("SCHOOL_YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SCHOOL_YEAR")));
		model.addAttribute("LEC_TIME",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("LEC_TIME")));
		
		
		return "/admin/manage_course/ManagementCourse";
	}
	
	@RequestMapping(value = "/admin/manage_course/submit.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject submitJson(AdminCourseDetailVO detVO, AdminCourseMasterVO mstVO,AdminCourseMajorMapVO mapVO) {
		return adminCourseService.setCourseSubmit(detVO, mstVO, mapVO);
	}
	
	@RequestMapping(value = "/admin/manage_course/list.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray listJson(AdminCourseAllVO vo) {
		return adminCourseService.getCourseList(vo);
	}
	
	@RequestMapping(value = "/admin/manage_course/show.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject showJson(AdminCourseMajorMapVO mapVO) {
		return adminCourseService.getCourseShow(mapVO);
	}
	@RequestMapping(value = "/admin/manage_course/modify.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject modifyJson(AdminCourseDetailVO detVO, AdminCourseMasterVO mstVO,AdminCourseMajorMapVO mapVO) {
		return adminCourseService.setCourseModify(detVO,mstVO,mapVO);
	}
	@RequestMapping(value = "/admin/manage_course/delete.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteJson(AdminCourseMajorMapVO mapVO) {
		return adminCourseService.setCourseDelete(mapVO);
	}
	
	
	/* Applicant Part */
	// COURSE_APPLICANT_STATE select
	@RequestMapping(value = "/admin/manage_course/applicantState.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectApplicantState(AdminCourseApplicantVO vo) {
		
		System.out.println("*****controller까지 넘어 온 courseNum 값*******"+vo.getCourseNum()+"********");
		

		return JSONArray.fromObject(adminCourseService.selectApplicantState(vo));
	}

	// COURSE_APPLICANT_STATE insert
	@RequestMapping(value = "/admin/manage_course/applicantState.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertApplicantState(AdminCourseApplicantVO vo) {
		return adminCourseService.insertApplicantState(vo);
	}
	
	// COURSE_APPLICANT_STATE delete
		@RequestMapping(value = "/admin/manage_course/applicantState.delete", method = RequestMethod.POST)
		@ResponseBody
		public JSONObject deleteApplicantState(AdminCourseApplicantVO vo) {
			
			return adminCourseService.deleteApplicantState(vo);
	}
	
	
	
	
	
	
	
	
	
	/* TEMPORARY_SCHEDULE Part */
	// TEMPORARY_SCHEDULE select
	@RequestMapping(value = "/admin/manage_course/temporarySchedule.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectTemporarySchedule(AdminCourseAllVO vo) {
		
		return JSONArray.fromObject(adminCourseService.selectTemporarySchedule(vo));
	}

	// TEMPORARY_SCHEDULE insert
	@RequestMapping(value = "/admin/manage_course/temporarySchedule.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertTemporarySchedule(AdminCourseAllVO vo) {
		
		return adminCourseService.insertTemporarySchedule(vo);
	}
	
	// TEMPORARY_SCHEDULE delete
	@RequestMapping(value = "/admin/manage_course/temporarySchedule.delete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteTemporarySchedule(AdminCourseAllVO vo) {
			
		return adminCourseService.deleteTemporarySchedule(vo);
	}
}
