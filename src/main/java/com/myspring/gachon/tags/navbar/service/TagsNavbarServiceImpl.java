package com.myspring.gachon.tags.navbar.service;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.tags.navbar.dao.TagsNavbarDAO;
import com.myspring.gachon.tags.navbar.vo.TagsNavbarVO;

@Service
public class TagsNavbarServiceImpl implements TagsNavbarService{
	@Autowired
	TagsNavbarDAO tagsNavbarDAO;
	@Override
	public JSONArray getMenu(TagsNavbarVO vo, HttpServletRequest request) {
		// TODO Auto-generated method stub
		return tagsNavbarDAO.getMenu(vo, request);
	}

}
