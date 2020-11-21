package com.minibean.timewizard.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class IdPwFindController {
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	private Logger logger = LoggerFactory.getLogger(IdPwFindController.class);

	@RequestMapping(value="/findform")
	public String gofindpage() {
		logger.info("idpw_find controller");
		return "idpw_find";
	}
	
	//아이디 찾기
	//이메일
	@RequestMapping(value="/findID")
	@ResponseBody
	public UserInfoDto findID(String user_email) {
		logger.info("[findID Controller]");
		
		UserInfoDto dto = userinfoBiz.findID(user_email);
		
		logger.info("dto email: "+dto.getUser_email());
		logger.info("dto id : "+dto.getUser_id());
		logger.info("dto name : "+dto.getUser_name());
		
		return dto;
	}
	
	
	//비밀번호 찾기
	//이메일, 아이디
	@RequestMapping("/findPW")
	@ResponseBody
	public UserInfoDto findPW(@RequestParam("user_email")String user_email,
			@RequestParam("user_id")String user_id){
		logger.info("[findPW Controller]");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_email", user_email);
		map.put("user_id", user_id);
		
		
		UserInfoDto dto = userinfoBiz.findPW(map);
		logger.info("controller dto : "+dto);
		logger.info("controller dto : "+dto.getUser_id());
		logger.info("controller dto : "+dto.getUser_pw());
		return dto;
	}
	
}
