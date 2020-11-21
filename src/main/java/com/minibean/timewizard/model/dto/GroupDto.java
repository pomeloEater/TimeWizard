package com.minibean.timewizard.model.dto;

import java.sql.Date;

public class GroupDto {

	private int group_no;
	private int group_su;
	private int group_client;
	private String user_id;
	private String group_title;
	private String user_name;
	private String group_content;
	private String group_public;
	private Date group_regdate;
	private String group_hashtag;

	private String group_pw;
	private String group_anyone;
	
	
	public GroupDto() {

		// TODO Auto-generated constructor stub
	}
	
	public GroupDto(int group_no, int group_su, int group_client, String user_id, String group_title, String user_name,
			String group_content, String group_public, Date group_regdate, String group_hashtag, String group_pw,
			String group_anyone) {
		this.group_no = group_no;
		this.group_su = group_su;
		this.group_client = group_client;
		this.user_id = user_id;
		this.group_title = group_title;
		this.user_name = user_name;
		this.group_content = group_content;
		this.group_public = group_public;
		this.group_regdate = group_regdate;
		this.group_hashtag = group_hashtag;
		this.group_pw = group_pw;
		this.group_anyone = group_anyone;
	}




	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public int getGroup_su() {
		return group_su;
	}
	public void setGroup_su(int group_su) {
		this.group_su = group_su;
	}
	public int getGroup_client() {
		return group_client;
	}
	public void setGroup_client(int group_client) {
		this.group_client = group_client;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getGroup_title() {
		return group_title;
	}
	public void setGroup_title(String group_title) {
		this.group_title = group_title;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getGroup_content() {
		return group_content;
	}
	public void setGroup_content(String group_content) {
		this.group_content = group_content;
	}
	public String getGroup_public() {
		return group_public;
	}
	public void setGroup_public(String group_public) {
		this.group_public = group_public;
	}
	public Date getGroup_regdate() {
		return group_regdate;
	}
	public void setGroup_regdate(Date group_regdate) {
		this.group_regdate = group_regdate;
	}
	public String getGroup_hashtag() {
		return group_hashtag;
	}
	public void setGroup_hashtag(String group_hashtag) {
		this.group_hashtag = group_hashtag;
	}
	public String getGroup_pw() {
		return group_pw;
	}
	public void setGroup_pw(String group_pw) {
		this.group_pw = group_pw;
	}
	public String getGroup_anyone() {
		return group_anyone;
	}
	public void setGroup_anyone(String group_anyone) {
		this.group_anyone = group_anyone;
	}
	
	
	
	
	
	
}
