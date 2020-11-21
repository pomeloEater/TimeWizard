package com.minibean.timewizard.model.dto;

import com.minibean.timewizard.message.MessageType;

public class ChatDto {

	int group_no;
	String user_id;
	String chat_title;
	String chat_content;
	MessageType type;
	
	
	
	public ChatDto() {
		

	}


	public ChatDto(int group_no, String user_id, String chat_title, String chat_content, MessageType type) {
		
		this.group_no = group_no;
		this.user_id = user_id;
		this.chat_title = chat_title;
		this.chat_content = chat_content;
		this.type = type;
	}
	
	
	
	public MessageType getType() {
		return type;
	}


	public void setType(MessageType type) {
		this.type = type;
	}


	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getChat_title() {
		return chat_title;
	}
	public void setChat_title(String chat_title) {
		this.chat_title = chat_title;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	
	
	
	

}
