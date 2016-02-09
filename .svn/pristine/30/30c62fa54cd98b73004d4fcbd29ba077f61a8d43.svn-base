package com.myspring.gachon.admin.curriculum.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.admin.curriculum.dao.ManagementCurriculumDao;
import com.myspring.gachon.admin.curriculum.vo.ManagementCurriculumVO;

@Service
public class ManagementCurriculumServiceImpl implements ManagementCurriculumService {

	@Autowired
	private ManagementCurriculumDao managementcurriculumDao;
		
	@Override
	public List<ManagementCurriculumVO> selectCourseCurriculum_MST(ManagementCurriculumVO vo) {
		
		System.out.println("*****Service까지 넘어 온 major 값*******"+vo.getMajor()+"********");
		System.out.println("*****Service까지 넘어 온 year 값*******"+vo.getYear()+"********");
		System.out.println("*****Service까지 넘어 온 schoolYear 값*******"+vo.getSchoolYear()+"********");
		
		return managementcurriculumDao.selectCourseCurriculum_MST(vo);
	}
	
//	@Override
//	public JSONObject selectCourseCurriculum_MST(ManagementCurriculumVO vo) {
//		return managementcurriculumDao.selectCourseCurriculum_MST(vo);
//	}
	
	@Override
	public JSONObject insertCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return managementcurriculumDao.insertCourseCurriculum_MST(vo);
	}
	
	@Override
	public JSONObject updateCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return managementcurriculumDao.updateCourseCurriculum_MST(vo);
	}

	@Override
	public JSONObject deleteCourseCurriculum_MST(ManagementCurriculumVO vo) {
		return managementcurriculumDao.deleteCourseCurriculum_MST(vo);
	}
}
