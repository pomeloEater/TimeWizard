package com.minibean.timewizard.model.dao;

import java.util.Date;
import java.util.List;

import com.minibean.timewizard.model.dto.StopwatchDto;

public interface StopwatchDao {
	
	String NAMESPACE="com.minibean.timewizard.stopwatch.";
	public List<StopwatchDto> selectList(Date date);
	public List<StopwatchDto> selectOne(int todo_no);
	public int insert(StopwatchDto dto);
	public int update(StopwatchDto dto);
	public int delete(int todo_no);
	
}
