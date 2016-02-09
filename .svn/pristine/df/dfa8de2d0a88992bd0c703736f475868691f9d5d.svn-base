package com.myspring.gachon.admin.store.dao;

import java.util.List;

import net.sf.json.JSONObject;

import com.myspring.gachon.admin.store.vo.AdminStoreVo;

public interface AdminStoreDao {
	List<AdminStoreVo> adminStoreAllSelect();
	List<AdminStoreVo> adminStoreSelect(int shopNum);
	JSONObject adminShopMstInsert(AdminStoreVo adminStoreVo);
	JSONObject adminShopDetInsert(AdminStoreVo adminStoreVo);
	JSONObject adminShopMstUpdate(AdminStoreVo adminStoreVo);
	JSONObject adminShopDetUpdate(AdminStoreVo adminStoreVo);
	JSONObject adminShopMstDelete(int shopNum);
	JSONObject adminShopDetDelete(int shopNum);
}

