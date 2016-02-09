package com.myspring.gachon.login.service;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.login.dao.LoginDAO;
import com.myspring.gachon.login.vo.LoginVO;

@Service
public class LoginServiceImpl implements LoginService {
	@Autowired
	private LoginDAO loginDao;

	@Override
	public LoginVO getLoginSession(LoginVO data) {
		// TODO Auto-generated method stub
		return loginDao.getLoginSession(data);
	}

	@Override
	public Integer getCheckMember(LoginVO data) {
		// TODO Auto-generated method stub
		return loginDao.getCheckMember(data);
	}		
}
