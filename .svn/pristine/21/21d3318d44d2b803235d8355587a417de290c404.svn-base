package com.myspring.gachon.common.code;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CodeController {
	@Autowired
	CodeService codeService;

	@Autowired
	private CodeService CodeServiceImpl;

	@RequestMapping(value = "/common/code/codeDET.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectCodeDet(@RequestParam(value = "grcode", required = true) String grcode) {
		return JSONArray.fromObject(CodeServiceImpl.selectCodeDet(grcode));
	}

	@RequestMapping(value = "/common/code/codeDETWithCode.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray selectCodeDetWithCodeLike(@RequestParam("grcode") String grcode, @RequestParam("code") String code) {
		JSONObject param = new JSONObject();
		param.put("grcode", grcode);
		param.put("code", code);
		return JSONArray.fromObject(CodeServiceImpl.selectCodeDetWithCodeLike(param));

		// Map<String, Object> param2 = new HashMap<String, Object>();
		// param2.put("grcode", grcode);
		// param2.put("code", code);
		// return JSONArray.fromObject(CodeServiceImpl.selectCodeDetWithCodeLike2(param2));
	}
}
