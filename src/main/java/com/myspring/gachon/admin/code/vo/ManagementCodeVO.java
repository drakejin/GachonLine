package com.myspring.gachon.admin.code.vo;

import org.apache.ibatis.type.Alias;

@Alias(value = "ManagementCodeVO")
public class ManagementCodeVO {
	private String grcode;
	private String code;
	private String codeName;
	private String grcodeName;
	private String useYn;
	private Integer sortSeq;
	private String crtUser;
	private String crtdt;
	private String updtUser;
	private String updtdt;
	
	public String getGrcode() {
		return grcode;
	}
	public void setGrcode(String grcode) {
		this.grcode = grcode;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getGrcodeName() {
		return grcodeName;
	}
	public void setGrcodeName(String grcodeName) {
		this.grcodeName = grcodeName;
	}
	public Integer getSortSeq() {
		return sortSeq;
	}
	public void setSortSeq(Integer sortSeq) {
		this.sortSeq = sortSeq;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	
	
}
