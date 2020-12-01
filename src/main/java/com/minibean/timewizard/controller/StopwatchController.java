package com.minibean.timewizard.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.minibean.timewizard.model.biz.UserTodoBiz;
import com.minibean.timewizard.model.dto.UserTodoDto;

@Controller
public class StopwatchController {
	@Autowired
	private UserTodoBiz userTodoBiz;
	private Logger logger = LoggerFactory.getLogger(StopwatchController.class);
	
	
	@RequestMapping(value="/timer")
	public String timer() {
		logger.info("[timer]");
		return "personal_timer";
	}
	@RequestMapping(value="/stopwatch")
	public String Stopwatch() {
		logger.info("[stopwatch]");
		return "personal_stopwatch";
	}
	
	@RequestMapping("/stopwatch/update")
	@ResponseBody
	public int updateTime(@RequestBody UserTodoDto dto) {
		int res = userTodoBiz.updateTime(dto);
		logger.info(">> [CONTROLLER-DAILY] success?: " + ((res == 1)?"yes":"no"));
		return res;
	}
}