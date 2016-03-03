package com.myspring.gachon.admin.store.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.myspring.gachon.admin.store.service.AdminStoreService;
import com.myspring.gachon.admin.store.vo.AdminStoreVo;
import com.myspring.gachon.content.ContentKey;
import com.myspring.gachon.outcommunity.controller.AlbaController;
import com.myspring.gachon.outcommunity.controller.EventController;
import com.myspring.gachon.outcommunity.vo.AlbaVo;
import com.myspring.gachon.outcommunity.vo.EventVo;

@Controller
public class AdminStoreController {
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	AdminStoreService adminStoreServiceImpl;
	
	@Autowired
	PlatformTransactionManager platformTransactionManager;
	
	/* 상점관리 페이지로 이동 */
	@RequestMapping(value = "/admin/manage_store", method = RequestMethod.GET)
	public String adminStore() {
		return "/admin/manage_store/ManagementStore";
	}
	
	/* 상점관리 전체 리스트 확인 */
	@RequestMapping(value = "/admin/manage_store/adminStoreList.json", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray storeAllSelect() {
		return JSONArray.fromObject(adminStoreServiceImpl.adminStoreAllSelect());
	}

	/* 상점관리 정보 확인 */
	@RequestMapping(value = "/admin/manage_store/adminStore", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray storeSelect(int shopNum) {
		shopNum = Integer.parseInt(request.getParameter("shopNum"));
		return JSONArray.fromObject(adminStoreServiceImpl.adminStoreSelect(shopNum));
	}
	
	/* 상점 등록하기(글쓰기) */
	@RequestMapping(value = "/admin/manage_store/adminStoreInsert", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject storeInsert(HttpSession session, MultipartHttpServletRequest mRequest, 
			@RequestParam("shopTitlePicPath") MultipartFile multipartFile1){
		
		AdminStoreVo adminStoreVo = new AdminStoreVo();

		adminStoreVo.setShopNum(Integer.parseInt(mRequest.getParameter("shopNum")));
		adminStoreVo.setShopName(mRequest.getParameter("shopName"));
		adminStoreVo.setShopTel(mRequest.getParameter("shopTel"));
		adminStoreVo.setShopAddr(mRequest.getParameter("shopAddr"));
		adminStoreVo.setShopAddrApi1(mRequest.getParameter("shopAddrApi1"));
		adminStoreVo.setShopAddrApi2(mRequest.getParameter("shopAddrApi2"));
		adminStoreVo.setShopHp(mRequest.getParameter("shopHp"));
		adminStoreVo.setShopDetailDesc(mRequest.getParameter("shopDetailDesc"));
		adminStoreVo.setCrtUser(mRequest.getParameter("crtUser"));
		adminStoreVo.setUpdtUser(mRequest.getParameter("updtUser"));
	
		int shopNum = Integer.parseInt(mRequest.getParameter("shopNum"));
		String shopName = mRequest.getParameter("shopName");
		
		String path = mRequest.getSession().getServletContext().getRealPath("/resources/image/shop/");
		
		String fileName = shopNum+"^"+shopName;

		int pos = multipartFile1.getOriginalFilename().lastIndexOf(".");
		String ext = multipartFile1.getOriginalFilename().substring(pos+1);
		
		try {
			multipartFile1.transferTo(new File(path+"/"+fileName+"."+ext));
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		adminStoreVo.setShopTitlePicPath(fileName+"."+ext);

		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminStoreController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = adminStoreServiceImpl.adminShopMstInsert(adminStoreVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = adminStoreServiceImpl.adminShopDetInsert(adminStoreVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}

	
	/* 상점 수정하기 */
	@RequestMapping(value = "/admin/manage_store/adminStoreUpdate", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject storeUpdate(HttpSession session, AdminStoreVo adminStoreVo, MultipartHttpServletRequest mRequest,  
			@RequestParam("shopTitlePicPath") MultipartFile multipartFile2) {
	
		adminStoreVo.setShopNum(Integer.parseInt(mRequest.getParameter("shopNum")));
		

		int updateShopNum = Integer.parseInt(mRequest.getParameter("shopNum"));
		String updateShopName = mRequest.getParameter("shopName");
			
		String path = mRequest.getSession().getServletContext().getRealPath("/resources/image/shop/");
		String fileName = updateShopName;
		int pos = multipartFile2.getOriginalFilename().lastIndexOf(".");
		String ext = multipartFile2.getOriginalFilename().substring(pos+1);
		
		try {
			multipartFile2.transferTo(new File(path+"/"+fileName+"."+ext));
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		adminStoreVo.setShopTitlePicPath(fileName+"."+ext);
		
		
		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminStoreController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = adminStoreServiceImpl.adminShopMstUpdate(adminStoreVo);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = adminStoreServiceImpl.adminShopDetUpdate(adminStoreVo);
		}

		platformTransactionManager.commit(status);

		return obj;
	}
	
	@RequestMapping(value="/admin/manage_store/adminStoreDelete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject storeDelete(int shopNum){
		AdminStoreVo adminStoreVo = new AdminStoreVo();
		adminStoreVo.setShopNum(ServletRequestUtils.getIntParameter(request, "shopNum", 0));
		
		JSONObject obj = new JSONObject();

		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName(AdminStoreController.class.getName());
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = platformTransactionManager.getTransaction(def);

		obj = adminStoreServiceImpl.adminShopMstDelete(shopNum);
		if (obj.getInt("RESULT_CODE") > 0) {
			obj = adminStoreServiceImpl.adminShopDetDelete(shopNum);
		}

		platformTransactionManager.commit(status);

		return obj;
	}

}
