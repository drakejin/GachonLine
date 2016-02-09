package com.myspring.course.course.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.common.code.CodeVO;

@Controller
public class CourseController {
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;

	// 페이지 로드
	@RequestMapping(value = "/course/course", method = RequestMethod.GET)
	public String course(Model model){
		
		// COLLEGE가 List<CodeVO> 형 이기 때문에, jsp에서 code = ${COLLEGE} 라고 넘기면 List<CodeVO> 객체가 넘어감
		// String형으로 바꾸어서 넘겨주기 위해서 JSONArray.fromObject로 변환시켜서 넘겨준 것.
		// 만약 안쓰고 한다면, List의 형태로 넘기는게 되어버림
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("SEMESTER",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SEMESTER")));
		model.addAttribute("COMPLETE_DIVISION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COMPLETE_DIVISION")));
		model.addAttribute("SCHOOL_YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SCHOOL_YEAR")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("GRADE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("GRADE")));
		model.addAttribute("ENGINEERING_AUTHENTICATION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("ENGINEERING_AUTHENTICATION")));
		
		
		return "/course/course/course";
	}
}


