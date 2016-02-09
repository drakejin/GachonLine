package com.myspring.gachon.member.myinfo.vo;

import org.apache.ibatis.type.Alias;

@Alias(value = "MyInfoVO")
public class MyInfoVO {
	private String profileImgPath;
	private String memberType;
	private String memberType_nm;
	private Integer memberId;
	private String memberName;
	private String birthDate;
	private String college;
	private String college_nm;
	private String department;
	private String department_nm;
	private String major;
	private String major_nm;
	private String schoolYear;
	private String schoolYear_nm;
	private String year;
	private String collegeStatus;
	private String collegeStatus_nm;
	private String completeTerm;
	private String completeTerm_nm;
	private String password;
	private String postalCode;
	private String address;
	private String phone;
	private String phone2;
	private String mobile;
	private String email;
	private String crtUser;
	private String crtdt;
	private String updtUser;
	private String updtdt;
	
	public String getProfileImgPath() {
		return profileImgPath;
	}
	public void setProfileImgPath(String profileImgPath) {
		this.profileImgPath = profileImgPath;
	}
	public String getMemberType() {
		return memberType;
	}
	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}
	public Integer getMemberId() {
		return memberId;
	}
	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getCollegeStatus() {
		return collegeStatus;
	}
	public void setCollegeStatus(String collegeStatus) {
		this.collegeStatus = collegeStatus;
	}
	public String getCompleteTerm() {
		return completeTerm;
	}
	public void setCompleteTerm(String completeTerm) {
		this.completeTerm = completeTerm;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getSchoolYear() {
		return schoolYear;
	}
	public void setSchoolYear(String schoolYear) {
		this.schoolYear = schoolYear;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMemberType_nm() {
		return memberType_nm;
	}
	public void setMemberType_nm(String memberType_nm) {
		this.memberType_nm = memberType_nm;
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
	public String getSchoolYear_nm() {
		return schoolYear_nm;
	}
	public void setSchoolYear_nm(String schoolYear_nm) {
		this.schoolYear_nm = schoolYear_nm;
	}
	public String getCollegeStatus_nm() {
		return collegeStatus_nm;
	}
	public void setCollegeStatus_nm(String collegeStatus_nm) {
		this.collegeStatus_nm = collegeStatus_nm;
	}
	public String getCompleteTerm_nm() {
		return completeTerm_nm;
	}
	public void setCompleteTerm_nm(String completeTerm_nm) {
		this.completeTerm_nm = completeTerm_nm;
	}
}