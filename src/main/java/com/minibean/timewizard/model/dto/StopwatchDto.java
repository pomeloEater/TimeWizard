package com.minibean.timewizard.model.dto;

import java.util.Date;

public class StopwatchDto {

	private int stopwatch_no;
	private int todo_no;
	private Date start_time;
	private Date end_time;
	
	public StopwatchDto() {}
	public StopwatchDto(int stopwatch_no, int todo_no, Date start_time, Date end_time) {
		this.stopwatch_no = stopwatch_no;
		this.todo_no = todo_no;
		this.start_time = start_time;
		this.end_time = end_time;
	}
	
	public int getTodo_no() {
		return todo_no;
	}
	public void setTodo_no(int todo_no) {
		this.todo_no = todo_no;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public int getStopwatch_no() {
		return stopwatch_no;
	}
	public void setStopwatch_no(int stopwatch_no) {
		this.stopwatch_no = stopwatch_no;
	}
	
	
}
