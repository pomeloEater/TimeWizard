package com.minibean.timewizard.model.biz;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minibean.timewizard.model.dao.ReplyDao;
import com.minibean.timewizard.model.dto.ReplyDto;


@Service
public class ReplyBizImpl implements ReplyBiz{

	Logger logger = LoggerFactory.getLogger(ReplyBiz.class);
	
	@Autowired
	ReplyDao replyDao;
	
	
	@Override
	public List<ReplyDto> replyList(int notice_no) {
		
		return replyDao.replyList(notice_no);
	}

	@Override
	public int insertReply(ReplyDto dto) {
		
		return replyDao.insertReply(dto);
	}

	@Override
	public int updateReply(ReplyDto dto) {
		
		return replyDao.updateReply(dto);
	}

	@Override
	public int deleteReply(int reply_no) {
		
		return replyDao.deleteReply(reply_no);
	}

}
