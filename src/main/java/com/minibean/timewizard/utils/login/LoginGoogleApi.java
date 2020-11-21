package com.minibean.timewizard.utils.login;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class LoginGoogleApi extends DefaultApi20 {

    protected LoginGoogleApi() {}

    private static class InstanceHolder {
        private static final LoginGoogleApi INSTANCE = new LoginGoogleApi();
    }

    public static LoginGoogleApi instance() {
        return InstanceHolder.INSTANCE;
    }

    @Override
    public String getAccessTokenEndpoint() {
        return "https://oauth2.googleapis.com/token?grant_type=authorization_code";
    }

    @Override
    protected String getAuthorizationBaseUrl() {
        return "https://accounts.google.com/o/oauth2/v2/auth";
    }

}
