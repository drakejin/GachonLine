package com.myspring.gachon.admin.curriculum.controller;

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
public class ManagementCurriculumController {
	@Autowired
	private ManagementCurriculumService ManagementCurriculumServiceImpl;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;

	@RequestMapping(value = "/admin/manage_curriculum", method = RequestMethod.GET)
	public String manage_curriculum(Model model) {
		model.addAttribute("COMPLETE_DIVISION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COMPLETE_DIVISION")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		
		return "/admin/manage_curriculum/ManagementCurriculum";
	}

	// selectCourseCurriculum_MST select
	@RequestMapping(value = "/admin/manage_curriculum/curriculumMST.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectCurriculumMST(ManagementCurriculumVO vo) {
		System.out.println("*****Controller까지 넘어 온 major 값*******"+vo.getMajor()+"********");
		System.out.println("*****Controller까지 넘어 온 year 값*******"+vo.getYear()+"********");
		System.out.println("*****Controller까지 넘어 온 schoolYear 값*******"+vo.getSchoolYear()+"********");
		
		return JSONArray.fromObject(ManagementCurriculumServiceImpl.selectCourseCurriculum_MST(vo));
	}
//	@RequestMapping(value = "/admin/manage_curriculum/curriculumMST.json", method = RequestMethod.POST)
//	@ResponseBody
//	public JSONObject curriculumMST(ManagementCurriculumVO vo){
//		return ManagementCurriculumServiceImpl.selectCourseCurriculum_MST(vo);
//	}
	
	// insertCourseCurriculum_MST insert
	@RequestMapping(value = "/admin/manage_curriculum/curriculumMST.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertCurriculumMST(ManagementCurriculumVO vo){
		return ManagementCurriculumServiceImpl.insertCourseCurriculum_MST(vo);
	}
	
	// updateCourseCurriculum_MST update
	@RequestMapping(value = "/admin/manage_curriculum/curriculumMST.update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCurriculumMST(ManagementCurriculumVO vo){
		return ManagementCurriculumServiceImpl.updateCourseCurriculum_MST(vo);
	}
	
	// deleteCourseCurriculum_MST delete
	@RequestMapping(value = "/admin/manage_curriculum/curriculumMST.delete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteCurriculumMST(ManagementCurriculumVO vo){
		return ManagementCurriculumServiceImpl.deleteCourseCurriculum_MST(vo);
	}
}