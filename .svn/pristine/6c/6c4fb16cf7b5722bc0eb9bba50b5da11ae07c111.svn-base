package com.myspring.gachon.tags.select.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.myspring.gachon.tags.select.dao.TagsSelectDAO;
import com.myspring.gachon.tags.select.vo.TagsSelectVO;

@Service
public class TagsSelectServiceImpl implements TagsSelectService{
	@Autowired
	TagsSelectDAO tagsSelectDAO;
	@Autowired
	PlatformTransactionManager platformTransactionManager;
	
	@Override
	public JSONArray getOption(String grcode) {
		// TODO Auto-generated method stub
		JSONArray result = tagsSelectDAO.getOption(grcode);
		System.out.println("===========================");
		System.out.println(result.size());
		System.out.println("===========================");
		System.out.println("===========================");
		System.out.println(result.size());
		System.out.println("===========================");
		if(result.size()==0){
			JSONObject option = new JSONObject();
			option.put("code","error");
			option.put("codeName","error");
			result.add(option);
			return result;	
		}else{
			return result;
		}
	}

}
