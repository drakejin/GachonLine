package com.myspring.gachon.tags.select.service;

import com.myspring.gachon.tags.select.vo.TagsSelectVO;

import net.sf.json.JSONArray;


public interface TagsSelectService {
	JSONArray getOption(String grcode);
}
