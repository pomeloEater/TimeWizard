package com.minibean.timewizard.utils.login;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class LoginNaverApi extends DefaultApi20 {
	
	/* scribejava 용 naver login 구현체 */
	protected LoginNaverApi() {}
	
	private static class InstanceHolder{
		private static final LoginNaverApi INSTANCE = new LoginNaverApi();
	}
	
	public static LoginNaverApi instance() {
		return InstanceHolder.INSTANCE;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return "https://nid.naver.com/oauth2.0/authorize";
	}
	
}
