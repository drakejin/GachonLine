package com.myspring.gachon.outcommunity.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StoreCommunity {
	@RequestMapping(value="/outCommunity/store", method=RequestMethod.GET)
	public String storeList(){
		return "/outCommunity/store/store";	
	}
}


