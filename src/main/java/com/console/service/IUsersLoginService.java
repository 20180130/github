package com.console.service;

import java.util.Map;

public interface IUsersLoginService {
	
	/**
	 * @Description:根据用户邮箱密码查询是否存在该用户
	 * @param eMail 邮箱
	 * @param password 密码
	 * @return
	 * Boolean
	 */
	public Boolean selectByEmail(String email , String password);
	
	public Map<String, Object> loginAtct(String email, String pwd , String token);
}
