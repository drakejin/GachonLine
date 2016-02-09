package com.myspring.gachon.friendFind.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.admin.curriculum.vo.ManagementCurriculumVO;
import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.friendFind.service.FriendFindService;
import com.myspring.gachon.friendFind.vo.FriendInfoVO;


@Controller
public class FriendFindController {
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;
	@Autowired
	private FriendFindService FriendFindServiceImpl;

	@RequestMapping(value = "/member/friend_find", method = RequestMethod.GET)
	public String friendFind(Model model) {
		model.addAttribute("MEMBER_TYPE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MEMBER_TYPE")));
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		
		return "/member/friend_find/FriendFind";
	}
	
	
	// select 친구
	@RequestMapping(value="/member/friend_find/selectFriendFindInfo")
	@ResponseBody
	public JSONArray selectFriendFindinfo(FriendInfoVO vo){
		return JSONArray.fromObject(FriendFindServiceImpl.selectFriendFindinfo(vo));
	}
	
	// select 친구검색 필터링
	@RequestMapping(value="/member/friend_find/selectFilterFnd")
	@ResponseBody
	public JSONArray selectFilterFnd(FriendInfoVO vo){
		return JSONArray.fromObject(FriendFindServiceImpl.selectFilterFnd(vo));
	}
	
	// insert 친구추가
	@RequestMapping(value = "/member/friend_find/insertFriendFindInfo.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertCurriculumMST(FriendInfoVO vo){
		return FriendFindServiceImpl.insertFriendFindinfo(vo);
	}
		
		
	// delete 친구삭제
	@RequestMapping(value = "/member/friend_find/deleteFriendFindInfo.delete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteCurriculumMST(FriendInfoVO vo){
		return FriendFindServiceImpl.deleteFriendFindinfo(vo);
	}
}