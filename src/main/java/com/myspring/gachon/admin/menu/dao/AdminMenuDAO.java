package com.myspring.gachon.admin.menu.dao;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.myspring.gachon.admin.menu.vo.AdminMenuVO;



public interface AdminMenuDAO {
	List<AdminMenuVO> getMenuList();
	JSONObject getMenuShow(AdminMenuVO vo);
	JSONObject setMenuModify(AdminMenuVO vo);
	JSONObject setMenuSubmit(AdminMenuVO vo);
	JSONArray getParentMenuId();
	
	int setMenuDelete(AdminMenuVO vo);
	int getMenuChildCount(AdminMenuVO vo);
	int setMenuAllDelete(AdminMenuVO vo);
	
}
