package com.minibean.timewizard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.ReplyBiz;
import com.minibean.timewizard.model.dto.ReplyDto;


@RestController
@RequestMapping(value = "/reply")

public class ReplyController {

	private Logger logger = LoggerFactory.getLogger(ReplyController.class);

	@Autowired
	private ReplyBiz replyBiz;
	
	
	@RequestMapping(value = "/replylist", method = RequestMethod.POST)
	public List<ReplyDto> replyList(ReplyDto dto) {
		List<ReplyDto> list = new ArrayList<ReplyDto>();
		list = replyBiz.replyList(dto.getNotice_no());
		logger.info("< Reply List >의 공지번호: "+dto.getNotice_no());
		logger.info("list목록: "+list);
		return list;
	
	}

	
	@RequestMapping(value = "/insertreply", method = RequestMethod.POST)
	public Map<String, Object> insertReply(ReplyDto dto) throws Exception {

		logger.info("< Insert Reply>");
		Map<String, Object> result = new HashMap<>();
		logger.info("dto: {},{},"+dto.getNotice_no(),dto.getReply_content(),dto.getUser_no());

		try {

			replyBiz.insertReply(dto);
			result.put("status", "OK");

		} catch (Exception e) {

			e.printStackTrace();
			result.put("status", "False");
		}

		return result;

	}
	
	@RequestMapping(value="/deletereply",method = RequestMethod.POST)
	public String deleteReply(int reply_no) {
		logger.info("< Delete Reply > ");
		int res = 0;
		
		res = replyBiz.deleteReply(reply_no);
		if(res>0) {
			logger.info(" < Delete Complete> ");
			return "notice_detil";
		}
		
		return "";
	}
	
	@RequestMapping(value="/updatereply",method = RequestMethod.POST)
	public boolean updateReply(@RequestBody ReplyDto dto) {
		logger.info("< Update Reply> ");
		int res = 0;
		logger.info("\n댓글내용: {}\n댓글번호: {}",dto.getReply_content(), dto.getReply_no());
		
		res = replyBiz.updateReply(dto);
		
		if(res>0) {
			logger.info(" < 댓글 수정 성공 >");
			return true;
		}else {
			logger.info(" < 댓글 수정 실패 >");
			return false;
		}
			
	
	}	

}
