package com.myspring.gachon.outcommunity.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.myspring.gachon.outcommunity.service.AlbaService;
import com.myspring.gachon.outcommunity.vo.AlbaVo;
import com.myspring.gachon.outcommunity.vo.EventVo;

@Controller
public class AlbaController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	private AlbaService albaServiceImpl;
	@Autowired
	PlatformTransactionManager platformTransactionManager;

	/* 아르바이트 공고 게시판으로 이동 */
	@RequestMapping(value = "/outCommunity/alba", method = RequestMethod.GET)
	public String outCommunityAlba() {
		return "/outCommunity/alba/outCommunityAlba";
	}

	/* 아르바이트 공고 리스트 확인 */
	@RequestMapping(value = "/outCommunity/alba/albaList.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray albaAllSelect() {
		return JSONArray.fromObject(albaServiceImpl.albaAllSelect());
	}

	/* 아르바이트 공고 글쓰기 */
	@RequestMapping(value = "/outCommunity/alba/albaInsert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject albaInsert(MultipartHttpServletRequest mRequest, 
			@RequestParam("corPicPath1") MultipartFile multipartFile1,
			@RequestParam("corPicPath2") MultipartFile multipartFile2,
			@RequestParam("corPicPath3") MultipartFile multipartFile3
			) {
		String userId=mRequest.getParameter("crtUser");
		AlbaVo albaVo = new AlbaVo();

		albaVo.setBoardTitle(mRequest.getParameter("boardTitle"));
		albaVo.setCorporate(mRequest.getParameter("corporate"));
		albaVo.setCloseDate(mRequest.getParameter("closeDate"));
		albaVo.setRecuritNum(Integer.parseInt(mRequest.getParameter("recuritNum")));
		albaVo.setAlbaAddrApi1(mRequest.getParameter("albaAddrApi1"));
		albaVo.setAlbaAddrApi2(mRequest.getParameter("albaAddrApi2"));
		albaVo.setGender(mRequest.getParameter("gender"));
		albaVo.setAge(mRequest.getParameter("age"));
		albaVo.setAcademicBg(mRequest.getParameter("academicBg"));
		albaVo.setEmailAddr(mRequest.getParameter("emailAddr"));
		albaVo.setWorkForm(mRequest.getParameter("workForm"));
		albaVo.setWorkType(mRequest.getParameter("workType"));
		albaVo.setWorkDay(mRequest.getParameter("workDay"));
		albaVo.setWorkTime(mRequest.getParameter("workTime"));
		albaVo.setPay(mRequest.getParameter("pay"));
		albaVo.setEmpWalfare(mRequest.getParameter("empWalfare"));
		albaVo.setWorkArea(mRequest.getParameter("workArea"));
		albaVo.setCrtUser(mRequest.getParameter("crtUser"));
		albaVo.setUpdtUser(mRequest.getParameter("updtUser"));

		JSONObject seq = albaServiceImpl.selectalba_list_seq();
		int boardNum = seq.getInt("ALBA_LIST_SEQ");
		albaVo.setAlbaBoardNum(seq.getInt("ALBA_LIST_SEQ"));
		
		String path = mRequest.getSession().getServletContext().getRealPath("/resources/image/alba/");

		String fileName1 = boardNum+userId+"1";
		String fileName2 = boardNum+userId+"2";
		String fileName3 = boardNum+userId+"3";
		int pos = multipartFile1.getOriginalFilename().lastIndexOf(".");
		String ext = multipartFile1.getOriginalFilename().substring(pos+1);
		
		try {
			multipartFile1.transferTo(new File(path+"/"+fileName1+"."+ext));
			multipartFile2.transferTo(new File(path+"/"+fileName2+"."+ext));
			multipartFile3.transferTo(new File(path+"/"+fileName3+"."+ext));
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		albaVo.setCorPicPath1(fileName1+"."+ext);
		albaVo.setCorPicPath2(fileName2+"."+ext);
		albaVo.setCorPicPath3(fileName3+"."+ext);
		

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AlbaController.class.getName()); // 트랜잭션의 이름 지정
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED); // 트랜잭션이 지정될 범위
		TransactionStatus status = platformTransactionManager.getTransaction(def); // 트랜잭션의 아이디를 얻어서 트랜잭션의 상태를 얻음

		obj = albaServiceImpl.albaMstInsert(albaVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = albaServiceImpl.albaDetInsert(albaVo);
			obj = albaServiceImpl.albaImgInsert(albaVo);
		}

		platformTransactionManager.commit(status);

		return obj;

		/*
		 * @Transactional : 트랜잭션 처리의 다른 방법 중 하나로, 메소드 단위로 트랜잭션을 실행해 주는 방식 하지만 1번 방식과 달리 유동적으로 사용하기에는 불편하기 때문에 이 방법보다는 1번 방식을 주로 사용
		 */

		/*
		 * dao : 데이터베이스에 접근하는 오브젝트(sqlsession을 생성하여 어떤 sql을 가져올지 명시하여 사용, parameterType) service : 로직=비지니스 로직을 담당(서버사이드에서 처리해야 할 로직을 처리해야 하는 로직) controller:
		 * gateway역할
		 */
	}

	/* 데이터 로드해오기 */
	@RequestMapping(value = "/outcommunity/alba/updateLoadData", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray loadData(int boardNum) {
		return JSONArray.fromObject(albaServiceImpl.loadData(boardNum));
	}

	/* 등록된 아르바이트 수정하기 */
	@RequestMapping(value = "/outcommunity/alba/updateAlba", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject albaUpdate(AlbaVo albaVo, int boardNum) {
		albaVo.setAlbaBoardNum(ServletRequestUtils.getIntParameter(request, "boardNum", 0));

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AlbaController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = albaServiceImpl.albaMstUpdate(albaVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = albaServiceImpl.albaDetUpdate(albaVo);
			obj = albaServiceImpl.albaImgUpdate(albaVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}
	
	/*조회수*/
	@RequestMapping(value = "/outcommunity/alba/updateHit", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject albaMstUpdateHit(int boardNum, AlbaVo albaVo) {
		int albaBoardNum = Integer.parseInt(request.getParameter("boardNum"));
		albaVo.setAlbaBoardNum(albaBoardNum);

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AlbaController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = albaServiceImpl.albaMstUpdateHit(albaVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = albaServiceImpl.albaMstUpdateHit(albaVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}
	
	/*추천수*/
	@RequestMapping(value = "/outcommunity/alba/updateLove", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject albaUpdateLove(AlbaVo albaVo, int boardNum) {
		int albaBoardNum = Integer.parseInt(request.getParameter("boardNum"));
		albaVo.setAlbaBoardNum(albaBoardNum);

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AlbaController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = albaServiceImpl.albaMstUpdateLove(albaVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = albaServiceImpl.albaMstUpdateLove(albaVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}
	

	/* 아르바이트 게시글 삭제하기 */
	@RequestMapping(value = "/outcommunity/alba/deleteAlba", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject albaDelete(int boardNum) {
		int albaBoardNum = Integer.parseInt(request.getParameter("boardNum"));

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AlbaController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = albaServiceImpl.albaMstDelete(albaBoardNum);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = albaServiceImpl.albaDetDelete(albaBoardNum);
			obj = albaServiceImpl.albaImgDelete(albaBoardNum);
		}

		platformTransactionManager.commit(status);

		return obj;
	}


}
