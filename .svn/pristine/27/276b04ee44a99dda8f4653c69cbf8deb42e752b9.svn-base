package com.myspring.gachon.tags.navbar.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.tags.navbar.service.TagsNavbarService;
import com.myspring.gachon.tags.navbar.vo.TagsNavbarVO;

@Controller
public class TagsNavbarController {
	@Autowired
	TagsNavbarService tagsNavbarService;
	@Autowired
	HttpServletRequest request;
	//처음 페이지 보여주기
	@RequestMapping(value = "/tags/navbar.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray getMenu(TagsNavbarVO vo) {
		return tagsNavbarService.getMenu(vo,request);
	}

}
