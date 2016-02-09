package com.myspring.gachon.admin.menu.service;

import java.util.List; 

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.myspring.gachon.admin.course.dao.AdminCourseDAOImpl;
import com.myspring.gachon.admin.member.dao.AdminMemberDAO;
import com.myspring.gachon.admin.member.service.AdminMemberService;
import com.myspring.gachon.admin.member.vo.AdminMemberVO;
import com.myspring.gachon.admin.menu.dao.AdminMenuDAO;
import com.myspring.gachon.admin.menu.vo.AdminMenuVO;
import com.myspring.gachon.content.ContentKey;


@Service
public class AdminMenuServiceImpl implements AdminMenuService {
	@Autowired
	private AdminMenuDAO adminMenuDAO;
	@Autowired
	PlatformTransactionManager platformTransactionManager;
	
	@Override
	public List<AdminMenuVO> getMenuList() {
		// TODO Auto-generated method stub
		//비지니스 로직을 처리하는곳 . 입력한것을 검증하는곳 . 
		//로비지니스 로직이 두가지가 있는대 해외배송 
		//분기태우기위 함은 컨트롤러
		//
		return adminMenuDAO.getMenuList();
	}
	@Override
	public JSONObject setMenuSubmit(AdminMenuVO vo) {
		// TODO Auto-generated method stub
	
		return adminMenuDAO.setMenuSubmit(vo);
	}
	
	@Override
	public JSONObject getMenuShow(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		
		return adminMenuDAO.getMenuShow(vo);
	}

	@Override
	public JSONObject setMenuModify(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		return adminMenuDAO.setMenuModify(vo);
	}

	

	@Override
	public JSONObject setMenuDelete(AdminMenuVO vo) {
		// TODO Auto-generated method stub
		
		// 트랜잭션처리
		JSONObject result = new JSONObject();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminCourseDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		int count = adminMenuDAO.getMenuChildCount(vo);
		if(vo.getMenuType().equals("G")){
			if(count==1){
				if(adminMenuDAO.setMenuDelete(vo)!=1){
					platformTransactionManager.rollback(status);
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
					return result;
				}else{
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
					platformTransactionManager.commit(status);
					return result;
				}
			}else {
				if(adminMenuDAO.setMenuAllDelete(vo)==0){
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
					platformTransactionManager.rollback(status);
					return result;
				}else{
					adminMenuDAO.setMenuDelete(vo);
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
					platformTransactionManager.commit(status);
					return result;				
				}
			}	
		}else{
			if(count==0){
				if(adminMenuDAO.setMenuDelete(vo)!=1){
					platformTransactionManager.rollback(status);
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
					return result;
				}else{
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
					platformTransactionManager.commit(status);
					return result;
				}
			}else {
				if(adminMenuDAO.setMenuAllDelete(vo)==0){
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
					platformTransactionManager.rollback(status);
					return result;
				}else{
					adminMenuDAO.setMenuDelete(vo);
					result.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
					platformTransactionManager.commit(status);
					return result;				
				}
			}
		}
		
	}
	@Override
	public JSONArray getParentMenuId() {
		// TODO Auto-generated method stub
		return adminMenuDAO.getParentMenuId();
	}
	
	
	
}
