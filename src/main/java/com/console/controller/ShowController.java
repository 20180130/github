package com.console.controller;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.console.util.RestUtil;
import com.console.vo.ApiReturn;

@Controller
@RequestMapping("show")
public class ShowController {
	public static Log logger = LogFactory.getLog(ShowController.class);
	
	public static boolean isStart = false;
	
	public static boolean mistIsStart = false;
	@Value("${startShowUrl}")
	private String startShowUrl;
	@Value("${stopShowUrl}")
	private String stopShowUrl;
	@Value("${mistStartShowUrl}")
	private String mistStartShowUrl;
	@Value("${mistStopShowUrl}")
	private String mistStopShowUrl;
	
	/**
	 * 
	 * @Description:演示开始
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月24日
	 */
	@RequestMapping("/startShow")
	@ResponseBody
	public ApiReturn startShow(){
		if(isStart){
			logger.info("演示已开始，不需要再次开始");
			return new ApiReturn(false);
		}
		String url = startShowUrl+"?type=start";
		String rest = RestUtil.getRest(url);
		Map maps = (Map)JSON.parse(rest); 
		String code = (String)maps.get("code");
		if("0".equals(code)){
			logger.info("演示开始");
			isStart = true;
			return new ApiReturn(true);
		}else{
			logger.error("演示开始出错");
			return new ApiReturn(false);
		}
	}
	
	/**
	 * 
	 * @Description:演示结束事件
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月24日
	 */
	@RequestMapping("/stopShow")
	@ResponseBody
	public ApiReturn stopShow(){
		String url = stopShowUrl+"?type=stop";
		String rest = RestUtil.getRest(url);
		Map maps = (Map)JSON.parse(rest); 
		String code = (String)maps.get("code");
		if("0".equals(code)){
			logger.info("演示结束");
			isStart = false;
			mistIsStart = false;
			return new ApiReturn(true);
		}else{
			logger.error("演示结束出错");
			return new ApiReturn(false);
			
		}
	}
	
	/**
	 * 
	 * @Description:查询是否已经开始
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月24日
	 */
	@RequestMapping("/getShowStatus")
	@ResponseBody
	public ApiReturn getShowStatus(){
		boolean success = true;
		String info = "请求成功！";
		String obj = null;
		if(isStart){
			if(mistIsStart){
				obj = "{\"isStart\":\"true\",\"mistIsStart\":\"true\"}";
			}else{
				obj = "{\"isStart\":\"true\",\"mistIsStart\":\"false\"}";
			}
		}else{
			obj = "{\"isStart\":\"false\",\"mistIsStart\":\"false\"}";
		}
		return new ApiReturn(success,info,obj);
	}
	
	/**
	 * 
	 * @Description:模拟雾开始事件
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月24日
	 */
	@RequestMapping("/mistStartShow")
	@ResponseBody
	public ApiReturn mistStartShow(){
		
		if(mistIsStart){
			logger.info("模拟雾已开始模拟，不需要再次开始");
			return new ApiReturn(false);
		}
		String rangeName="五道口";
		String startLng = "90";
		String startLat="335";
		String endLng="1320";
		String endLat="800";
		String eventState="1001";
		String url = mistStartShowUrl+"?rangeName=" + rangeName + "&startLng="
				+ startLng + "&startLat=" + startLat + "&endLng=" + endLng + "&endLat=" + endLat+"&eventState="+eventState;
		
		String rest = RestUtil.getRest(url);
		Map maps = (Map)JSONArray.parse(rest); 
		String code = maps.get("code")+"";
		if("200".equals(code)){
			logger.info("模拟雾开始");
			mistIsStart = true;
			return new ApiReturn(true,"操作成功！");
		}else{
			logger.error("模拟雾开始出错");
			return new ApiReturn(false,"操作失败！");
		}
	}
	
	/**
	 * 
	 * @Description:模拟雾结束事件
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月24日
	 */
	@RequestMapping("/mistStopShow")
	@ResponseBody
	public ApiReturn mistStopShow(){
		String rangeName="五道口";
		String startLng = "90";
		String startLat="335";
		String endLng="1320";
		String endLat="800";
		String eventState = "1002";
		String url = mistStopShowUrl+"?rangeName=" + rangeName + "&startLng="
				+ startLng + "&startLat=" + startLat + "&endLng=" + endLng + "&endLat=" + endLat+"&eventState="+eventState;
		
		String rest = RestUtil.getRest(url);
		Map maps = (Map)JSONArray.parse(rest); 
		String code = maps.get("code")+"";
		if("200".equals(code)){
			logger.info("模拟雾结束");
			mistIsStart = false;
			return new ApiReturn(true,"操作成功！");
		}else{
			logger.error("模拟雾结束出错");
			return new ApiReturn(false,"操作失败！");
		}
	} 
	
	
	public static void main(String[] args) {
		ShowController showController = new ShowController();
		showController.mistStartShow();
	}
}
