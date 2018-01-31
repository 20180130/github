package com.console.pojo;
/**
 * 
 * @ClassName: SysUsers 
 * @Description: 用户信息
 * @author malongcheng 
 * @date 2018年1月5日
 *
 */
public class SysUsers {

	private Integer id;
	//邮箱
    private String email;
    //密码
    private String password;
    
    private String token;
    //说明
    private String explain;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}

    
    
}