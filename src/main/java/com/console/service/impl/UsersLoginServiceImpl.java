package com.console.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.console.dao.SysUsersMapper;
import com.console.pojo.SysUsers;
import com.console.service.IUsersLoginService;
import com.console.util.CryptUtils;
import com.console.util.JedisUtil;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.exceptions.JedisException;

@Service
public class UsersLoginServiceImpl implements IUsersLoginService{
	
	@Resource
	private SysUsersMapper sysUsersMapper;
	
	@Override
	public Boolean selectByEmail(String email , String password) {
		Boolean flag = false;
		if(email!=null && email.trim().length()>0 
				&& password !=null && password.trim().length()>0){
			SysUsers sysUsers = sysUsersMapper.selectByEmail(email);
			if(sysUsers!=null){
				try {
					String code = CryptUtils.GetMD5Code(sysUsers.getPassword());
					if(password.equals(code)){
						flag = true;
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return flag;
	}
	@Override
	public Map<String, Object> loginAtct(String email, String pwd , String token) {
		boolean broken = false;
		Jedis jedis = JedisUtil.getInstance().getJedis();
		Map<String,Object> hashMap = new HashMap<String , Object>();
		try {
			if(token!=null&&token.length()>0){
				System.err.println("token不为空=============");
				Boolean exists = jedis.exists(email);
				if(exists){
					System.err.println("token存在redis缓存=============");
					String jedisToken = jedis.get(email);
					if(token.equals(jedisToken)){
						hashMap.put("success", true);
						hashMap.put(email, token);
						System.err.println("token匹配成功=============");
					}else{
						System.err.println("token匹配不成功==============");
						hashMap = LoginAtct(hashMap,jedis,email,pwd);
					}
				}else{
					System.err.println("token不存在redis缓存=============");
					hashMap = LoginAtct(hashMap,jedis,email,pwd);
				}
			}else{
				System.err.println("token为空=============");
				hashMap = LoginAtct(hashMap,jedis,email,pwd);
			}
			return hashMap;
		}catch (JedisException e) {
			e.printStackTrace();
			broken = true;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JedisUtil.returnJedis(jedis , broken);
		}
		return null;
	}
	
	public Map<String, Object> LoginAtct(Map<String, Object> hashMap,Jedis jedis, String email, String pwd) throws JedisException ,JsonParseException, JsonMappingException, IOException{
		Boolean success = selectByEmail(email,pwd);
		if(success){
			String token = UUID.randomUUID().toString().replace("-", "");
			String set = jedis.set(email, token);
			if(set.equals("OK")){
				hashMap.put("success", true);
				hashMap.put(email, token);
				System.err.println("success=========true&&&&&token="+token);
			}else{
				System.err.println("success=========true&&&&&redis缓存token失败！！！");
			}
		}else{
			hashMap.put("success", false);
			hashMap.put("token", null);
			System.err.println("success=========false&&&&&token=null");
		}
		return hashMap;
	}
}
