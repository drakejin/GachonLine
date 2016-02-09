package com.myspring.gachon.admin.member.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.gachon.admin.member.service.AdminMemberService;
import com.myspring.gachon.admin.member.vo.AdminMemberVO;
import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.login.service.LoginService;
import com.myspring.gachon.login.vo.LoginVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminMemberController {
	@Autowired
	private AdminMemberService adminMemberService;
	@Autowired
	private CodeService CodeServiceimpl;
	@Autowired
	HttpServletRequest request;
	
	@Autowired 
	private LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberController.class);
	
	
	//처음 페이지 보여주기
	@RequestMapping(value = "/admin/manage_member", method = RequestMethod.GET)
	public String manageMember(Locale locale, Model model) {
		logger.info("관리자 회원관리에 요코소!", locale);
		model.addAttribute("COLLEGE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("COLLEGE_STATUS",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE_STATUS")));
		model.addAttribute("COMPLETE_TERM",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COMPLETE_TERM")));
		model.addAttribute("YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("YEAR")));
		model.addAttribute("DEPARTMENT",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("TEL",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("TEL")));
		model.addAttribute("PHONE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("PHONE")));
		model.addAttribute("SCHOOL_YEAR",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SCHOOL_YEAR")));
		model.addAttribute("MEMBER_TYPE",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MEMBER_TYPE")));
		model.addAttribute("USE_YN",JSONArray.fromObject(CodeServiceimpl.selectCodeDet("USE_YN")));
		
		
		
		return "/admin/manage_member/ManagementMember";
	}
	
	//처음 페이지 보여주면서 ajax로 사용자  리스트를 Table 에 뽑는다.
	@RequestMapping(value = "/admin/manage_member/list.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray listMember(Locale locale, Model model, AdminMemberVO vo) {
		logger.info("print Member's list in admin", locale);
		return JSONArray.fromObject(adminMemberService.getMemberList(vo));
	}
	
	//처음 페이지 보여주면서 ajax로 사용자  리스트를 Table 에 뽑는다.
		@RequestMapping(value = "/admin/manage_member/friendInfo.json", method = RequestMethod.POST)
		@ResponseBody
		public JSONArray selectFriendInfo(Locale locale, Model model, AdminMemberVO vo) {
			return JSONArray.fromObject(adminMemberService.getFriendInfo(vo));
	}
		
	
	
	//해당 사용자를 추가할꺼에요!
	@RequestMapping(value = "/admin/manage_member/add.dao", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject addMember(AdminMemberVO data) throws ServletRequestBindingException{
		// 파라메터로 VO 객체를 넘기려고자 하는경우에는 request.getParameter로 불러올때의 key값이랑 페이지에 보이는 form 데이터 의 name 또는 ajax 의 dataFrom 내부의 key값 이 일치해야한다.
		// vo 의 변수명 = [ajax의 dataForm Key or form 태그의 name]
		
		logger.debug(JSONObject.fromObject(request.getParameterMap()).toString());
		return adminMemberService.setMemberAdd(data);
	} 	
	
	
	//해당 table의 row 를 클릭하였을때 modal 로 해당 회원 정보를 띄운다.
	@RequestMapping(value = "/admin/manage_member/show.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject showMember(Locale locale, AdminMemberVO vo) throws NumberFormatException, ServletRequestBindingException {
		logger.info(vo.getMemberId());
		AdminMemberVO data = adminMemberService.getMemberShow(vo);
		if(data.getResult().equals(ContentKey.RESULT_SUCCESS)){
			return JSONObject.fromObject(data);
		}else{
			JSONObject result = new JSONObject();
			result.put("result", ContentKey.RESULT_FAIL);		// proTimetable에서 fail 떨어짐;
			return result;
		}
		//안녕 ㅋ
	}
	
	//해당 유저를 수정할거에용!
	
	@RequestMapping(value = "/admin/manage_member/modify.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject modifyMember(Locale locale, AdminMemberVO vo) {
		logger.debug(JSONObject.fromObject(request.getParameterMap()).toString());
		JSONObject result = new JSONObject();
		
		HttpSession session = request.getSession();
		JSONObject obj = (JSONObject) session.getAttribute(ContentKey.LOGIN_MEMBER); 
		
		if(vo.getMemberId().equals(obj.getString("memberId"))){
			if(!vo.getMemberType().equals("ADM")){
				result = new JSONObject();
				result.put(ContentKey.RESULT_MSG, ContentKey.ADM_CANNOT_CHANGE_SELF_TYPE);
			}else{
				result = adminMemberService.setMemberModify(vo);
			}
		}else{
			result = adminMemberService.setMemberModify(vo);
		}
		
		
		
		
		return result;
	}

	
	
	//해당 유저를 삭제하겠어용!
	@RequestMapping(value = "/admin/manage_member/delete.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteMember(Locale locale, AdminMemberVO vo) {
		logger.info("print Member's delete in admin", locale);
		JSONObject result = new JSONObject();
		
		HttpSession session = request.getSession();
		JSONObject obj = (JSONObject) session.getAttribute(ContentKey.LOGIN_MEMBER);
		
		if(vo.getMemberId().equals(obj.getString("memberId"))){
			result = new JSONObject();
			result.put(ContentKey.RESULT_MSG, ContentKey.ADM_CANNOT_DELETE_SELF_ACCOUNT);
		}else{
			result = adminMemberService.setMemberDelete(vo);
		}

		return result;
	}
	protected ModelAndView goOut(){
		return new ModelAndView("redirect:/");
	}
	protected ModelAndView goHome() {
		return new ModelAndView("redirect:/home");
	}
}

