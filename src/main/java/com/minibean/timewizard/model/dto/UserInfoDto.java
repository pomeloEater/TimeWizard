package com.minibean.timewizard.model.dto;

import java.util.Date;

public class UserInfoDto {

	private int user_no;
	private String user_id;
	private String user_pw;
	private String user_newestpw;
	private String user_newestpw_check;
	private String user_name;
	private String user_email;
	private String user_role;
	private String user_photo;
	private String user_active;
	private String user_distinct;
	private Date user_regdate;
	private FriendDto friendDto;

	public UserInfoDto() {
	}

	public UserInfoDto(int user_no, String user_id, String user_pw, String user_name, String user_email,
			String user_role, String user_photo, String user_active, String user_distinct, Date user_regdate) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_role = user_role;
		this.user_photo = user_photo;
		this.user_active = user_active;
		this.user_distinct = user_distinct;
		this.user_regdate = user_regdate;
	}

	// 회원정보조회
	public UserInfoDto(int user_no, String user_id, String user_pw, String user_name, String user_email,
			String user_active, Date user_regdate, String user_role) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_active = user_active;
		this.user_regdate = user_regdate;
		this.user_role = user_role;
	}

	// update
	public UserInfoDto(int user_no, String user_pw, String user_name, String user_email, String user_distinct) {
		this.user_no = user_no;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_distinct = user_distinct;
	}

	// updateRoleRes
	public UserInfoDto(int user_no, String user_role) {
		this.user_no = user_no;
		this.user_role = user_role;
	}

	// user_newpw, user_newestpw_check 추가
	public UserInfoDto(int user_no, String user_id, String user_pw, String user_newestpw, String user_newestpw_check,
			String user_name, String user_email, String user_role, String user_photo, String user_active,
			String user_distinct, Date user_regdate, FriendDto friendDto) {
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_newestpw = user_newestpw;
		this.user_newestpw_check = user_newestpw_check;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_role = user_role;
		this.user_photo = user_photo;
		this.user_active = user_active;
		this.user_distinct = user_distinct;
		this.user_regdate = user_regdate;
		this.friendDto = friendDto;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_newestpw() {
		return user_newestpw;
	}

	public void setUser_newestpw(String user_newestpw) {
		this.user_newestpw = user_newestpw;
	}

	public String getUser_newestpw_check() {
		return user_newestpw_check;
	}

	public void setUser_newestpw_check(String user_newestpw_check) {
		this.user_newestpw_check = user_newestpw_check;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_role() {
		return user_role;
	}

	public void setUser_role(String user_role) {
		this.user_role = user_role;
	}

	public String getUser_photo() {
		return user_photo;
	}

	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}

	public String getUser_active() {
		return user_active;
	}

	public void setUser_active(String user_active) {
		this.user_active = user_active;
	}

	public String getUser_distinct() {
		return user_distinct;
	}

	public void setUser_distinct(String user_distinct) {
		this.user_distinct = user_distinct;
	}

	public Date getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(Date user_regdate) {
		this.user_regdate = user_regdate;
	}

	public FriendDto getFriendDto() {
		return friendDto;
	}

	public void setFriendDto(FriendDto friendDto) {
		this.friendDto = friendDto;
	}

}