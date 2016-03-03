package com.myspring.gachon.community.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.myspring.gachon.community.vo.CommunityNormalContentVO;
import com.myspring.gachon.community.vo.CommunityNormalListVO;
import com.myspring.gachon.community.vo.CommunityNormalReplyVO;
import com.myspring.gachon.content.ContentKey;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Repository
public class CommunityDAOImpl implements CommunityDAO{
	
	@Autowired
	private SqlSession sqlSession;
	// end must be point .

	private static final String NS = "mapper.com.myspring.gachon.community.";
	@Autowired
	PlatformTransactionManager platformTransactionManager;
	
	
	@Override
	public JSONArray getBoardList(String divs) {
		// TODO Auto-generated method stub
		CommunityNormalListVO vo = new CommunityNormalListVO();
		vo.setType(divs);
		System.out.println(divs+"ffff3232323323fffffffffffffffffff");
		JSONArray array= JSONArray.fromObject(sqlSession.selectList(NS+"getBoardList", vo));
		System.out.println(array);
		return array;
		
	}

	@Override
	public JSONObject setWriteSubmit(CommunityNormalListVO list,CommunityNormalContentVO content) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(CommunityDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.insert(NS+"writeSubmitList",list)!=1){
				throw new Exception("COMMU_NORMAL_CONTENT 삽입 실패");
			}
			if(sqlSession.insert(NS+"writeSubmitContent",content)!=1){
				throw new Exception("COMMU_NORMAL_CONTENT 삽입 실패");
			}
		}
		catch (Exception ex) {
			platformTransactionManager.rollback(status);
			//ex.printStackTrace();
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return result;			
		}
		platformTransactionManager.commit(status);
		result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		return result;
	}

	@Override
	public JSONObject getBoard(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		sqlSession.update(NS+"setBoardSelect",vo);
		result.put("LIST",JSONObject.fromObject(sqlSession.selectOne(NS+"getSelectList",vo)));
		result.put("CONTENT",JSONObject.fromObject(sqlSession.selectOne(NS+"getSelectContent",vo)));
		
		
		System.out.println(result);
		return result;
	}

	@Override
	public JSONObject setReply(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		if(sqlSession.insert(NS+"setReply",vo)!=1){
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
		}else{
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		}
		return result; 
	}

	@Override
	public JSONArray getReply(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		return JSONArray.fromObject(sqlSession.selectList(NS+"getReply",vo));
	}

	@Override
	public JSONObject setReplyUpdate(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		if(sqlSession.update(NS+"setReplyUpdate",vo)!=1){
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
		}else{
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		}
		return result; 
	}

	@Override
	public JSONObject setReplyDelete(CommunityNormalReplyVO vo) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		if(sqlSession.delete(NS+"setReplyDelete",vo)!=1){
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
		}else{
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		}
		return result; 
	}

	@Override
	public JSONObject setBoardDelete(CommunityNormalListVO vo) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(CommunityDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.delete(NS+"setBoardDelete",vo)!=1){
				throw new Exception("COMMU_NORMAL_CONTENT 삭제 실패");
			}
			if(sqlSession.delete(NS+"setBoardReplyDelete",vo)==-1){
				throw new Exception("COMMU_NORMAL_REPLY 덧글들 삭제 실패");
			}
		}
		catch (Exception ex) {
			platformTransactionManager.rollback(status);
			ex.printStackTrace();
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return result;			
		}
		platformTransactionManager.commit(status);
		result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		
		return result;
		
	}

	@Override
	public JSONObject setBoardUpdateSubmit(CommunityNormalContentVO content,CommunityNormalListVO list) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(CommunityDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.update(NS+"setBoardListUpdateSubmit",list)!=1){
				throw new Exception("COMMU_NORMAL_LIST 수정 실패");
			}
			if(sqlSession.update(NS+"setBoardContentUpdateSubmit",content)!=1){
				throw new Exception("COMMU_NORMAL_CONTENT 수정 실패");
			}
		}
		catch (Exception ex) {
			platformTransactionManager.rollback(status);
			//ex.printStackTrace();
			result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return result;			
		}
		platformTransactionManager.commit(status);
		result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		
		return result;
	}
	
	
	
}
