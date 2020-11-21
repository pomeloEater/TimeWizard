package com.minibean.timewizard.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



import com.minibean.timewizard.utils.mail.MailService;
import com.minibean.timewizard.utils.mail.RandomCode;


@Controller

public class MailController {
	
	@Autowired
	private MailService mailService;
	private Logger logger = LoggerFactory.getLogger(MailController.class);

// 회원가입 이메일 인증
	@RequestMapping(value = "login/emailSend", method = RequestMethod.GET)
	@ResponseBody
	public String sendMailAuth(HttpSession session, @RequestParam String user_email) {
		logger.info("이메일 전송");
		logger.info("[emailSend]");
		//랜덤코드 객체 생성
		RandomCode randomcode = new RandomCode();
		//랜덤코드를 생성해주는 메소드 호출
		
		String ran = randomcode.excuteGenerate();
		logger.info("1."+ran);
		session.setAttribute("join", ran);
		String subject = "회원가입 인증 코드 발급 안내입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증 코드는 " + ran + " 입니다.");
		//이메일 전송
		mailService.send(subject, sb.toString(),
		"junghb1209@naver.com", user_email, null, ran);
		//발송된 랜덤코드 리턴
		return ran;
		
	}
}
