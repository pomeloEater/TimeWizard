package com.minibean.timewizard.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.minibean.timewizard.model.biz.CalendarBiz;
import com.minibean.timewizard.model.biz.UserInfoBiz;
import com.minibean.timewizard.model.dto.CalendarDto;
import com.minibean.timewizard.model.dto.UserInfoDto;
import com.minibean.timewizard.utils.calendar.CalendarUtils;

@Controller
public class MainController {
	
	@Autowired
	private UserInfoBiz userInfoBiz;
	private Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private CalendarBiz calBiz;
	
	@RequestMapping(value="/")
	public String index() {
		logger.info(">> [CONTROLLER-HOME] go to index page");
		return "indexpage";
	}
	
    @RequestMapping(value="/logout")
	public String invalidate(HttpSession session) {
		logger.info(">> [CONTROLLER-HOME] user logout");
		session.invalidate();
		// index로 이동 시켜도 되지 않을까요??
//		return "redirect:/login/loginform";
		 return "redirect:/";
	}
    
    @RequestMapping(value="/error", method= RequestMethod.GET)
    public String renderErrorPage(Model model, HttpServletRequest request) {
        String errorMsg = "";
        int httpErrorCode = getErrorCode(request);
 
        switch (httpErrorCode) {
            case 400: {
                errorMsg = "Http Error Code: 400. Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Http Error Code: 401. Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Http Error Code: 404. Resource not found";
                break;
            }
            case 500: {
                errorMsg = "Http Error Code: 500. Internal Server Error";
                break;
            }
        }
        model.addAttribute("message", errorMsg);
        return "error";
    }
    
    private int getErrorCode(HttpServletRequest request) {
        return (Integer) request.getAttribute("javax.servlet.error.status_code");
    }
	
	@RequestMapping(value="/main")
	public String PlainMain(HttpSession session , Model model) {
		logger.info(">> [CONTROLLER-MAIN] move to main page");
//		return "finalactionpage";
		UserInfoDto dto = (UserInfoDto) session.getAttribute("login");
		
		String user_distinct = dto.getUser_distinct();
		session.setAttribute("linked", dto);
		logger.info("* URI : /timewizard/user/" + user_distinct);
	
			
			return "redirect:./user/"+user_distinct;
	}
	
	@RequestMapping(value="/user/{user_distinct}")
	public String Main(@PathVariable String user_distinct, HttpSession session,Model model) {
		logger.info(">> [CONTROLLER-MAIN] move to (personal) page");
		UserInfoDto linked = userInfoBiz.selectOne(user_distinct);
		int user_no =linked.getUser_no();
		logger.info(" User_no : " +user_no);
		session.setAttribute("linked", linked);
		
		

		Calendar cal = Calendar.getInstance();
		
		
		//logger.info(" sddsd: "+cal.get(Calendar.YEAR));
		
		//여기서 문제가 발생 => 이렇게 받으면 무조건 20201115,20201116이런식으로 문자열에 해당하는 값만 사용이 가능해짐
		//int mm = cal.get(Calendar.MONTH)+1;
		//int yyyy = cal.get(Calendar.YEAR);
		//int dd = cal.get(Calendar.DATE);
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH)+1;
		//int dd = cal.get(Calendar.DATE);
		
		String yyyyMM = year +CalendarUtils.isTwo(month+"");
		
		
		//logger.info(" *******caldate : "+cal.get(Calendar.DATE));
		logger.info(" *******yyyyMM : "+yyyyMM);
		//일단 주석
		//List<CalendarDto>clist = calBiz.getView(user_no);
		
		List<CalendarDto>clist = calBiz.getViewList(user_no,yyyyMM);
		
		model.addAttribute("clist",clist);
		
		
		
		
		return "finalactionpage";
	}
	
	@RequestMapping(value = "/tiwimap", method = RequestMethod.GET)
	public String tiwiMap(Model model) {
		return "tiwimap";
	}
	
}
