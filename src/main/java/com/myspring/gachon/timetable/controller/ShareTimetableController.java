package com.myspring.gachon.timetable.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.timetable.service.ShareTimetableService;

@Controller
public class ShareTimetableController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired 
	ShareTimetableService shareTimetableServiceImpl;
	
	@RequestMapping(value="/timetable/share_timetable")
	public String shareTimetable(Model model){
		
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		
		return "timetable/shareTimetable/shareTimetable";
	}
	
	@RequestMapping(value="/timetable/shareTitmetable/selectMyfnd")
	@ResponseBody
	public JSONArray selectMyfnd(int memberId){
		System.out.println("dddddddddddddddddddddddddddddddd"+memberId);
		return JSONArray.fromObject(shareTimetableServiceImpl.selectMyfnd(memberId));
	}
	
	@RequestMapping(value="/timetable/shareTimetable/selectFndinfo")
	@ResponseBody
	public JSONArray selectFndinfo(int memberId){
		return JSONArray.fromObject(shareTimetableServiceImpl.selectFndInfo(memberId));
	}
	
}

