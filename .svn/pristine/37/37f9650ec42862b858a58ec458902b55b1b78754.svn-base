package com.myspring.gachon.course.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.myspring.gachon.admin.course.vo.AdminCourseAllVO;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.course.dao.ChangeCourseDao;
import com.myspring.gachon.course.vo.ChangeCourseVO;

@Service
public class ChangeCourseServiceImpl implements ChangeCourseService {

	@Autowired
	private ChangeCourseDao ChangeCourseDao;
	@Autowired
	PlatformTransactionManager platformTransactionManager;

	// select table_mst
	@Override
	public List<ChangeCourseVO> selectChangeCourseList(ChangeCourseVO vo) {

		return ChangeCourseDao.selectChangeCourseList(vo);
	}

	// select writeForm_mst
	@Override
	public List<ChangeCourseVO> selectWriteform(AdminCourseAllVO vo) {

		return ChangeCourseDao.selectWriteform(vo);
	}

	// insert writeForm_mst
	@Override
	public JSONObject insertWriteform(ChangeCourseVO vo) {
		return ChangeCourseDao.insertWriteform(vo);
	}

	// update course
	@Override
	public JSONObject updateCourse(AdminCourseAllVO vo) {
		//
		// System.out.println("*****"+ vo.getMemberId() +"********");
		// System.out.println("*****"+ vo.getChangeSubject() +"********");
		// System.out.println("*****"+ vo.getWriterMemberId() +"********");
		//
		JSONObject obj;
		if (ChangeCourseDao.selectValidationCourse(vo) > 0) { // 해당 과목을 가지고 있을 때
			// 트랜잭션처리
			DefaultTransactionDefinition def = new DefaultTransactionDefinition();
			def.setName(ChangeCourseDao.class.getName());
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
			TransactionStatus status = platformTransactionManager.getTransaction(def);

			AdminCourseAllVO params = new AdminCourseAllVO();
			params.setMemberId(vo.getMemberId());
			params.setGiveMemberId(vo.getGiveMemberId());
			params.setCourseNum(vo.getGiveSubject());
			params.setGiveWriterMemberId(vo.getGiveWriterMemberId());
			// updateCourse의 give Parameter
			obj = ChangeCourseDao.updateCourse(params);

			// updateCourse의 take Parameter
			if (obj.getInt(ContentKey.RESULT_CODE) >= 0) {
				params.setGiveMemberId(vo.getTakeMemberId());
				params.setCourseNum(vo.getTakeSubject());
				params.setGiveWriterMemberId(vo.getTakeWriterMemberId());
				obj = ChangeCourseDao.updateCourse(params);
			}

			if (obj.getInt(ContentKey.RESULT_CODE) >= 0) {
				obj = ChangeCourseDao.updateCHANGE_COURSE_MST(vo);
			}
			platformTransactionManager.commit(status);

			obj.put(ContentKey.RESULT_MSG, (int) obj.get(ContentKey.RESULT_CODE) >= 0 ? ContentKey.RESULT_SUCCESS : ContentKey.RESULT_FAIL);

		} else { // 해당 과목을 갖고 있지 않을 때
			obj = new JSONObject();
			obj.put(ContentKey.RESULT_CODE, -404);
			obj.put(ContentKey.RESULT_MSG, "해당과목을 가지고 있지않아 교환할 수 없습니다");
		}

		return obj;
	}
}
