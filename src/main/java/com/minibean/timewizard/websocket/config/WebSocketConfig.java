package com.minibean.timewizard.websocket.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Profile("stomp")
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// SockJS로 돌리기 위해 withSockJS()를 붙혀줌
		// setAllowedOrigins: 접근할 주소를 제한시킴 *는 제한없는듯함
		registry.addEndpoint("/webserver").setAllowedOrigins("*").withSockJS().setClientLibraryUrl("https://cdn.jsdelivr.net/sockjs/latest/sockjs.min.js");
	}
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		// TODO Auto-generated method stub
		registry.setApplicationDestinationPrefixes("/publish");
		
        registry.enableSimpleBroker("/subscribe");//subscribe
      }
}
