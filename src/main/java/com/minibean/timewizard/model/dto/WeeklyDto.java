package com.minibean.timewizard.model.dto;

public class WeeklyDto {

	private String the_date;
	private String fullcount;
	private String complete;
	private String uncomplete;

	public WeeklyDto() {
	}

	public WeeklyDto(String the_date, String fullcount, String complete, String uncomplete) {
		super();
		this.the_date = the_date;
		this.fullcount = fullcount;
		this.complete = complete;
		this.uncomplete = uncomplete;
	}

	public String getThe_date() {
		return the_date;
	}

	public void setThe_date(String the_date) {
		this.the_date = the_date;
	}

	public String getFullcount() {
		return fullcount;
	}

	public void setFullcount(String fullcount) {
		this.fullcount = fullcount;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getUncomplete() {
		return uncomplete;
	}

	public void setUncomplete(String uncomplete) {
		this.uncomplete = uncomplete;
	}
	
	
}
