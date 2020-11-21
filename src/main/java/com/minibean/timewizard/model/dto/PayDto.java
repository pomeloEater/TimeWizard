package com.minibean.timewizard.model.dto;

public class PayDto {

	private int user_no;
	private String membership;
	private int timelapse;

	public PayDto() {

	}

	public PayDto(int user_no, String membership, int timelapse) {
		super();
		this.user_no = user_no;
		this.membership = membership;
		this.timelapse = timelapse;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getMembership() {
		return membership;

	}

	public void setMembership(String membership) {
		this.membership = membership;
	}

	public int getTimelapse() {
		return timelapse;
	}

	public void setTimelapse(int timelapse) {
		this.timelapse = timelapse;
	}

}
