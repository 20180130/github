package com.console.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.console.util.CookieUtils;
import com.console.util.JedisUtil;

import redis.clients.jedis.Jedis;


public class LoginInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean broken = false;
		boolean flag = false;
		String handlerValue = handler.toString();
		System.err.println(handlerValue);
		Jedis jedis = JedisUtil.getInstance().getJedis();
		String token = CookieUtils.getCookieValue(request, "token", true);
		String email = CookieUtils.getCookieValue(request, "userid", true);
		if(token!=null&&token.length()>0&&email!=null&&email.length()>0){
			try {
				Boolean exists = jedis.exists(email);
				if(exists){
					String jedisToken = jedis.get(email);
					if(token.equals(jedisToken)){
						flag = true;
					}
				}
			} catch (Exception e) {
				broken = true;
			}finally {
				JedisUtil.returnJedis(jedis , broken);
			}
		}
		System.err.println(flag);
		if(!flag){
			response.sendRedirect("/Console/");
		}
		return flag;
	}
}
