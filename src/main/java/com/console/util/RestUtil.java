package com.console.util;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;

public class RestUtil {
	public static String getRest(String url){  
        CloseableHttpClient httpclient = HttpClients.createDefault();    
        // 创建httpget     
        HttpGet httpget = new HttpGet(url);   
        httpget.setHeader(new BasicHeader("Content-Type", "application/json; charset=utf-8"));
        httpget.setHeader(new BasicHeader("Accept", "application/json;charset=utf-8"));
        try{  
            CloseableHttpResponse response = httpclient.execute(httpget);
            int code= response.getStatusLine().getStatusCode();  
            if(code==200 ||code ==204){
            	HttpEntity entity = response.getEntity();    
                String json= EntityUtils.toString(entity, "UTF-8");
                return json;  
            }
        }catch (Exception e){  
            e.printStackTrace();  
        }  
        return "";  
    }  
}
