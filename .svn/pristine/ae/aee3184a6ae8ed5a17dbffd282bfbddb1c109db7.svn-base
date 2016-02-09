package com.myspring.gachon.course.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.course.service.ChangeCourseService;
import com.myspring.gachon.course.vo.ChangeCourseVO;

@Controller
public class ChangeCourseController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	private ChangeCourseService changeCourseServiceImpl;
	

	@RequestMapping(value = "/course/change_course", method = RequestMethod.GET)
	public String change_course(){
		
		return "/course/change_course/changeCourse";
	}
	
	// select 시간표 데이터
	@RequestMapping(value="/course/change_course/selectChangeCourseList")
	@ResponseBody
	public JSONArray selectChangeCourseList(ChangeCourseVO vo){
		return JSONArray.fromObject(changeCourseServiceImpl.selectChangeCourseList(vo));
	}
	
	// select 글쓰기 폼 데이터
	@RequestMapping(value="/course/change_course/selectWriteform")
	@ResponseBody
	public JSONArray selectWriteform(AdminCourseAllVO vo){
		
		return JSONArray.fromObject(changeCourseServiceImpl.selectWriteform(vo));
	}

	// insert 글쓰기 폼 데이터
	@RequestMapping(value = "/course/change_course/insertWriteform", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertWriteform(ChangeCourseVO vo){
		return changeCourseServiceImpl.insertWriteform(vo);
	}
	
	// updateCourse update
	@RequestMapping(value = "/course/change_course/updateCourse.update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCourse(AdminCourseAllVO vo){
//		System.err.println(JSONObject.fromObject(vo));
//		return null;
		return changeCourseServiceImpl.updateCourse(vo);
	}
	
}