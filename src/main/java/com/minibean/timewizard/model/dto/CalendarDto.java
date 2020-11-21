package com.minibean.timewizard.model.dto;

import java.util.Date;

public class CalendarDto {

	private int cal_no;
	private int user_no;
	private String user_name;
	private String cal_title;
	private String cal_content;
	private String cal_mdate;
	private Date cal_regdate;
	
	public CalendarDto() {
		
	}

	public CalendarDto(int cal_no, String cal_title, String cal_content) {
		this.cal_no = cal_no;
		this.cal_title = cal_title;
		this.cal_content = cal_content;
	}
	

	public CalendarDto(int cal_no, int user_no, String cal_title, String cal_content, String cal_mdate,
			Date cal_regdate, String user_name) {
		super();
		this.cal_no = cal_no;
		this.user_no = user_no;
		this.cal_title = cal_title;
		this.cal_content = cal_content;
		this.cal_mdate = cal_mdate;
		this.cal_regdate = cal_regdate;
		this.user_name = user_name;
	}


	public int getCal_no() {
		return cal_no;
	}

	public void setCal_no(int cal_no) {
		this.cal_no = cal_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getCal_title() {
		return cal_title;
	}

	public void setCal_title(String cal_title) {
		this.cal_title = cal_title;
	}

	public String getCal_content() {
		return cal_content;
	}

	public void setCal_content(String cal_content) {
		this.cal_content = cal_content;
	}


	public String getCal_mdate() {
		return cal_mdate;
	}



	public void setCal_mdate(String cal_mdate) {
		this.cal_mdate = cal_mdate;
	}



	public Date getCal_regdate() {
		return cal_regdate;
	}

	public void setCal_regdate(Date cal_regdate) {
		this.cal_regdate = cal_regdate;
	}



	public String getUser_name() {
		return user_name;
	}


	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	
	
	
	
	
}
