package com.myspring.gachon.tags.select.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.myspring.gachon.tags.select.vo.TagsSelectVO;

import net.sf.json.JSONArray;

@Repository
public class TagsSelectDAOImpl implements TagsSelectDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	private static final String NS = "mapper.com.myspring.gachon.tags.select.";
	
	@Override
	public JSONArray getOption(String grcode) {
		// TODO Auto-generated method stub
		JSONArray result = JSONArray.fromObject(sqlSession.selectList(NS+"getOption",grcode));
		System.out.println("===========================");
		System.out.println(result.size());
		System.out.println("===========================");
		System.out.println("===========================");
		System.out.println(result.size());
		System.out.println("===========================");
		return result;
	}

}
