package com.myspring.gachon.login.dao;

import net.sf.json.JSONObject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.login.vo.LoginVO;

@Repository
public class LoginDAOImpl implements LoginDAO {
	@Autowired
	private SqlSession sqlSession;
	//@Autowired
	//private PlatformTransactionManager transactionManager;
	// end must be point .
	private static final String NS = "mapper.com.myspring.gachon.login.";

	@Override
	public LoginVO getLoginSession(LoginVO data) {
		// TODO Auto-generated method stub
		//DefaultTransactionDefinition defaultTransactionDefinition = new DefaultTransactionDefinition();
		//defaultTransactionDefinition.setName(getClass().getName());
		//defaultTransactionDefinition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		//TransactionStatus status = transactionManager.getTransaction(defaultTransactionDefinition);
		if(0<getCheckMember(data)){
			LoginVO result = sqlSession.selectOne(NS + "getLoginSession",data);
			result.setResult(ContentKey.RESULT_SUCCESS);
			return result;
		}else{
			LoginVO result = new LoginVO();
			result.setResult(ContentKey.RESULT_FAIL);
			return  result;
		}
	}

	@Override
	public Integer getCheckMember(LoginVO data) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NS + "getCheckMember",data);
	}

}


