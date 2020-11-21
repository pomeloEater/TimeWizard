package com.minibean.timewizard.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogFilter implements Filter {

	private Logger logger = LoggerFactory.getLogger(LogFilter.class);
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		String remoteAddr = req.getRemoteAddr();
		String uri = req.getRequestURI();
		String url = req.getRequestURL().toString();
		String queryString = req.getQueryString();
		
		String referer = req.getHeader("referer");
		String userAgent = req.getHeader("User-Agent");
		
		StringBuffer sb = new StringBuffer();
		sb.append("\n\t* remoteAddr : " + remoteAddr + "\n")
		.append("\t* URI : " + uri + "\n")
		.append("\t* URL : " + url + "\n")
		.append("\t* queryString : " + queryString + "\n")
		.append("\t* referer : " + referer + "\n")
		.append("\t* userAgent : " + userAgent);
		
		logger.info("[LOG Filter]"+sb);
		
		chain.doFilter(req, response);
		
	}
	
	@Override
	public void destroy() {
		
	}

}