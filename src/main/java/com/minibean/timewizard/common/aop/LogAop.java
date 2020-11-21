package com.minibean.timewizard.common.aop;

import org.aspectj.lang.JoinPoint;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogAop {
	
	public void beforeLog(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		
		logger.info("---AOP START---");
		
		Object[] args = join.getArgs();
		if(args != null) {
			logger.info("method : "+join.getSignature().getName());
			for(int i=0; i<args.length ; i++) {
				logger.info(i+"번째 : "+args[i]);
			}
		}
		
	}
	
	public void afterLog(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		logger.info("---AOP END---");
		
	}
	
	public void afterThrowingLog(JoinPoint join) {
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		logger.info("---AOP ERROR LOG---");
		logger.info("ERROR : "+join.getArgs());
		logger.info("ERROR : "+join.toString());
	}

}
