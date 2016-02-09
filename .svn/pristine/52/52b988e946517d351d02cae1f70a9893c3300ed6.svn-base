package com.myspring.gachon.admin.code.controller;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.admin.code.service.ManagementCodeService;
import com.myspring.gachon.admin.code.vo.ManagementCodeVO;
import com.myspring.gachon.outcommunity.controller.EventController;

@Controller
public class ManagementCodeController {
	@Autowired
	private ManagementCodeService ManagementCodeServiceImpl;
	@Autowired
	HttpServletRequest request;
	@Autowired
	PlatformTransactionManager platformTransactionManager;

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	// 페이지 로드
	@RequestMapping(value = "/admin/manage_code", method = RequestMethod.GET)
	public String manage_code() {

		return "/admin/manage_code/ManagementCode";
	}

	/* MST Part */

	// CODE_MST select
	@RequestMapping(value = "/admin/manage_code/grcodeMST.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray grcodeMST() {

		return JSONArray.fromObject(ManagementCodeServiceImpl.selectCode_MST());
	}

	// CODE_MST insert
	@RequestMapping(value = "/admin/manage_code/grcodeMST.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertCode_MST(ManagementCodeVO vo) {
		return ManagementCodeServiceImpl.insertCode_MST(vo);
	}

	// CODE_MST update
	@RequestMapping(value = "/admin/manage_code/grcodeMST.update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCode_MST(ManagementCodeVO vo) {
		return ManagementCodeServiceImpl.updateCode_MST(vo);
	}

	// CODE_MST delete (value값이 .jsp view단에서 ajax URL)
	@RequestMapping(value = "/admin/manage_code/grcodeMST.delete", method = RequestMethod.POST)
	@ResponseBody
	// @Transactional
	public JSONObject deleteCode_MST(ManagementCodeVO vo) {

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(EventController.class.getName()); // 트랜젝션 네임 지정
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); // 어느범위에서 트랜젝션 적용?
		TransactionStatus status = platformTransactionManager.getTransaction(def); // 트랜젝션 아이디 받아서 status로 받음

		// 데이터 손실을 막기 위해, MST테이블 삭제시 DET테이블까지 삭제를 해줘야 하기 때문에 둘다 삭제해줄 때 commit하고
		// DET만 삭제되면 MST를 rollback 해주도록 트랜젝션 처리를 해주는 것이 좋다.
		// 트랜젝션 처리를 안해주면 MST 테이블을 삭제하고나서 DET가 삭제되지 않아, 두가지를 모두 만족시키지못해 에러가 뜰 수 있다.
		// 트랜젝션을 쓰는 이유 : MST와 DET 테이블처럼 두개이상의 테이블을 처리하여 success를 띄워줄 때 사용
		obj = ManagementCodeServiceImpl.deleteCode_MST(vo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = ManagementCodeServiceImpl.deleteCode_MDET(vo);
		}
		// db session에서 두개의 request를 모두 허가한다면, status를 commit
		// service에서 dao를 두번 부르는 등의 트랜젝션 처리를 하는 것이 가장 낫다.

		// 참고)))
		// dao : db access object 디비에 접근하는 오브젝트. mapper에서 name으로 처리하는 곳을 지정해서, sql을 날리는 것을 담당
		// service : 서비스에서 처리하는 business logic 담당. 예) 2015-08-04에서 - 제거해서 던지는 식으로 데이터 변환 처리
		// controller : request와 response를 담당 (게이트웨이와 같은 역할)
		platformTransactionManager.commit(status);

		return obj;
	}

	/* DET Part */
	// CODE_DET select
	@RequestMapping(value = "/admin/manage_code/grcodeDET.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray grcodeDET(ManagementCodeVO vo) {

		return JSONArray.fromObject(ManagementCodeServiceImpl.selectCode_DET(vo));
	}

	// CODE_DET insert
	@RequestMapping(value = "/admin/manage_code/grcodeDET.insert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject insertCode_DET(ManagementCodeVO vo) {
		return ManagementCodeServiceImpl.insertCode_DET(vo);
	}

	// CODE_DET update
	@RequestMapping(value = "/admin/manage_code/grcodeDET.update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCode_DET(ManagementCodeVO vo) {
		return ManagementCodeServiceImpl.updateCode_DET(vo);
	}

	// CODE_DET delete
	@RequestMapping(value = "/admin/manage_code/grcodeDET.delete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject deleteCode_DET(ManagementCodeVO vo) {
		return ManagementCodeServiceImpl.deleteCode_DET(vo);
	}
}
