package org.ict.naver;

import com.github.scribejava.core.builder.api.DefaultApi20;

// NAVER Login API와 연동을 위해 DefaultApi20을 상속한 NaverLoginApi 클래스 생
public class NaverLoginApi extends DefaultApi20{
	
	protected NaverLoginApi() {
		
	}
	
	private static class InstanceHolder{
		private static final NaverLoginApi INSTANCE = new NaverLoginApi();
	}
	
	public static NaverLoginApi instance() {
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
