package com.myspring.gachon.admin.code.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.gachon.admin.code.dao.ManagementCodeDao;
import com.myspring.gachon.admin.code.vo.ManagementCodeVO;


@Service
public class ManagementCodeServiceImpl implements ManagementCodeService {

	@Autowired
	private ManagementCodeDao managementcodeDao;
	
	@Override
	public List<ManagementCodeVO> selectCode_MST(){
		return managementcodeDao.selectCode_MST();
	}
	
	@Override
	public JSONObject insertCode_MST(ManagementCodeVO vo) {
		return managementcodeDao.insertCode_MST(vo);
	}
	
	@Override
	public JSONObject updateCode_MST(ManagementCodeVO vo) {
		return managementcodeDao.updateCode_MST(vo);
	}
	
	@Override
	public JSONObject deleteCode_MST(ManagementCodeVO vo) {
		// TODO Auto-generated method stub
		return managementcodeDao.deleteCode_MST(vo);
	}

	@Override
	public List<ManagementCodeVO> selectCode_DET(ManagementCodeVO vo){
		return managementcodeDao.selectCode_DET(vo);
	}
	
	@Override
	public JSONObject insertCode_DET(ManagementCodeVO vo) {
		return managementcodeDao.insertCode_DET(vo);
	}
	
	@Override
	public JSONObject updateCode_DET(ManagementCodeVO vo) {
		return managementcodeDao.updateCode_DET(vo);
	}

	@Override
	public JSONObject deleteCode_DET(ManagementCodeVO vo) {
		return managementcodeDao.deleteCode_DET(vo);
	}
	
	@Override
	public JSONObject deleteCode_MDET(ManagementCodeVO vo) {
		return managementcodeDao.deleteCode_MDET(vo);
	}
}
