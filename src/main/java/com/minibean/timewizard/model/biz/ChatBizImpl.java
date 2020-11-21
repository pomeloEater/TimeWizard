package com.minibean.timewizard.model.biz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.ChatDao;
import com.minibean.timewizard.model.dto.ChatDto;

@Service
public class ChatBizImpl implements ChatBiz{

	@Autowired
	ChatDao dao;
	
	@Override
	public int chatinsert(ChatDto dto) {
		// TODO Auto-generated method stub
		return dao.chatInsert(dto);
	}


	
	 
	 


}
