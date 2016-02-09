package com.myspring.gachon.admin.course.dao;

import java.util.Iterator;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.myspring.common.exception.GachonDaoException;
import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.admin.course.vo.AdminCourseApplicantVO;
import com.myspring.gachon.admin.course.vo.AdminCourseDetailVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMajorMapVO;
import com.myspring.gachon.admin.course.vo.AdminCourseMasterVO;
import com.myspring.gachon.content.ContentKey;


@Repository
public class AdminCourseDAOImpl implements AdminCourseDAO{

	private static final String NS = "mapper.com.myspring.gachon.admin.course.";
	@Autowired
	private SqlSession sqlSession;
	// end must be point .
	
	@Autowired
	PlatformTransactionManager platformTransactionManager;
	
	
	@Override
	public JSONObject getDrawCode() {
		// TODO Auto-generated method stub
		JSONObject data = new JSONObject();
		JSONArray grcode = JSONArray.fromObject(sqlSession.selectList(NS+"getDrawCode"));
		
		JSONObject pManageCourse = new JSONObject();
		JSONArray college = new JSONArray();
		JSONArray collegeStatus = new JSONArray();
		JSONArray completeDivision = new JSONArray();
		JSONArray completeTerm = new JSONArray();
		JSONArray cyberYN = new JSONArray();
		JSONArray department = new JSONArray();
		JSONArray major = new JSONArray();
		JSONArray semester = new JSONArray();
		JSONArray year = new JSONArray();
		JSONArray useYN = new JSONArray();
		JSONArray area = new JSONArray();
		
		
		
		for(int i=0;i<grcode.size();i++){
			JSONObject row = grcode.getJSONObject(i);
			//화면에 뿌릴꺼니까.. Object로 만든다.
			if(row.get("GRCODE").equals("P_MANAGE_COURSE")){
				row.remove("GRCODE");
				Iterator<?> iterator =row.keys();
				String key = (String) iterator.next();
				String key2 = (String) iterator.next();
				pManageCourse.put(row.get(key),row.get(key2));
				
			}else if(row.get("GRCODE").equals("COLLEGE")){
				row.remove("GRCODE");
				college.add(row);
			}else if(row.get("GRCODE").equals("COLLEGE_STATUS")){
				row.remove("GRCODE");
				collegeStatus.add(row);
			}else if(row.get("GRCODE").equals("COMPLETE_DIVISION")){
				row.remove("GRCODE");
				completeDivision.add(row);
			}else if(row.get("GRCODE").equals("COMPLETE_TERM")){
				row.remove("GRCODE");
				completeTerm.add(row);
			}else if(row.get("GRCODE").equals("CYBER_YN")){
				row.remove("GRCODE");
				cyberYN.add(row);
			}else if(row.get("GRCODE").equals("DEPARTMENT")){
				row.remove("GRCODE");
				department.add(row);
			}else if(row.get("GRCODE").equals("MAJOR")){
				row.remove("GRCODE");
				major.add(row);
			}else if(row.get("GRCODE").equals("SEMESTER")){
				row.remove("GRCODE");
				semester.add(row);
			}else if(row.get("GRCODE").equals("YEAR")){
				row.remove("GRCODE");
				year.add(row);
			}else if(row.get("GRCODE").equals("USE_YN")){
				row.remove("GRCODE");
				useYN.add(row);
			}else if(row.get("GRCODE").equals("AREA")){
				row.remove("GRCODE");
				area.add(row);
			}
		}
		data.put("P_MANAGE_COURSE",pManageCourse);
		data.put("COLLEGE", college);
		data.put("COLLEGE_STATUS", collegeStatus);
		data.put("COMPLETE_DIVISION", completeDivision);
		data.put("COMPLETE_TERM", completeTerm);
		data.put("CYBER_YN", cyberYN);
		data.put("DEPARTMENT",department);
		data.put("MAJOR", major);
		data.put("SEMESTER", semester);
		data.put("YEAR", year);
		data.put("USE_YN", useYN);
		data.put("AREA", area);
		
		return data;
	}

	@Override
	public JSONObject setCourseSubmit(AdminCourseDetailVO detVO, 
			AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		System.err.println(detVO);
		System.err.println(mstVO);
		System.err.println(mapVO);
		
		// 트랜잭션처리
		JSONObject obj = new JSONObject();
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminCourseDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.insert(NS+"insertCourseMaster",mstVO)!=1){
				throw new Exception("mstVO insert 실패");
			}
			if(sqlSession.insert(NS+"insertCourseDetail",detVO)!=1){
				throw new Exception("detVO insert 실패");
			}
			if(sqlSession.insert(NS+"insertCourseMajorMap",mapVO)!=1){
				throw new Exception("mapVO insert 실패");	
			}
		}
		catch (Exception ex) {
			platformTransactionManager.rollback(status);
			ex.printStackTrace();
			obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return obj;			
		}
		platformTransactionManager.commit(status);
		obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		return obj;
	}

	@Override
	public JSONArray getCourseList(AdminCourseAllVO vo) {
		return JSONArray.fromObject(sqlSession.selectList(NS+"getCourseList", vo));
	}

	@Override
	public JSONObject getCourseShow(AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		JSONObject data = JSONObject.fromObject((AdminCourseAllVO)sqlSession.selectOne(NS+"getCourseShow",mapVO));
		if(mapVO.getCourseNum().equals(data.get("courseNum"))){
			data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_SUCCESS);
		}else{
			data.put(ContentKey.RESULT_MSG,ContentKey.RESULT_FAIL);
		}
		return data;
	}

	@Override
	public JSONObject setCourseModify(AdminCourseDetailVO detVO,
		AdminCourseMasterVO mstVO, AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		// 트랜잭션처리
		JSONObject obj = new JSONObject();
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminCourseDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.update(NS+"updateCourseMaster",mstVO)!=1){
				throw new Exception("mstVO update 실패");
			}
			if(sqlSession.update(NS+"updateCourseDetail",detVO)!=1){
				throw new Exception("detVO update 실패");
			}
			if(sqlSession.update(NS+"updateCourseMajorMap",mapVO)!=1){
				throw new Exception("mapVO update 실패");	
			}
		}catch(Exception e){
			platformTransactionManager.rollback(status);
			e.printStackTrace();
			obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return obj;	
		}
		platformTransactionManager.commit(status);
		obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		return obj;
	}

	@Override
	public JSONObject setCourseDelete(AdminCourseMajorMapVO mapVO) {
		// TODO Auto-generated method stub
		JSONObject obj = new JSONObject();
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminCourseDAOImpl.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);
		try {
			if(sqlSession.delete(NS+"deleteCourseMaster",mapVO)!=1){
				throw new Exception("mstVO delete 실패");
			}
			if(sqlSession.delete(NS+"deleteCourseDetail",mapVO)!=1){
				throw new Exception("detVO delete 실패");
			}
			if(sqlSession.delete(NS+"deleteCourseMajorMap",mapVO)!=1){
				throw new Exception("mapVO delete 실패");	
			}
		}catch(Exception e){
			platformTransactionManager.rollback(status);
			e.printStackTrace();
			obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_FAIL);
			return obj;	
		}
		platformTransactionManager.commit(status);
		obj.put(ContentKey.RESULT_MSG, ContentKey.RESULT_SUCCESS);
		return obj;
		
	}

	// 신청자 현황보기
	@Override
	public List<AdminCourseApplicantVO> selectApplicantState(AdminCourseApplicantVO vo) {
		
		System.out.println("*****Dao까지 넘어 온 courseNum 값*******"+vo.getCourseNum()+"********");
		
		return sqlSession.selectList(NS + "selectApplicantState", vo);
	}

	@Override
	public JSONObject insertApplicantState(AdminCourseApplicantVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertApplicantState", vo);
	}
	
	
	@Override
	public JSONObject deleteApplicantState(AdminCourseApplicantVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteApplicantState", vo);
	}
	
	// 가상시간표 보기
	@Override
	public List<AdminCourseApplicantVO> selectTemporarySchedule(AdminCourseAllVO vo) {
				
		return sqlSession.selectList(NS + "selectTemporarySchedule", vo);
	}

	@Override
	public JSONObject insertTemporarySchedule(AdminCourseAllVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.INSERT, NS + "insertTemporarySchedule", vo);
	}
	
	@Override
	public JSONObject deleteTemporarySchedule(AdminCourseAllVO vo) {
		return GachonDaoException.goQuery(sqlSession, SqlCommandType.DELETE, NS + "deleteTemporarySchedule", vo);
	}
	
}
