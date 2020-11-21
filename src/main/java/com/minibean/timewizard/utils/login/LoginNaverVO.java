package com.minibean.timewizard.utils.login;

import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

@Component
public class LoginNaverVO {

	/* 인증 요청문 구성 파라미터
	 * client_id : 애플리케이션 등록 후 발급받는 클라이언트 아이디
	 * response_type : 인증 과정에서의 구분값, code로 값이 고정
	 * redirect_uri : 네이버 로그인 인증 결과를 전달받을 콜백 URL.
	 * 				애플리케이션 등록 시 등록한 주소
	 * state : 애플리케이션이 생성한 상태 토큰
	 */
	private final static String CLIENT_ID = "4iXT347PPGkmH6OSJkN2";
	private final static String CLIENT_SECRET = "gOJT6tWDgW";
//	private final static String REDIRECT_URI = "http://localhost:8787/timewizard/login/navercallback";
//	private final static String REDIRECT_URI = "https://localhost:8443/timewizard/login/navercallback";
	private final static String REDIRECT_URI = "https://qclass.iptime.org:8443/timewizard/login/navercallback";
	private final static String SESSION_STATE = "oauth_state_n";
	// 프로필 조회 API URL
	private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
	
	private Logger logger = LoggerFactory.getLogger(LoginNaverVO.class);
	
	/* 네아로 인증 URL 생성 Method */
	public String getAuthorizationUrl(HttpSession session) {
		
		// 세션 유효성 검증을 위한 난수 생성 후 session에 저장
		String state = generateRandomString();
		setSession(session, state);
		logger.info("\n[naver] * state : " + state + "\n* session state : "  + getSession(session));
		
		/*
		 * // scrive-java가 제공하는 인증 URL 생성 기능으로 네아로 인증 URL 생성 후 리턴 
		 * OAuth20Service oauthService = new ServiceBuilder()
		 *  .apiKey(CLIENT_ID)
		 *	.apiSecret(CLIENT_SECRET)
		 *  .callback(REDIRECT_URI)
		 * 	.state(state)
		 *	.build(LoginNaverApi.instance());
		 *	return oauthService.getAuthorizationUrl();
		 */
		
		OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(LoginNaverApi.instance());
		
		return oauthService.getAuthorizationUrl(state);
		
	}
	
	/* 네아로 callback 처리 및 AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException {
		
		// callback으로 전달받은 세션 검증용 난수와 세션에 저장되어 있는 난수값 비교
		String sessionState = getSession(session);
		if(StringUtils.pathEquals(sessionState, state)) {
			/* 3.3.0
			 * OAuth20Service oauthService = new ServiceBuilder()
			 * .apiKey(CLIENT_ID)
			 * .apiSecret(CLIENT_SECRET)
			 * .callback(REDIRECT_URI)
			 * .state(state)
			 * .build(LoginNaverApi.instance());
			 * // scribejava의 AccessToken 획득 기능으로 네아로 AccessToken 획득
			 * OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			 * return accessToken;
			 */
			
			OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
					.apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI)
					.build(LoginNaverApi.instance());
			return oauthService.getAccessToken(code);
		}
		return null;
	}
	
	/* AccessToken을 이용하여 네이버 사용자 프로필 API 호출 */
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException {
		/*
		 * OAuth20Service oauthService = new ServiceBuilder()
		 * .apiKey(CLIENT_ID)
		 * .apiSecret(CLIENT_SECRET)
		 * .callback(REDIRECT_URI)
		 * .build(LoginNaverApi.instance());
		 * OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		 * oauthService.signRequest(oauthToken, request);
		 * Response response = request.send();
		 * return response.getBody();
		 */
		OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.build(LoginNaverApi.instance());
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL);
		oauthService.signRequest(oauthToken, request);
		Response response = oauthService.execute(request);
		return response.getBody();
	}
	
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}
}
