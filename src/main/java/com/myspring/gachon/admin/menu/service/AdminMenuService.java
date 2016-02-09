package com.myspring.gachon.admin.menu.service;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.myspring.gachon.admin.menu.vo.AdminMenuVO;

public interface AdminMenuService {

	List<AdminMenuVO> getMenuList();
	JSONObject getMenuShow(AdminMenuVO vo);
	JSONObject setMenuModify(AdminMenuVO vo);
	JSONObject setMenuSubmit(AdminMenuVO vo);
	JSONObject setMenuDelete(AdminMenuVO vo);
	JSONArray getParentMenuId();
	
}
