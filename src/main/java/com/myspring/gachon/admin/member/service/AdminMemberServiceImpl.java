package com.myspring.gachon.admin.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.myspring.gachon.admin.member.dao.AdminMemberDAO;
import com.myspring.gachon.admin.member.vo.AdminMemberVO;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.login.vo.LoginVO;


@Service
public class AdminMemberServiceImpl implements AdminMemberService {
	@Autowired
	private AdminMemberDAO adminMemberDAO;
	
	@Override
	public List<AdminMemberVO> getMemberList(AdminMemberVO vo) {
		// TODO Auto-generated method stub
		//비지니스 로직을 처리하는곳 . 입력한것을 검증하는곳 . 
		//로비지니스 로직이 두가지가 있는대 해외배송 
		//분기태우기위 함은 컨트롤러
		//
		return adminMemberDAO.getMemberList(vo);
	}

	@Override
	public List<AdminMemberVO> getFriendInfo(AdminMemberVO vo) {
	
		return adminMemberDAO.getFriendInfo(vo);
	}
	
	
	@Override
	public AdminMemberVO getMemberShow(AdminMemberVO vo) {
		// TODO Auto-generated method stub
		
		return adminMemberDAO.getMemberShow(vo);
	}


	@Override
	public JSONObject setMemberAdd(AdminMemberVO vo) {
		// TODO Auto-generated method stub
		return adminMemberDAO.setMemberAdd(vo);
	}


	@Override
	public JSONObject setMemberModify(AdminMemberVO vo) {
		// TODO Auto-generated method stub
		return adminMemberDAO.setMemberModify(vo);
	}
	
	@Override
	public JSONObject setMemberDelete(AdminMemberVO vo) {
		// TODO Auto-generated method stub
		return adminMemberDAO.setMemberDelete(vo);
	}

	
	
}
