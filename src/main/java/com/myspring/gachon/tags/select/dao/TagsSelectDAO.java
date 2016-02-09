package com.myspring.gachon.tags.select.dao;

import com.myspring.gachon.tags.select.vo.TagsSelectVO;

import net.sf.json.JSONArray;

public interface TagsSelectDAO {

	JSONArray getOption(String grcode);
}
