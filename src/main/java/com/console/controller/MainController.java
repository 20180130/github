package com.console.controller;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/main")
public class MainController {
	public static Log logger = LogFactory.getLog(LoginController.class);
	
	
	// 系统首页
	@RequestMapping("/first")
	//@RequiresPermissions("user:create")
	public String first(HttpSession session,Model model,String href) throws Exception {
		logger.debug(href);
		model.addAttribute("href", href);
		
		
		
		//User user = (User)session.getAttribute(Const.SESSION_USER);
			//user = userService.getUserAndRoleById(user.getUserId());
			//Role role = user.getRole();
			//String roleRights = role!=null ? role.getRights() : "";
		//	String userRights = user.getRights();
			//避免每次拦截用户操作时查询数据库，以下将用户所属角色权限、用户权限限都存入session
			//session.setAttribute(Const.SESSION_ROLE_RIGHTS, roleRights); //将角色权限存入session
			//session.setAttribute(Const.SESSION_USER_RIGHTS, userRights); //将用户权限存入session
			
	/*		List<Menu> menuList = menuService.listAllMenu();
			if(Tools.notEmpty(userRights) || Tools.notEmpty(roleRights)){
				for(Menu menu : menuList){
					menu.setHasMenu(RightsHelper.testRights(userRights, menu.getMenuId()) || RightsHelper.testRights(roleRights, menu.getMenuId()));
					if(menu.isHasMenu()){
						List<Menu> subMenuList = menu.getSubMenu();
						for(Menu sub : subMenuList){
							sub.setHasMenu(RightsHelper.testRights(userRights, sub.getMenuId()) || RightsHelper.testRights(roleRights, sub.getMenuId()));
						}
					}
				}
			}*/
			///model.addAttribute("user", user);
			//model.addAttribute("menuList", menuList);
			//homePage = "first.jsp";
		
		
		
		
		
		
		
		
		return "first";
	}
	
	
}
