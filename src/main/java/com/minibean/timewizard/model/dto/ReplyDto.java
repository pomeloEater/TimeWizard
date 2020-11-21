package com.minibean.timewizard.model.dto;

public class ReplyDto {

	private int reply_no;
	private int notice_no;
	private String user_no;
	private String reply_content;
	private String reply_regdate;
	private String user_name;
	private String user_id;
	
	
	public ReplyDto() {
		
	}
	
	public ReplyDto(int reply_no, int notice_no, String user_no, String reply_content, String reply_regdate,
			String user_name, String user_id) {
		super();
		this.reply_no = reply_no;
		this.notice_no = notice_no;
		this.user_no = user_no;
		this.reply_content = reply_content;
		this.reply_regdate = reply_regdate;
		this.user_name = user_name;
		this.user_id = user_id;
	}



	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public String getReply_regdate() {
		return reply_regdate;
	}

	public void setReply_regdate(String reply_regdate) {
		this.reply_regdate = reply_regdate;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	
	
	
}
