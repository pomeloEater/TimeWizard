package com.minibean.timewizard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.FriendBiz;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.FriendDto;
import com.minibean.timewizard.model.dto.UserInfoDto;

@RestController
public class FriendController {
	
	@Autowired
	private FriendBiz friendBiz;
	
	@Autowired
	private UserInfoBiz userBiz;
	
	@Autowired
	SimpMessagingTemplate template;
	
	private Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@RequestMapping(value="/friend")
	public Map<String, List<FriendDto>> selectList(HttpSession session, UserInfoDto dto) {
		
		 dto = (UserInfoDto)session.getAttribute("login");
		
		//나와 친구인 유저들 리스트
		
		List<FriendDto> list = friendBiz.selectListF(dto.getUser_no());
		/* session.setAttribute("flist", list); */
		//return "redirect:/main";
		
		//나와 친구가 아닌 유저들 리스트
		List<FriendDto> list2 = friendBiz.selectListN(dto.getUser_no());
		/* session.setAttribute("nlist",list2); */
		logger.info("ajax결과: 접근성공");
		Map<String, List<FriendDto>> map = new HashMap<String, List<FriendDto>>();
		logger.info(list+"");
		map.put("flist",list);
		map.put("nlist",list2);
		
		return map;
	}
	@RequestMapping(value="/searchList")
	public Map<String, List<UserInfoDto>> searchList(HttpSession session, @RequestBody UserInfoDto dto) {
		logger.info("ajax결과: 접근성공");
		logger.info("검색한 사람의 번호: {}\n검색한 유저이름: {}",dto.getUser_no(),dto.getUser_name());
		List<UserInfoDto> list = friendBiz.searchList(dto);
		List<UserInfoDto> list2 = friendBiz.searchListN(dto);
		/* session.setAttribute("nlist",list2); */
		Map<String, List<UserInfoDto>> map = new HashMap<String, List<UserInfoDto>>();
		map.put("searchList",list);
		map.put("searchListN",list2);
		return map;
	}
	
	//로그인 했을때, 클라이언트로 부터 값을 받을 경로
	@MessageMapping("/login/join")
    public void join() {
		logger.info("님 등장");
			
		//전송해줄 경로에 값을 넣어서 클라이언트에게 전송
		//friend_no에게 전송됨
		template.convertAndSend("/subscribe/login/res/", "44555");
		
	}
	
	//신청버튼 클릭시, 클라이언트로 부터 값을 받을 경로
	@MessageMapping("/alert/friend")
    public void message(FriendDto dto, UserInfoDto udto) {
		udto = userBiz.selectOne(dto.getUser_no());
		logger.info("신청한 사람: {}\n신청받은 사람: {}",udto.getUser_name(), dto.getUser_name());
		//클라이언트에게 받은 값을 UserInfoDto 형식을 사용해 출력
		
		int res = friendBiz.SendInsert(dto);
		logger.info("결과: {}",res);
		if(res >= -1) {
			template.convertAndSend("/subscribe/alert/good/"+dto.getFriend_no(),udto);
			//전송해줄 경로 + 친구신청을 받게될 이름 주소로 해당 값을 넣은뒤 전송
			
		}
    }
	
	//친구 요청 -> "수락"
	//'send'를 'accept'로 바꾸기
	@MessageMapping("/confirm/accept")
	public void accept(FriendDto dto, UserInfoDto udto) {
		udto = userBiz.selectOne(dto.getFriend_no());
		logger.info("accept 작업");
		logger.info("신청한 사람: {}\n신청받은 사람: {}",dto.getUser_name(), udto.getUser_name());
		logger.info("신청한 사람의 번호: {}\n신청받은 사람의 번호: {}",dto.getUser_no(),dto.getFriend_no());
		
		int res = friendBiz.AcceptUpdate(dto);
		logger.info("친구추가 결과: {}",res);
		if(res >= -1) {
			template.convertAndSend("/subscribe/confirm/res/"+dto.getUser_no(),udto.getUser_name());
			logger.info("친구추가 성공");
		}
		
	}
	@MessageMapping("/confirm/fnd")
	public void sendfnd(FriendDto dto) {
		logger.info("confirm 작업");
		logger.info("신청한 사람: {}",dto.getUser_name());
		template.convertAndSend("/subscribe/confirm/check/"+dto.getFriend_no(),dto.getUser_name());
		
	}
	
	
	//친구 요청 -> "거절"
	@MessageMapping("/confirm/deny")
	public void deny(FriendDto dto ,UserInfoDto udto) {
		logger.info("deny 작업");
		udto = userBiz.selectOne(dto.getUser_no());
		
		logger.info("거절당한 사람: {} \nuser_no: {}, friend_no: "+dto.getFriend_no(),dto.getUser_name(),dto.getUser_no());
		int res = friendBiz.DenyUpAndDel(dto);
		logger.info("거절 결과: {}",res);
		template.convertAndSend("/subscribe/confirm/denychk/"+dto.getFriend_no(),udto.getUser_name());

	}
	
	
	//친구 목록에서 삭제
		@MessageMapping("/confirm/delete")
		public void deletefriend(FriendDto dto ,UserInfoDto udto) {
			logger.info("delete 작업");
			udto = userBiz.selectOne(dto.getUser_no());
			
			logger.info("삭제하는 사람: {} \nuser_no: {}, friend_no: "+dto.getFriend_no(),udto.getUser_name(),dto.getUser_no());
			int res = friendBiz.DeleteFriend(dto);
			logger.info("삭제 결과: {}",res);
			template.convertAndSend("/subscribe/confirm/deletechk/"+dto.getFriend_no(),udto.getUser_name());

		}
		
		
		//친구 요청 -> "거절"
		@MessageMapping("/invite/send")
		public void invite(FriendDto dto) {
			logger.info("invite 작업");
			logger.info("url:{} ",dto.getUrl());
			template.convertAndSend("/subscribe/invite/res/"+dto.getFriend_no(),dto);

		}
		
}
