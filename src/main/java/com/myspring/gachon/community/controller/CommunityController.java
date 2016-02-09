package com.myspring.gachon.community.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.gachon.community.service.CommunityService;
import com.myspring.gachon.community.vo.CommunityNormalContentVO;
import com.myspring.gachon.community.vo.CommunityNormalListVO;
import com.myspring.gachon.community.vo.CommunityNormalReplyVO;
import com.myspring.gachon.content.ContentKey;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class CommunityController {
	private @Autowired HttpServletRequest request;
	
	private @Autowired HttpSession session;
	private @Autowired CommunityService communityService;
	
	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);

	//Default 를 컨트롤러에서 제어하는것이아니라 jsp 페이지에서 session에서 값을 불러서 오는 방식으로.
	@RequestMapping(value = "/community", method = RequestMethod.GET)
	public String communityChange(Model model, Locale locale) throws ServletRequestBindingException {
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		String boardNo = ServletRequestUtils.getStringParameter(request, "boardNo");
		CommunityNormalListVO vo = new CommunityNormalListVO();
		vo.setBoardNo(boardNo);
		
		if(boardNo != null){
			model.addAttribute("board",communityService.getBoard(vo));
			model.addAttribute("boardNo",boardNo);
		}
		model.addAttribute("divs",divs);
		return "/community/Community";
	}
	
	@RequestMapping(value = "/community.select", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray communityJSONContentList(String type){
		return communityService.getBoardList(type);
	}
	@RequestMapping(value = "/community/write", method = RequestMethod.POST)
	public String communityWritePage(Model model,Locale locale) throws ServletRequestBindingException{
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		model.addAttribute("divs",divs);
		logger.info("communityController divs 값 = ["+divs+"]", locale);
		return "/community/Write";
	}
	@RequestMapping(value = "/community/write/submit", method = RequestMethod.POST)
	public String communityWriteSubmit(CommunityNormalListVO list,CommunityNormalContentVO content,Model model,Locale locale) throws ServletRequestBindingException{
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		model.addAttribute("divs",divs);
		//서버단에서 작성글의 검증은 귀찮아서 패스 . 클라에서 대충 검증하고 넘길꺼임.
		JSONObject userData = (JSONObject)request.getSession().getAttribute(ContentKey.LOGIN_MEMBER);
		
		content.setCreateUser(userData.getString("memberName"));
		content.setUpdateUser(userData.getString("memberName"));
		list.setCreateUser(userData.getString("memberName"));
		list.setUpdateUser(userData.getString("memberName"));
		list.setType(divs);
		list.setCreateId(userData.getString("memberId"));
	
		JSONObject result = communityService.setWriteSubmit(list,content);
		if(result.getString(ContentKey.RESULT_MSG).equals(ContentKey.RESULT_SUCCESS)){
			return "/community/Community";
		}else{
			JSONObject data = new JSONObject();
			data.put("LIST", list);
			data.put("CONTENT", content);
			model.addAttribute("DATA",data);
			model.addAttribute(ContentKey.RESULT_MSG,ContentKey.RESULT_FAIL);
			return "/community/Write";
		}
	}
	
	
	@RequestMapping(value = "/community/reply", method = RequestMethod.POST)
	@ResponseBody
	public JSONArray communityReply(CommunityNormalListVO reply) {
		JSONArray result =communityService.getReply(reply); 
		System.out.println(result);
		System.out.println(result);
		System.out.println(result);
		
		return result;
	}
	
	//덧글 삽입
	@RequestMapping(value = "/community/reply/write", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject communityReplySubmit(CommunityNormalReplyVO reply){
		return communityService.setReply(reply);
	}
		
	
	//덧글 수정
	@RequestMapping(value = "/community/reply/update", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject communityReplyUpdate(CommunityNormalReplyVO reply){
		JSONObject userData = (JSONObject)session.getAttribute(ContentKey.LOGIN_MEMBER);
		reply.setUpdateUser(userData.getString("memberName"));
		return communityService.setReplyUpdate(reply);
	}
		
	
	//덧글 삭제
	@RequestMapping(value = "/community/reply/delete", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject communityReplyDelete(CommunityNormalReplyVO reply){
		return communityService.setReplyDelete(reply);
	}
		
	//글 삭제
	@RequestMapping(value = "/community/delete", method = RequestMethod.POST)
	public String communityDelete(Model model, Locale locale) throws ServletRequestBindingException {
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		String boardNo = ServletRequestUtils.getStringParameter(request, "boardNo");
		
		CommunityNormalListVO vo = new CommunityNormalListVO();
		vo.setBoardNo(boardNo);
	
		communityService.setBoardDelete(vo);
		
		model.addAttribute("divs",divs);
		return "redirect:/community";
	}
	
	
	//글 수정
	@RequestMapping(value = "/community/update", method = RequestMethod.POST)
	public String communityUpdate(Model model, Locale locale) throws ServletRequestBindingException {
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		String boardNo = ServletRequestUtils.getStringParameter(request, "boardNo");
		CommunityNormalListVO vo = new CommunityNormalListVO();
		vo.setBoardNo(boardNo);
		model.addAttribute("board",communityService.getBoard(vo));
		model.addAttribute("divs",divs);
		model.addAttribute("boardNo",boardNo);
		
		return "/community/Write";
	}
	//글 수정 완료
	@RequestMapping(value = "/community/update/submit", method = RequestMethod.POST)
	public String communityUpdateSubmit(CommunityNormalContentVO content,CommunityNormalListVO list,Model model, Locale locale) throws ServletRequestBindingException {
		String divs = ServletRequestUtils.getStringParameter(request, "divs");
		String boardNo = ServletRequestUtils.getStringParameter(request, "boardNo");
		
		communityService.setBoardUpdateSubmit(content,list);
		
		model.addAttribute("divs",divs);
		model.addAttribute("boardNo",boardNo);
		
		return "redirect:/community";
	}
	
		
}
