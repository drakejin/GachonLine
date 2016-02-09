package com.myspring.common.exception;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;

import com.myspring.gachon.content.ContentKey;

import net.sf.json.JSONObject;

public class GachonDaoException {
	public static JSONObject goQuery(SqlSession sqlSession, SqlCommandType sqlCommandType, String sqlId, Object paramObj) {
		JSONObject jsonObject = new JSONObject();

		try {
			int result = 0;
			if (sqlCommandType == SqlCommandType.INSERT) {
				result = sqlSession.insert(sqlId, paramObj);
			} else if (sqlCommandType == SqlCommandType.UPDATE) {
				result = sqlSession.update(sqlId, paramObj);
			} else if (sqlCommandType == SqlCommandType.DELETE) {
				result = sqlSession.delete(sqlId, paramObj);
			}
			jsonObject.put(ContentKey.RESULT_CODE, result);
			jsonObject.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			jsonObject.put(ContentKey.RESULT_CODE, -100);
			jsonObject.put(ContentKey.RESULT_MSG, e.getMessage());
		}

		return jsonObject;
	}
}
