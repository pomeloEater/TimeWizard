package com.minibean.timewizard.common.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {
	Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("[LogingInterceptor]:prehandle");
		
		//아래 조건일때만 controller로 넘어갑니다.
		if(	request.getRequestURI().contains("/login/loginform")||
			request.getRequestURI().contains("/login/ajaxlogin") || 
			request.getRequestURI().contains("/login/navercallback") || 
			request.getRequestURI().contains("/login/googlecallback") || 
			request.getRequestURI().contains("/login/kakaocallback") || 
			request.getRequestURI().contains("/login/snssignup") || 
			request.getRequestURI().contains("/login/signupresult") || 
			request.getRequestURI().contains("/login/kakaosuccess") ||
			request.getRequestURI().contains("/login/emailSend") ||
			request.getRequestURI().contains("/user/*") || 
			request.getRequestURI().contains("/error") || 
			request.getRequestURI().contains("/mypage")||
			request.getRequestURI().contains("/findform") ||
			request.getRequestURI().contains("/findID") ||
			request.getRequestURI().contains("/findPW") ||
			request.getRequestURI().contains("/resources") ||
			request.getSession().getAttribute("login")!=null) {
			
			return true;
		}
		
		//session에 값이 없으면,
		if(request.getSession().getAttribute("login")==null) {
			response.sendRedirect("/timewizard/login/loginform");
			return false;
		}
		
		return false;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) {
		logger.info("[LoginInterceptor] : postHandle");
		
		if(modelAndView != null) {
			logger.info(modelAndView.getViewName());
		}
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		logger.info("[LoginInterceptor] : afterCompletion");
	}
}
