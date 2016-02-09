package com.myspring.gachon.member.myinfo.contoller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;





import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.bind.annotation.SessionAttributes;





import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.member.myinfo.service.MyInfoService;
import com.myspring.gachon.member.myinfo.vo.MyInfoVO;

@Controller
//@SessionAttributes("user")
public class MyInfoController {
	@Autowired
	private MyInfoService MyInfoServiceImpl;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;

	// 페이지 로드
	@RequestMapping(value = "/member/my_info", method = RequestMethod.GET)
	public String my_info(Model model){
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("SEMESTER",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SEMESTER")));
		model.addAttribute("COMPLETE_DIVISION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COMPLETE_DIVISION")));
		model.addAttribute("SCHOOL_YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SCHOOL_YEAR")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("GRADE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("GRADE")));
		model.addAttribute("ENGINEERING_AUTHENTICATION",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("ENGINEERING_AUTHENTICATION")));
		
		return "/member/my_info/myInfo";
	}
	
	// select
	@RequestMapping(value = "/member/my_info/myInfo.select", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectMyInfo_MST(MyInfoVO vo) {

		return JSONArray.fromObject(MyInfoServiceImpl.selectMyInfo_MST(vo));
	}
	
	// update
	@RequestMapping(value = "/member/my_info/myInfo.update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateMyInfo_MST(HttpSession session, MyInfoVO vo){
		JSONObject result = MyInfoServiceImpl.updateMyInfo_MST(session, vo);
		
		if(result.getInt("RESULT_CODE")>0){
			session.removeAttribute(ContentKey.LOGIN_MEMBER);
			session.setAttribute(ContentKey.LOGIN_MEMBER,JSONObject.fromObject(vo));
		}

		return result;
	}
}