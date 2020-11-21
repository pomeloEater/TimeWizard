package com.minibean.timewizard.model.dao;

import java.util.List;

import com.minibean.timewizard.model.dto.ReplyDto;

public interface ReplyDao {

	String NAMESPACE ="reply-mapper.";
	
	public List<ReplyDto> replyList(int notice_no);
	public int insertReply(ReplyDto dto);
	public int updateReply(ReplyDto dto);
	public int deleteReply(int reply_no);
	
}
