package com.minibean.timewizard.model.dao;

import com.minibean.timewizard.model.dto.ChatDto;

public interface ChatDao {

	String namespace = "chat-mapper.";
	
	public int chatInsert(ChatDto dto);

}
