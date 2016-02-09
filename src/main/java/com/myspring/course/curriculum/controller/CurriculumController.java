package com.myspring.course.curriculum.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.admin.curriculum.service.ManagementCurriculumService;
import com.myspring.gachon.admin.curriculum.vo.ManagementCurriculumVO;
import com.myspring.gachon.common.code.CodeService;

@Controller
public class CurriculumController {
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping(value = "/course/curriculum", method = RequestMethod.GET)
	public String curriculum(Model model) {
		
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("COMPLETE_DIVISION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COMPLETE_DIVISION")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("YEAR")));
		
		
		return "/course/curriculum/curriculum";
	}
}