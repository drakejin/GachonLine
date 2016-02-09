package com.myspring.gachon.timetable.controller;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.member.myinfo.service.MyInfoService;
import com.myspring.gachon.member.myinfo.vo.MyInfoVO;
import com.myspring.gachon.timetable.service.ShowTimetableService;

@Controller
public class ShowTimetableController {
	@Autowired
	ShowTimetableService showTimetableServiceImpl;
	@Autowired
	private MyInfoService MyInfoServiceImpl;
	@Autowired
	private CodeService CodeServiceimpl;
	
	/*내 시간표 조회 페이지로 이동*/
	@RequestMapping(value="/timetable/show_timetable", method = RequestMethod.GET)
	public String timetalbeList(Model model){
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		
		return "timetable/showTimetable/showTimetable";
	}
	
	// select 상단 데이터
	@RequestMapping(value="/timetable/showTitmetable/selectMyinfo")
	@ResponseBody
	public JSONArray selectMyinfo(MyInfoVO vo){	// MyInfo의 내용과 동일하므로 Myinfo에서 가져오겠다

		return JSONArray.fromObject(MyInfoServiceImpl.selectMyInfo_MST(vo));
	}
	
	// select 시간표 데이터
	@RequestMapping(value="/timetable/showTimetable/selectTimetableInfo")
	@ResponseBody
	public JSONArray selectTimetableinfo(int memberId){
		return JSONArray.fromObject(showTimetableServiceImpl.selectTimetableinfo(memberId));
	}
}