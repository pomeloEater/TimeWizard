package com.minibean.timewizard.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.UserInfoDto;

@Controller
public class AdminController {
	
	private Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private UserInfoBiz userinfoBiz;
	
	@RequestMapping(value="/adminpage")
	public String adminPage(Model model) {
		logger.info("[adminpage]");
		
		model.addAttribute("list", userinfoBiz.selectList());
		
		return "adminpage";
	}
	
	/* 관리자페이지에서 등급변경 버튼 누르면 등급변경페이지로 이동 */
	@RequestMapping(value="/adminrole")
	public String adminRole(Model model, @RequestParam int user_no) {
		logger.info("[admin role change]");

		model.addAttribute("dto", userinfoBiz.selectOne(user_no));
		
		return "adminrole";
	}
	
	/* 등급변경페이지에서 변경완료 버튼 누르면 등급 변경 됨 */
	@RequestMapping(value="/adminroleres")
	public String adminRoleRes(UserInfoDto dto, UserInfoDto user_no, @RequestParam String user_role) {
		logger.info("[admin role change result]");

		int res = userinfoBiz.updateRoleRes(dto);

		if(res != 0) {
			System.out.println("등급 변경 성공");
		} else {
			System.out.println("등급 변경 실패");
		}
		
		return "redirect:adminpage?user_role="+dto.getUser_role();
	}
	
	/* 비활성화 버튼 누르면 활성화=N */
	@RequestMapping(value="/admindelete")
	public String adminDelete(UserInfoDto dto) {
		logger.info("[admin member delete]");

		  int res = userinfoBiz.delete(dto.getUser_no());
		  logger.info("Asdf: {}",dto.getUser_no());
		  
		  if(res != 0) {
			  System.out.println("강제탈퇴 성공");
		  } else {
			  System.out.println("강제탈퇴 실패");
		  }
		 
		
		return "redirect:adminpage?user_no="+dto.getUser_active();
		
	}
	
}
	

