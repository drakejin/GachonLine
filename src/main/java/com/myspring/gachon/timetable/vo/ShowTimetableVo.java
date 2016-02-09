package com.myspring.gachon.timetable.vo;

import org.apache.ibatis.type.Alias;

@Alias("ShowTimetableVo")
public class ShowTimetableVo {	
	private int memberId;
	private String memberName;
	private String college;
	private String department;
	private String major;
	private String courseNum;
	private String courseName;
	private String professor;
	private String lecRoom;
	private String lecTime;
	private String crtUser;
	private String crtdt;
	private String updtUser;
	private String updtdt;
	
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
	public String getCourseNum() {
		return courseNum;
	}
	public void setCourseNum(String courseNum) {
		this.courseNum = courseNum;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getProfessor() {
		return professor;
	}
	public void setProfessor(String professor) {
		this.professor = professor;
	}
	public String getLecRoom() {
		return lecRoom;
	}
	public void setLecRoom(String lecRoom) {
		this.lecRoom = lecRoom;
	}
	public String getLecTime() {
		return lecTime;
	}
	public void setLecTime(String lecTime) {
		this.lecTime = lecTime;
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
	
	
	
}
