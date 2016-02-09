package com.myspring.gachon.admin.curriculum.dao;

import java.util.List;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myspring.common.exception.GachonDaoException;
import com.myspring.gachon.admin.curriculum.vo.ManagementCurriculumVO;

import net.sf.json.JSONObject;

@Repository
public class ManagementCurriculumDaoImpl implements ManagementCurriculumDao {

	@Autowired
	private SqlSession sqlSession;
	// end must be point .

	private static final String NS = "mapper.com.myspring.gachon.admin.curriculum.";
	
	@Override
	public List<ManagementCurriculumVO> selectCourseCurriculum_MST(ManagementCurriculumVO vo) {
		
		System.out.println("*****Dao까지 넘어 온 major 값*******"+vo.getMajor()+"********");
		System.out.println("*****Dao까지 넘어 온 year 값*******"+vo.getYear()+"********");
		System.out.println("*****Dao까지 넘어 온 schoolYear 값*******"+vo.getSchoolYear()+"********");
		
		return sqlSession.selectList(NS + "selectCourseCurriculum_MST", vo);
	}

// courseNum + courseName 을 같이 한 칼럼에 쓰는 구문 : JSONObject 활용
//	@Override
//	public JSONObject selectCourseCurriculum_MST(ManagementCurriculumVO vo) {
//		JSONObject jsonObject = new JSONObject();
//		JSONArray data = JSONArray.fromObject(sqlSession.selectList(NS + "selectCourseCurriculum_MST"));
//		for (int i = 0; i < data.size(); i++) {
//			JSONObject temp = new JSONObject();
//			temp = data.getJSONObject(i);
//			temp.put("courseNum", "[" + temp.get("courseNum") + "]\t" + temp.get("courseName"));
//			data.set(i, temp);
//		}

//		jsonObject.put("RESULT_CODE", data);
//		return jsonObject;
//	}

	@Override
	public JSONObject insertCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertCourseCurriculum_MST", vo);
	}

	@Override
	public JSONObject updateCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.UPDATE, NS + "updateCourseCurriculum_MST", vo);
	}

	@Override
	public JSONObject deleteCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteCourseCurriculum_MST", vo);
	}
}