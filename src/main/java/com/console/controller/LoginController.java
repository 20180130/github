package com.console.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.console.pojo.SysUsers;
import com.console.service.IUsersLoginService;
import com.console.util.CookieUtils;
import com.console.util.JedisUtil;
import com.console.vo.ApiReturn;

import redis.clients.jedis.Jedis;




@Controller
@RequestMapping("/login")
public class LoginController {
	public static Log logger = LogFactory.getLog(LoginController.class);
	@Resource
	private IUsersLoginService userLoginService;
	@RequestMapping
	public ModelAndView show(HttpServletRequest request) {
		//request.setAttribute("type", type);
		return new ModelAndView("login/login");
	}
	
	@RequestMapping("/showManoeuvreconsole")
	public ModelAndView showManoeuvreconsole(HttpServletRequest request) {
		//request.setAttribute("type", type);
		System.err.println("rescuemanagecar");
		return new ModelAndView("main/manoeuvreconsole");
	}
	
	
	
	/**
	 * 
	 * @Description:  登陆 并跳转
	 * @param sysUsers
	 * @return
	 * ApiReturn
	 * @exception:
	 * @author: malongcheng
	 * @time:2018年1月5日
	 */
	@RequestMapping("/selectLoginUser")
	public @ResponseBody ApiReturn selectLoginUser(HttpServletRequest request,HttpServletResponse response, SysUsers sysUsers){
		String email = sysUsers.getEmail();
		String password = sysUsers.getPassword();
		String token = CookieUtils.getCookieValue(request, email, true);
		System.out.println("cookieValue=========="+token);
		System.out.println("email==="+email+"==password=="+password);
		Map<String, Object> loginAtct = userLoginService.loginAtct(email,password ,token);
		Boolean success = (Boolean)loginAtct.get("success");
		if(success){
			CookieUtils.setCookie(request, response, "token", loginAtct.get(email).toString());
			CookieUtils.setCookie(request, response, "userid", email);
			return new ApiReturn(success);
		}else{
			return new ApiReturn(success);
		}
	}
	
	
	@RequestMapping("/skip")
	public @ResponseBody ModelAndView skip(@RequestParam Boolean bool){
			return new ModelAndView("redirect:/");
	}
	
	@RequestMapping("/success.do")
	public @ResponseBody ModelAndView success(){
		return new ModelAndView("main/mancount");
	}
	
	@RequestMapping("/selectLoginRest")
	public @ResponseBody String selectLoginRest(HttpServletRequest request , @RequestParam String email , @RequestParam String pwd){
		Boolean success = userLoginService.selectByEmail(email, pwd);
		String json = "{\"success\":"+success+"}";
		return json;
	}
	@RequestMapping("/logout")
	public @ResponseBody ModelAndView logout(HttpServletRequest request , HttpServletResponse response){
		String token = CookieUtils.getCookieValue(request, "token", true);
		String email = CookieUtils.getCookieValue(request, "userid", true);
		Jedis jedis = JedisUtil.getInstance().getJedis();
		Boolean exists = jedis.exists(email);
		ApiReturn apiReturn = new ApiReturn();
		if(exists){
			jedis.del(email);
		}
		return new ModelAndView("redirect:/");
	}
}
