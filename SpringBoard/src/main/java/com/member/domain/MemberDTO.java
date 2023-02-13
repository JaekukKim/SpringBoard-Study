package com.member.domain;

import java.util.Date;

public class MemberDTO {
	/*
	 * userId varchar(15) not null, userPwd varchar(20) not null, userName varchar(10) not null, userEmail varchar(30) not null, userNickname varchar(20) not null, userPhoneNumber varchar (15) not null,
	 * regDate timestamp not null default now(), primary key(userId, userNickname)
	 */

	private String userId; // pk - 중복불가
	private String userPwd;
	private String userName;
	private String userEmail;
	private String userNickname; // pk - 중복불가
	private String userPhoneNumber;
	private Date regDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserNickname() {
		return userNickname;
	}

	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}

	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberDTO [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userEmail=" + userEmail + ", userNickname="
				+ userNickname + ", userPhoneNumber=" + userPhoneNumber + ", regDate=" + regDate + "]";
	}

}
