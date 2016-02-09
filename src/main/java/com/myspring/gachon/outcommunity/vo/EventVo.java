package com.myspring.gachon.outcommunity.vo;

import org.apache.ibatis.type.Alias;

@Alias("EventVo")
public class EventVo {
	private int eventBoardNum;
	private String boardTitle;
	private int hit;
	private int love;
	private String crtUser;
	private String crtdt;
	private String updtUser;
	private String updtdt;
	private String openDate; //이벤트 일시
	private String eventAddr; 
	private String eventAddrApi; //이벤트 장소 맵API
	private String eventAddrApi2; //이벤트 장소 맵API
	private String eventDetail;
	
	public int getEventBoardNum() {
		return eventBoardNum;
	}

	public void setEventBoardNum(int eventBoardNum) {
		this.eventBoardNum = eventBoardNum;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getLove() {
		return love;
	}

	public void setLove(int love) {
		this.love = love;
	}

	public String getCrtUser() {
		return crtUser;
	}

	public void setCrtUser(String crtUser) {
		this.crtUser = crtUser;
	}

	public String getCrtdt() {
		return crtdt;
	}

	public void setCrtdt(String crtdt) {
		this.crtdt = crtdt;
	}

	public String getUpdtUser() {
		return updtUser;
	}

	public void setUpdtUser(String updtUser) {
		this.updtUser = updtUser;
	}

	public String getUpdtdt() {
		return updtdt;
	}

	public void setUpdtdt(String updtdt) {
		this.updtdt = updtdt;
	}

	public String getOpenDate() {
		return openDate;
	}

	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}

	public String getEventAddr() {
		return eventAddr;
	}

	public void setEventAddr(String eventAddr) {
		this.eventAddr = eventAddr;
	}

	public String getEventAddrApi() {
		return eventAddrApi;
	}

	public void setEventAddrApi(String eventAddrApi) {
		this.eventAddrApi = eventAddrApi;
	}

	public String getEventDetail() {
		return eventDetail;
	}

	public void setEventDetail(String eventDetail) {
		this.eventDetail = eventDetail;
	}

	public String getEventAddrApi2() {
		return eventAddrApi2;
	}

	public void setEventAddrApi2(String eventAddrApi2) {
		this.eventAddrApi2 = eventAddrApi2;
	}
	
	
	
	
}



