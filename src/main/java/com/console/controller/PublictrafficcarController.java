package com.console.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
/**
 * 
 * @Description: 公交管理系统
 * @author malongcheng 
 * @date 2018年1月24日
 *
 */

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.util.RestUtil;
import com.console.vo.ApiReturn;
@Controller
@RequestMapping("publictrafficcar")
public class PublictrafficcarController {
	public static Log logger = LogFactory.getLog(PublictrafficcarController.class);
	
	@Value("${selectUsingBusUrl}")
	private String selectUsingBusUrl;
	
	@Value("${selectUsedBusUrl}")
	private String  selectUsedBusUrl;
	
	@Value("${selectTuoCheUrl}")
	private String  selectTuoCheUrl;
	
	@Value("${submitTuoCheUrl}")
	private String submitTuoCheUrl;
	
	@Value("${submitReplaceBusUrl}")
	private String submitReplaceBusUrl;
	
	@Value("${selectAllPointUrl}")
	private String selectAllPointUrl;
	
	@RequestMapping("/show")
	@ResponseBody
	public ModelAndView show(HttpServletRequest request) {
		return new ModelAndView("main/publictrafficcar");
	}
	
	/**
	 * 
	 * @Description:查询替换车辆
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/selectUsingBus")
	@ResponseBody
	public ApiReturn selectUsingBus(){
		logger.info("查询可使用车辆 ----请求成功！");
		String url = selectUsingBusUrl;
		String rest = RestUtil.getRest(url);
		//String rest = "{\"code\":200,\"info\":\"通啦\",\"obj\":[{\"publicid\":4,\"companyid\":1,\"cityid\":1,\"busid\":52,\"state\":1,\"roadid\":null},{\"publicid\":6,\"companyid\":1,\"cityid\":1,\"busid\":null,\"state\":1,\"roadid\":null}]}";
		logger.info(rest);
		boolean success = false;
		String info = "请求失败!";
		String obj = null;
		if(rest!=null && rest.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			if(code==200){
				obj = restMap.get("obj")+"";
				if(obj.contains("publicid")){
					obj = obj.replace("publicid", "id");
				}
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,obj);
	}
	
	/**
	 * 
	 * @Description:查询当前事故点查询正在使用的应急公交
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/selectUsedBus")
	@ResponseBody
	public ApiReturn selectUsedBus(@RequestBody JSONObject jsonObject){
		
		String pointId =jsonObject.get("pointId")+"";
		logger.info("查询当前事故点查询正在使用的应急公交----请求成功！  "+pointId);
		String url = selectUsedBusUrl+"?id="+pointId;
		String rest = RestUtil.getRest(url);
		//String rest = "{\"code\":200,\"info\":\"通啦\",\"obj\":[{\"publicid\":4,\"companyid\":1,\"cityid\":1,\"busid\":60,\"state\":2,\"roadid\":null}]}";
		
		logger.info(rest);
		boolean success = false;
		String info = "请求失败!";
		String obj = null;
		if(rest!=null && rest.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			if(code==200){
				obj = restMap.get("obj")+"";
				if(obj.contains("publicid")){
					obj = obj.replace("publicid", "id");
				}
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,obj);
	}
	
	/**
	 * 
	 * @Description:查询拖车
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/selectTuoChe")
	@ResponseBody
	public ApiReturn selectTuoChe(){
		logger.info("查询拖车-----请求成功！");
		String url = selectTuoCheUrl;
		String rest = RestUtil.getRest(url);
		//String rest = "{\"code\":200,\"info\":\"通啦\",\"obj\":[{\"trailerid\":2,\"companyid\":1,\"cityid\":1,\"busid\":null,\"stateid\":1,\"roadid\":18},{\"trailerid\":4,\"companyid\":1,\"cityid\":1,\"busid\":null,\"stateid\":1,\"roadid\":null}]}";
		logger.info(rest);
		boolean success = false;
		String info = "请求失败!";
		String obj = null;
		if(rest!=null && rest.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			if(code==200){
				obj = restMap.get("obj")+"";
				if(obj.contains("trailerid")){
					obj = obj.replace("trailerid", "id");
				}
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,obj);
	}
	
	/**
	 * 
	 * @Description:拖车确认选择
	 * @param jsonObject
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/submitTuoChe")
	@ResponseBody
	public ApiReturn submitTuoChe(@RequestBody JSONObject jsonObject){
		String tuocheId = (String) jsonObject.get("tuocheId");
		logger.info("拖车确认选择---------"+tuocheId);
		String url = submitTuoCheUrl+"?trailerId="+tuocheId;
		String rest = RestUtil.getRest(url);
		//String rest = "true";
		logger.info(rest);
		boolean success = false;
		String info = "操作失败！";
		if(rest!=null&&rest.length()>0){
			if("true".equals(rest)){
				success = true;
				info = "操作成功！";
			}
		}
		return new ApiReturn(success,info);
	}
	
	/**
	 * 
	 * @Description:替换车辆确认选择
	 * @param jsonObject
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/submitReplaceBus")
	@ResponseBody
	public ApiReturn submitReplaceBus(@RequestBody JSONObject jsonObject){
		String busId = jsonObject.get("busId")+"";
		String pointId =jsonObject.get("pointId")+"";
		logger.info("替换车辆确认选择-------------busId="+busId+"-----pointId="+pointId);
		String url = submitReplaceBusUrl+"?publicId2="+busId+"&id="+pointId;
		String rest = RestUtil.getRest(url);
		//String rest = "true";
		System.err.println(rest);
		logger.info(rest);
		boolean success = false;
		String info = "操作失败！";
		if(rest!=null&&rest.length()>0){
			if("true".equals(rest)){
				success = true;
				info = "操作成功！";
			}
		}
		return new ApiReturn(success,info);
	}
	
	@RequestMapping("/selectAllPoint")
	@ResponseBody
	public ApiReturn selectAllPoint(){
		
		String url = selectAllPointUrl;
		String rest = RestUtil.getRest(url);
		//String rest ="{\"code\":200,\"info\":\"通啦\",\"obj\":[{\"id\":6,\"eventlng\":111.000000,\"eventlat\":151.000000,\"busid\":\"11\",\"rescuebusid\":null,\"eventnum\":\"111\",\"eventtype\":\"11\",\"roadid\":null,\"state\":0},{\"id\":7,\"eventlng\":222.000000,\"eventlat\":252.000000,\"busid\":\"22\",\"rescuebusid\":\"22\",\"eventnum\":\"22\",\"eventtype\":\"22\",\"roadid\":\"22\",\"state\":1}]}";
		logger.info(rest);
		boolean success = false;
		String info = "请求失败!";
		String obj = null;
		if(rest!=null && rest.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			if(code==200){
				obj = restMap.get("obj")+"";
				if(obj.contains("eventlng")){
					obj = obj.replace("eventlng", "top");
				}
				if(obj.contains("eventlat")){
					obj =obj.replace("eventlat", "left");
				}
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,obj);
	}
	
	@RequestMapping("/selectTwoStatus")
	@ResponseBody
	public ApiReturn selectTwoStatus(@RequestBody JSONObject jsonObject){
		String pointId = (String) jsonObject.get("pointId");
		/*String url = "http://192.168.11.55:8080/ambulance/api/ambulance/selectABusByABId?id="+pointId;
		logger.info(url);
		String rest = RestUtil.getRest(url);
		logger.info(rest);
		String url1 = "http://192.168.11.55:8080/ambulance/api/ambulance/selectJStopByABId?id="+pointId;
		logger.info(url1);
		String rest1 = RestUtil.getRest(url1);
		logger.info(rest1);*/
		
		
		
		return new ApiReturn(false,"请求失败",null);
	}
	
}
