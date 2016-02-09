package com.myspring.gachon.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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

import com.myspring.gachon.common.code.CodeService;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.login.service.LoginService;
import com.myspring.gachon.login.vo.LoginVO;

@Controller
public class LoginController {
	@Autowired
	HttpServletRequest request;	
	@Autowired
	private CodeService CodeServiceimpl;

	private @Autowired LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value = "/login.go", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject procLogin(LoginVO data, HttpServletRequest request) throws ServletRequestBindingException {
		// 파라메터로 VO 객체를 넘기려고자 하는경우에는 request.getParameter로 불러올때의 key값이랑 페이지에 보이는 form 데이터 의 name 또는 ajax 의 dataFrom 내부의 key값 이 일치해야한다.
		// vo 의 변수명 = [ajax의 dataForm Key or form 태그의 name]
		
		LoginVO vo = loginService.getLoginSession(data);
		if(vo.getResult().equals(ContentKey.RESULT_SUCCESS)){
			HttpSession session = request.getSession();
			session.setAttribute(ContentKey.LOGIN_MEMBER, JSONObject.fromObject(vo));
			JSONObject resultData = new JSONObject();
			resultData.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
			return resultData; 
		}else{
			JSONObject resultData = new JSONObject();
			resultData.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return resultData;
		}
	}
	
	// 페이지 로드
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String loginSuccess(Model model) throws ServletRequestBindingException {
		// 파라메터로 VO 객체를 넘기려고자 하는경우에는 request.getParameter로 불러올때의 key값이랑 페이지에 보이는 form 데이터 의 name 또는 ajax 의 dataFrom 내부의 key값 이 일치해야한다.
		// vo 의 변수명 = [ajax의 dataForm Key or form 태그의 name]
		model.addAttribute("MEMBERTYPE", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MEMBERTYPE")));
		model.addAttribute("COLLEGE", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGE")));
		model.addAttribute("SCHOOL_YEAR", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("SCHOOL_YEAR")));
		model.addAttribute("DEPARTMENT", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("DEPARTMENT")));
		model.addAttribute("MAJOR", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("MAJOR")));
		model.addAttribute("COLLEGESTATUS", JSONArray.fromObject(CodeServiceimpl.selectCodeDet("COLLEGESTATUS")));

		return "home";
	}
}
