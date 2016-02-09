package com.myspring.gachon.home;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.member.myinfo.service.MyInfoService;
import com.myspring.gachon.member.myinfo.vo.MyInfoVO;

@Controller
public class HomeController {
	@Autowired
	private MyInfoService MyInfoServiceImpl;

	private static final Logger logger = LoggerFactory
			.getLogger(HomeController.class);

	@RequestMapping(value = { "/", "/test321.do", "/test123.go" }, method = RequestMethod.GET)
	public String login(ModelAndView mav) throws ServletRequestBindingException {
		return "/login";
	}
	@RequestMapping(value = "/error", method = RequestMethod.GET)
	public String sessionError(HttpServletRequest req) throws ServletRequestBindingException {
		logger.debug("req: "+req.getAttribute("error"));
		
		return "/login";
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest req,HttpSession session) throws ServletRequestBindingException {
		req.setAttribute(ContentKey.ACTION_ID,"logout");
		session.invalidate();
		
		return "/login";
	}
	
	// select
	@RequestMapping(value = "/home.select", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectHomeInfo_MST(MyInfoVO vo) {

		return JSONArray.fromObject(MyInfoServiceImpl.selectMyInfo_MST(vo));
	}
}
