package com.myspring.gachon.timetable.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.timetable.service.ProTimetableService;
import com.myspring.gachon.timetable.vo.ProTimetableVo;

@Controller
//@SessionAttributes("user")
public class ProTimetableController {
	@Autowired
	private ProTimetableService ProTimetableServiceImpl;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;

	// 페이지 로드
	@RequestMapping(value = "/timetable/pro_timetable", method = RequestMethod.GET)
	public String proTimetable(Model model){
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		
	
		return "/timetable/proTimetable/proTimetable";
	}
	
	// select 시간표 데이터
	@RequestMapping(value="/timetable/pro_timetable/selectTimetableInfo")
	@ResponseBody
	public JSONArray selectProTimetableinfo(ProTimetableVo vo){
		return JSONArray.fromObject(ProTimetableServiceImpl.selectProTimetableinfo(vo));
	}
}



