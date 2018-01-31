package com.console.controller;


import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.console.service.IUsersLoginService;

@Controller
@RequestMapping("/api")
public class ApiController {
	
	@Resource
	private IUsersLoginService userLoginService;
	
	@RequestMapping("/loginRest")
	public @ResponseBody String selectLoginRest(@RequestParam String email , @RequestParam String pwd, @RequestParam String token ){
		
		Boolean bool = userLoginService.selectByEmail(email, pwd);
		return null;
	}
}
