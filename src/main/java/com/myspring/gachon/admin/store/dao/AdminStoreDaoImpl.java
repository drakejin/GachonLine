package com.myspring.gachon.admin.store.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.sf.json.JSONObject;

import com.myspring.gachon.admin.store.vo.AdminStoreVo;

@Repository
public class AdminStoreDaoImpl implements AdminStoreDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private static final String NS = "mapper.com.myspring.gachon.admin.store.";
	
	@Override
	public List<AdminStoreVo> adminStoreAllSelect() {
		return sqlSession.selectList(NS+"admin_shopAllSelect");
	}
	
	@Override
	public List<AdminStoreVo> adminStoreSelect(int shopNum) {
		return sqlSession.selectList(NS+"admin_shopSelect", shopNum);
	}
	
	@Override
	public JSONObject adminShopMstInsert(AdminStoreVo adminStoreVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"admin_shop_mstInsert", adminStoreVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "등록되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject adminShopDetInsert(AdminStoreVo adminStoreVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.insert(NS+"admin_shop_detInsert", adminStoreVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "등록되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject adminShopMstUpdate(AdminStoreVo adminStoreVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"admin_shop_mstUpdate", adminStoreVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "수정되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject adminShopDetUpdate(AdminStoreVo adminStoreVo) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.update(NS+"admin_shop_detUpdate", adminStoreVo));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "수정되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject adminShopMstDelete(int shopNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"admin_shop_mstDelete", shopNum));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "삭제되었습니다.");
		}
		return result;
	}
	
	@Override
	public JSONObject adminShopDetDelete(int shopNum) {
		JSONObject result = new JSONObject();
		result.put("RESULT_CODE", sqlSession.delete(NS+"admin_shop_detDelete", shopNum));
		if(result.getInt("RESULT_CODE")>0){
			result.put("RESULT_MSG", "삭제되었습니다.");
		}
		return result;
	}

}
