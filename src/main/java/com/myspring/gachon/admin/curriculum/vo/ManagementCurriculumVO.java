package com.myspring.gachon.admin.curriculum.vo;

import org.apache.ibatis.type.Alias;

@Alias(value = "ManagementCurriculumVO")
public class ManagementCurriculumVO {
	private String year;
	private String courseNum;
	private String courseName;
	private String major;
	private String major_nm;
	private String semester;
	private String completeDivision;
	private String completeDivision_nm;
	private Integer grade;
	private String schoolYear;
	private String crtUser;
	private String crtdt;
	private String updtUser;
	private String updtdt;
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
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
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getMajor_nm() {
		return major_nm;
	}
	public void setMajor_nm(String major_nm) {
		this.major_nm = major_nm;
	}
	public String getSemester() {
		return semester;
	}
	public void setSemester(String semester) {
		this.semester = semester;
	}
	public String getCompleteDivision() {
		return completeDivision;
	}
	public void setCompleteDivision(String completeDivision) {
		this.completeDivision = completeDivision;
	}
	public String getCompleteDivision_nm() {
		return completeDivision_nm;
	}
	public void setCompleteDivision_nm(String completeDivision_nm) {
		this.completeDivision_nm = completeDivision_nm;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public String getSchoolYear() {
		return schoolYear;
	}
	public void setSchoolYear(String schoolYear) {
		this.schoolYear = schoolYear;
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