package com.minibean.timewizard.model.dto;

public class FriendDto {

	private int friend_no;
	private int user_no;
	private String status;
	private String user_name;
	private String user_photo;
	private String url;
	private String user_distinct;
	public FriendDto() {
	}
	
	
	// USERINFO와 FRIEND 목록 합치는(친구 목록 출력하기 위해)
	public FriendDto(int friend_no, int user_no, String status, String user_name, String user_photo, String url) {
		this.friend_no = friend_no;
		this.user_no = user_no;
		this.status = status;
		this.user_name = user_name;
		this.user_photo = user_photo;
		this.url = url;
		}

	public int getFriend_no() {
		return friend_no;
	}
	public void setFriend_no(int friend_no) {
		this.friend_no = friend_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_photo() {
		return user_photo;
	}
	public void setUser_photo(String user_photo) {
		this.user_photo = user_photo;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public void setUser_distinct(String user_distinct) {
		this.user_distinct = user_distinct;
	}
	public String getUser_distinct() {
		return user_distinct;
	}

	


}
