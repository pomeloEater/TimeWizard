package com.minibean.timewizard.controller;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.minibean.timewizard.model.biz.ChatBiz;
import com.minibean.timewizard.model.biz.GroupBiz;
import com.minibean.timewizard.model.dto.ChatDto;
import com.minibean.timewizard.model.dto.GroupDto;






@Controller
public class GroupController {
	@Autowired
	private SimpMessagingTemplate template;
	
	private Logger log = LoggerFactory.getLogger(GroupController.class);

	
	@Autowired
	private GroupBiz biz;
	
	@Autowired
	private ChatBiz cbiz;
	
	
	@GetMapping("/grouplist")
	public String list(Model model) {
		 model.addAttribute("list", biz.selectList()); 
		return "grouplist";
	}

	@RequestMapping("/ajaxgrouplist")
	@ResponseBody
	public Map<String, List<GroupDto>> ajaxgrouplist() {
		 Map<String, List<GroupDto>> map = new HashMap<String, List<GroupDto>>();
		 List<GroupDto> list = new ArrayList<GroupDto>();
		 list = biz.selectList();
		 map.put("flist", list);
		return map;
	}

	@RequestMapping(value= "/ajaxgroupselectlist", method = RequestMethod.POST )
	@ResponseBody
	public Map<String, List<GroupDto>> ajaxgroupselectlist(@RequestBody GroupDto dto) {
		 Map<String, List<GroupDto>> map = new HashMap<String, List<GroupDto>>();
		 List<GroupDto> list = new ArrayList<GroupDto>();
		 log.info("받아온 값: {}",dto.getGroup_title());
		 list = biz.searchList(dto.getGroup_title());
		 map.put("selectlist", list);
		return map;
	}
	
	@GetMapping("/joinroom/{name}")
	public String room(@PathVariable("name") String name, Model model) {
		 
		  
		GroupDto room = biz.selectOne(name); 
		  
		  
		model.addAttribute("dto", room);
	
		return "grouproom";
	}
	@GetMapping("/groupnewroom")
	public String make(Model model) {
		return "groupnewroom";
	}

	@PostMapping(value="/createres")
	public String makeRoom(GroupDto dto, URLEncoder encoder) throws UnsupportedEncodingException {
	 	int res = biz.insert(dto);
	 	String name = dto.getGroup_title();
	 	 String encodedParam = URLEncoder.encode(name, "UTF-8");//URL 주소에 넣어줄 파라미터를 인코딩을 해야 한글을 인식함
		if(res > 0) {
			log.info("방 생성성공\n방 이름: {}",dto.getGroup_title());
			return "redirect:/joinroom/"+encodedParam;
		}
		else {
			log.info("방 생성실패");
			return "redirect:/groupnewroom";
		}
		
	}
	
	@MessageMapping("/chat/join")
    public void join(ChatDto dto) {
		
		log.info(dto.getUser_id()+"님 등장");
		int res = biz.clientplus(dto.getChat_title());
		log.info("결과: {}",res);
		dto.setChat_content(dto.getUser_id() + "님이 입장하셨습니다.");
        template.convertAndSend("/subscribe/chat/join/"+dto.getChat_title(), dto);
    }

	@MessageMapping("/chat/message")
    public void message(ChatDto dto) {
		log.info("\n"+dto.getChat_title()+" 채팅방\n"+dto.getUser_id()+": "+dto.getChat_content());
		cbiz.chatinsert(dto);
        template.convertAndSend("/subscribe/chat/room/"+dto.getChat_title(), dto);
    }
	
	@MessageMapping("/chat/disconnect")
    public String disconnect(ChatDto dto) {
		String room = dto.getChat_title();
		log.info(dto.getUser_id()+"님 퇴장");
		int res = biz.clientminus(room);
		log.info("클라이언트 감소 결과: {}",res);
		GroupDto udto = biz.clientnum(room);
		log.info("방 인원 결과: {}",udto.getGroup_client());
		int clientnum = udto.getGroup_client();
		
		dto.setChat_content(dto.getUser_id() + "님이 퇴장하셨습니다.");
        template.convertAndSend("/subscribe/chat/join/"+room, dto);
		if (udto.getGroup_anyone().equals("N")) {
			if (clientnum <= 0) {
				log.info("현재 인원이 0명 입니다. 방 삭제를 하겠습니다.");
				int deleteroom = biz.kaboom(room);
				if (deleteroom > 0) {
					log.info("방 삭제완료.");
					return "redirect:/grouplist";
				} else {
					log.info("방 삭제실패.");

				}
			}
		}
		return "";
    }
}