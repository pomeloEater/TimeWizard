package com.minibean.timewizard.model.biz;

import java.util.List;

import com.minibean.timewizard.model.dto.GroupDto;

public interface GroupBiz {

	public int insert(GroupDto chat);

	public List<GroupDto> selectList();
	
	public List<GroupDto> searchList(String name);
	
	public GroupDto selectOne(String name);

	public int clientplus(String name);
	
	public int kaboom(String name);

	public int clientminus(String name);
	
	public GroupDto clientnum(String name);
}
