package com.console.dao;

import com.console.pojo.SysUsers;
/**
 * 
 * @ClassName: SysUsersMapper 
 * @Description: 用户信息相关接口
 * @author malongcheng 
 * @date 2018年1月5日
 *
 */
public interface SysUsersMapper {
	
	int deleteByPrimaryKey(Integer id);

    int insert(SysUsers sysUsers);

    int insertSelective(SysUsers sysUsers);

    SysUsers selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysUsers sysUsers);

    int updateByPrimaryKey(SysUsers sysUsers);
    
    SysUsers selectByEmail(String eMail);
}