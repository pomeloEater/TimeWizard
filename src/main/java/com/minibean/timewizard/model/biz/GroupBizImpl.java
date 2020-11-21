package com.minibean.timewizard.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.GroupDao;
import com.minibean.timewizard.model.dto.GroupDto;

@Service
public class GroupBizImpl implements GroupBiz{

	@Autowired
	GroupDao dao;

	@Override
	public int insert(GroupDto chat) {
		// TODO Auto-generated method stub
		return dao.insert(chat);
	}

	@Override
	public List<GroupDto> selectList() {
		// TODO Auto-generated method stub
		return dao.selectList();
	}

	@Override
	public GroupDto selectOne(String name) {
		// TODO Auto-generated method stub
		return dao.selectOne(name);
	}
	
	@Override
	public int clientplus(String name) {
		return dao.clientplus(name);
	}
	@Override
	public int kaboom(String name) {
		return dao.kaboom(name);
	}

	@Override
	public int clientminus(String name) {
		// TODO Auto-generated method stub
		return dao.clientminus(name);
	}

	@Override
	public GroupDto clientnum(String name) {
		// TODO Auto-generated method stub
		return dao.clientnum(name);
	}

	@Override
	public List<GroupDto> searchList(String name) {
		// TODO Auto-generated method stub
		return dao.searchList(name);
	}
	
	 
	 


}
