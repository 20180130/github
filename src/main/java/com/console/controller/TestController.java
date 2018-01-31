package com.console.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.exception.JsonInvalidException;
import com.console.utill.HttpUtil;
import com.console.utill.HttpUtil.HttpResponse;



@Controller
@RequestMapping(value="/testhttp")
public class TestController {
	public static Log logger = LogFactory.getLog(TestController.class);
	/**
	 * 显示角色列表
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/index",method=RequestMethod.GET)
	public String list(){
		return "test.jsp";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/getDistribuList", method = { RequestMethod.GET}, produces = "application/json; charset=utf-8")
	public Object getDistribuList() {
		//构建返回结果
		String params = null;
	/*	try {
			params = fogMessageService.sendTrafficEvent(rangeName, carID, startLng, startLat, endLng,endLat,state,eventTime);
		} catch (Exception e) {
			log.info("参数错误,异常交通消息下发异常!");
		}*/
		
	
		JSONArray jsonarry=new JSONArray();
		JSONObject aa1=new JSONObject();
		
		JSONObject aa2=new JSONObject();
		JSONObject aa3=new JSONObject();
		//JSONObject aa4=new JSONObject()
		aa1.put("id", "001");
		aa1.put("text", "天津市");
		aa3.put("id", "002");
		aa3.put("text",  "重庆市");
		jsonarry.add(aa1);
		jsonarry.add(aa3);
		
		return jsonarry;
	}
	
	
	
	
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
	
	
	
	@ResponseBody
	@RequestMapping(value = "/getRoadList", method = { RequestMethod.GET})
	public Object getRoadList() {
		//构建返回结果
		
		List<String> strategylist = new ArrayList<String>();
		//final String url = getUrl(permbaseurl + "/imaUser/getPermissions.do", map);
		String url="http://192.168.10.119:8888/RoadSys/getRoadList";
		//HttpResponse  responsse=HttpUtil.execute(HttpMethod.GET, url, null, null);
		
		
	/*	int statuscode=responsse.getStatusCode();
		if (statuscode!=200) {
			throw new JsonInvalidException("接口异常");
		}*/
	//	JSONObject mapreult = JSONObject.parseObject(responsse.getBody());
		//JSONObject datajson = mapreult.getJSONObject("data");
		/*if (datajson == null) {
			throw new JsonInvalidException("接口异常");
		}*/
		//String functionCodes = datajson.getString("privalageCheckList");
	/*	if (functionCodes != null && !functionCodes.trim().equals("")) {
			String functionCode[] = functionCodes.split(",");
			for (String fund : functionCode) {
				strategylist.add(fund.trim());
			}
		}
		*/
		
		
		
		return null;
	}
/*	
	
    private JSONObject dealResult(HttpServletResponse response, HttpResponse result) throws IOException {
    	logger.info("dealResult, response->{}"+ result);
    	if(result.isSuccess()) {
    		ResponseUtil.sendJsonNoCache(response, result.getBody());
    	} else {
    		try{
    			String json = result.getBody();
    			JSONObject jsonob=JSONObject.parseObject(json);
    			JSONObject jsonob=new JSONObject();
    			JSONObject.
    			jsonob.getJSONObject(json);
    		//	Map map = JSONObject..parse(json, Map.class);
    			//String code = String.valueOf(map.get("code"));
    			//response.setStatus(Integer.valueOf(code));
        		//ResponseUtil.sendJsonNoCache(response, jsonob);
    			
    			return jsonob;
    		} catch(Exception e) {
    			logger.error("dealResult error", e);
    		}
    	}
    }*/
}
