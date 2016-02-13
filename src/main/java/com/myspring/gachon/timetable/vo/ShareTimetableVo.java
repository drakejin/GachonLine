package com.myspring.gachon.timetable.vo;

import org.apache.ibatis.type.Alias;

@Alias("ShareTimetableVo")
public class ShareTimetableVo {
	private int memberId;
	private String memberName;
	private String college;
	private String college_nm;
	private String department;
	private String department_nm;
	private String major;
	private String major_nm;
	
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getCollege_nm() {
		return college_nm;
	}
	public void setCollege_nm(String college_nm) {
		this.college_nm = college_nm;
	}
	public String getDepartment_nm() {
		return department_nm;
	}
	public void setDepartment_nm(String department_nm) {
		this.department_nm = department_nm;
	}
	public String getMajor_nm() {
		return major_nm;
	}
	public void setMajor_nm(String major_nm) {
		this.major_nm = major_nm;
	}
	
	
}
