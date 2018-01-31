package com.console.utill;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.StatusLine;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;

public class HttpUtil {
	
	private static CloseableHttpClient httpClient;
	
	private  static Logger logger = LoggerFactory.getLogger(HttpUtil.class);
	
	static {
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(600000).setConnectTimeout(120000).build();
		PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager();
		httpClient = HttpClients.custom().setConnectionManager(connectionManager).setDefaultRequestConfig(requestConfig).build();
	}

	private static CloseableHttpClient getHttpClient(){
		return httpClient;
	}
	
	private static HttpResponse execute(HttpRequestBase httpWhat){
		CloseableHttpClient httpclient = getHttpClient();
		CloseableHttpResponse response = null;
		try {
			response = httpclient.execute(httpWhat);
			StatusLine line = response.getStatusLine();
			HttpEntity entity = response.getEntity();
			String html = EntityUtils.toString(entity, "UTF-8");
			logger.debug("url->{}, body->{}", httpWhat.getURI(), html);
			return new HttpResponse(line.getStatusCode(), html);
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					logger.error("response close error", e);
				}
			}
		}
	}
	
	public static HttpResponse execute(HttpMethod method, String url, Map<String, String> header, String body){
		logger.debug("execute {} {} body->{}", new Object[]{method.name(), url, body});
		HttpRequestBase httpWhat = getHttpRequest(method, url, body);
		httpWhat.addHeader("Content-Type", "application/json");
		if(header != null && !header.isEmpty()) {
			addHeader(httpWhat, header);
		}
		return execute(httpWhat);
	}
	
	private static HttpRequestBase getHttpRequest(HttpMethod method, String url, String body){
		switch(method) {
		    case POST:
		    	HttpPost post = new HttpPost(url);
		    	if(body != null) {
		    		post.setEntity(getHttpEntity(body));
		    	}
			    return post;
		    case PUT:
		    	HttpPut put = new HttpPut(url);
		    	if(body != null) {
		    		put.setEntity(getHttpEntity(body));
		    	}
			    return put;
		    case PATCH:
		    	HttpPatch patch = new HttpPatch(url);
		    	if(body != null) {
		    		patch.setEntity(getHttpEntity(body));
		    	}
			    return patch;
		    case DELETE:
		    	MyHttpDelete delete = new MyHttpDelete(url);
		    	if(body != null) {
		    		delete.setEntity(getHttpEntity(body));
		    	}
			    return delete;
		    case GET:
		    	HttpGet get = new HttpGet(url);
		    	return get;
		    default:
		    	throw new RuntimeException("unsupported method" + method.name());
		}
	}
	
	private static void addHeader(HttpRequestBase request, Map<String, String> header) {
		if(header != null && !header.isEmpty()) {
			Iterator<String> it = header.keySet().iterator();
			while(it.hasNext()) {
				String key = it.next();
				String value = header.get(key);
				request.addHeader(key, value);
			}
		}
	}
	
	private static HttpEntity getHttpEntity(String json) {
		return new StringEntity(json, ContentType.APPLICATION_JSON);
	}
	
	public static class HttpResponse {
		
		private int statusCode;
		
		private String body;
		
		public HttpResponse(int statusCode, String body){
			this.statusCode = statusCode;
			this.body = body;
		}

		public int getStatusCode() {
			return statusCode;
		}

		public void setStatusCode(int statusCode) {
			this.statusCode = statusCode;
		}

		public String getBody() {
			return body;
		}

		public void setBody(String body) {
			this.body = body;
		}
		
		public boolean isSuccess(){
			if(this.statusCode >= 200 && this.statusCode < 300) {
				return true;
			} else {
				return false;
			}
		}
		
		@Override
		public String toString(){
			return this.body;
		}
	}
	
}
