package com.myspring.gachon.tags.select.controller;

import java.util.Locale;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.tags.select.service.TagsSelectService;
import com.myspring.gachon.tags.select.vo.TagsSelectVO;

@Controller
public class TagsSelectController {

	@Autowired
	TagsSelectService tagsSelectService;
	//처음 페이지 보여주기
	@RequestMapping(value = "/tags/select.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray manageMenu(TagsSelectVO vo) {
		return tagsSelectService.getOption(vo.getGrcode());
	}
}
