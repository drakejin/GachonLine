package com.myspring.gachon.common.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommonController {
private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/common/show_all", method = RequestMethod.GET)
	public String showAll(Locale locale, Model model) {
		logger.info("기타 서비스~!", locale);
		
		//model.addAttribute("serverTime", formattedDate );
		
		return "/common/show_all";
	}
}
