package com.myspring.gachon.timetable.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.timetable.service.ShareTimetableService;
import com.myspring.gachon.timetable.vo.ShowTimetableVo;

@Controller
public class ShareTimetableController {
	@Autowired
	HttpServletRequest request;
	
	@Autowired 
	ShareTimetableService shareTimetableServiceImpl;
	
	@RequestMapping(value="/timetable/share_timetable")
	public String shareTimetable(){
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

