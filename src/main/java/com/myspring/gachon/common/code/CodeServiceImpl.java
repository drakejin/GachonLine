package com.myspring.gachon.common.code;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CodeServiceImpl implements CodeService {
	@Autowired
	CodeDAO codeDAO;

	@Override
	public List<CodeVO> selectCodeDet(String grcode) {
		return codeDAO.selectCodeDet(grcode);
	}
	
	@Override
	public List<CodeVO> selectCodeDetWithCodeLike(JSONObject param) {
		return codeDAO.selectCodeDetWithCodeLike(param);
	}

	@Override
	public List<CodeVO> selectCodeDetWithCodeLike2(Map<String, Object> param) {
		return codeDAO.selectCodeDetWithCodeLike2(param);
	}

}
