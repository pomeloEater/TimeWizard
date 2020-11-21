package com.minibean.timewizard.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.minibean.timewizard.model.biz.CalendarBiz;
import com.minibean.timewizard.model.dto.CalendarDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.calendar.CalendarUtils;

@Controller
@RequestMapping("/calendar")
public class CalendarController {

	private Logger logger = LoggerFactory.getLogger(CalendarController.class);

	@Autowired
	CalendarBiz calBiz;


	@RequestMapping("/calendarlist/{year}/{month}/{date}")
	public String calednarDetail(Model model,
								@PathVariable String year,
								@PathVariable String month,
								@PathVariable String date,
								HttpSession session) {
		
		logger.info(" ---  < Calendar Detail > --- ");
		UserInfoDto dto = (UserInfoDto)session.getAttribute("login");
		int user_no = dto.getUser_no();
		String yyyyMMdd = year+ CalendarUtils.isTwo(month)+ CalendarUtils.isTwo(date);
		
		List<CalendarDto>list = calBiz.getCalList(user_no, yyyyMMdd);
		model.addAttribute("list",list);
		
		return "calendarlist";
	}
	
	

	@RequestMapping("/calinsert/{year}/{month}/{date}/{LastDay}")
	public String calInsert(@PathVariable String year,
					@PathVariable String month,
					@PathVariable String date,
					@PathVariable String LastDay,
					Model model) {
		
		logger.info(" *** year" +year);
		logger.info(" *** month"+month);
		logger.info(" *** date"+date);
		logger.info(" *** LastDay"+LastDay);
		
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("date",date);
		model.addAttribute("LastDay",LastDay);
		
		
		return "calendarinsert";
		
	}
	
	@RequestMapping("/caldetail")
	public String calUpdate(@PathVariable int cal_no, Model model) {
		
		logger.info(" --- < Caldetail > ---- ");
		CalendarDto calDto = calBiz.selectOne(cal_no);
		
		model.addAttribute("calDto",calDto);
		
		
		return "calendardetail";
		
	}

	
	  @RequestMapping(value="/calupdate",method = RequestMethod.POST) 
	  public String calUpdate(@RequestParam int cal_no,
			  				  @RequestParam String cal_title,
			  				  @RequestParam String cal_content) {
		  
		  logger.info("< Cal Update > ");
		  int res =0;
		  	
		  	res =calBiz.update(new CalendarDto(cal_no,cal_title, cal_content));
		  try {
			if(res>0) {
				logger.info(" < Cal Update 성공 > " );
				return "finalactionpage";
			}
		} catch (Exception e) {
			logger.info(" [ Error : Cal Update ] ");
			e.printStackTrace();
		}
		  return "";
	  
	  }
	  
	  
	  @RequestMapping("/caldelete")
	  public String calDelete(@PathVariable int cal_no) {
		 logger.info(" < cal delete >");
		
		int res =  calBiz.delete(cal_no);
		
		try {
			if(res>0) {
				logger.info(" < Cal Delete 성공 >  ");
				return "finalactionpage";
			}
		} catch (Exception e) {
			logger.info(" [ Error : Cal Delete");
			e.printStackTrace();
		}
		  
		  return "";
	  }
	  
	 
	



}
