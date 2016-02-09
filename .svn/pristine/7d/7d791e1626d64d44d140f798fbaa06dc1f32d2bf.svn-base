package com.myspring.gachon.admin.store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.sf.json.JSONObject;

import com.myspring.gachon.admin.store.dao.AdminStoreDao;
import com.myspring.gachon.admin.store.vo.AdminStoreVo;

@Service
public class AdminStoreServiceImpl implements AdminStoreService {
	@Autowired
	private AdminStoreDao adminStoreDaoImpl;
	
	@Override
	public List<AdminStoreVo> adminStoreAllSelect() {
		return adminStoreDaoImpl.adminStoreAllSelect();
	}
	
	@Override
	public List<AdminStoreVo> adminStoreSelect(int shopNum) {
		return adminStoreDaoImpl.adminStoreSelect(shopNum);
	}
	
	@Override
	public JSONObject adminShopMstInsert(AdminStoreVo adminStoreVo) {
		return adminStoreDaoImpl.adminShopMstInsert(adminStoreVo);
	}
	 
	@Override
	public JSONObject adminShopDetInsert(AdminStoreVo adminStoreVo) {
		return adminStoreDaoImpl.adminShopDetInsert(adminStoreVo);
	}
	
	@Override
	public JSONObject adminShopMstUpdate(AdminStoreVo adminStoreVo) {
		return adminStoreDaoImpl.adminShopMstUpdate(adminStoreVo);
	}
	
	@Override
	public JSONObject adminShopDetUpdate(AdminStoreVo adminStoreVo) {
		return adminStoreDaoImpl.adminShopDetUpdate(adminStoreVo);
	}
	
	@Override
	public JSONObject adminShopMstDelete(int shopNum) {
		// TODO Auto-generated method stub
		return adminStoreDaoImpl.adminShopMstDelete(shopNum);
	}
	
	@Override
	public JSONObject adminShopDetDelete(int shopNum) {
		return adminStoreDaoImpl.adminShopDetDelete(shopNum);
		
	}

}
