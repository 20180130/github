package com.console.controller;

import java.util.ArrayList;
import java.util.List;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.util.RestUtil;
import com.console.vo.ApiReturn;

@Controller
@RequestMapping("/rescue")
public class RescueController {
	@Value("${selectTableInfoUrl1}")
	private String selectTableInfoUrl1;
	
	@Value("${selectTableInfoUrl2}")
	private String selectTableInfoUrl2;
	
	@Value("${selectUnderwayInfoUrl1}")
	private String selectUnderwayInfoUrl1;
	
	@Value("${selectUnderwayInfoUrl2}")
	private String selectUnderwayInfoUrl2;
	
	@Value("${busDispatchUrl}")
	private String busDispatchUrl;
	
	@Value("${selectRescuePointUrl}")
	private String selectRescuePointUrl;
	
	public static Log logger = LogFactory.getLog(RescueController.class);
	
	@RequestMapping("/show")
	public ModelAndView showRescuemanagecar(HttpServletRequest request) {
		//request.setAttribute("type", type);
		return new ModelAndView("main/rescuemanagecar");
	}
	
	@RequestMapping("/selectTableInfo")
	public @ResponseBody ApiReturn selectTableInfo(){
		
		String url = selectTableInfoUrl1;
		logger.info(url);
		String rest = RestUtil.getRest(url);
		logger.info(rest);
		String url1 = selectTableInfoUrl2;
		logger.info(url1);
		String rest1 = RestUtil.getRest(url1);
		logger.info(rest1);
		ApiReturn apiReturn = new ApiReturn();
		apiReturn.setSuccess(true);
		apiReturn.setInfo("操作成功！");
		//String rest = "[{\"jiuhuid\":\"1\",\"plateNum\":\"京AD1815\",\"time\":\"01:04\"},{\"jiuhuid\":\"2\",\"plateNum\":\"京AD1833\",\"time\":\"02:04\"}]";
		//String rest1 = "[{\"stopid\":\"1\",\"stationName\":\"急救中心\",\"time\":\"01:04\"}]";
		List<String> arrayList = new ArrayList<String>();
		boolean success = false;
		String info = "请求失败!";
		if(rest!=null && rest.length()>0&&rest1!=null && rest1.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			Map restMap1 = (Map)JSONArray.parse(rest1);
			int code1 = (int) restMap1.get("code");
			if(code==200&&code1==200){
				arrayList.add(restMap.get("obj")+"");
				arrayList.add(restMap1.get("obj")+"");
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,arrayList);
		
	}
	@RequestMapping("/selectUnderwayInfo")
	@ResponseBody
	public ApiReturn selectUnderwayInfo(@RequestBody JSONObject jsonObject){
		String id = (String)jsonObject.get("id");
		String url = selectUnderwayInfoUrl1+"?id="+id;
		logger.info(url);
		String rest = RestUtil.getRest(url);
		logger.info(rest);
		String url1 = selectUnderwayInfoUrl2+"?id="+id;
		logger.info(url1);
		String rest1 = RestUtil.getRest(url1);
		logger.info(rest1);
		
		ApiReturn apiReturn = new ApiReturn();
		apiReturn.setSuccess(true);
		apiReturn.setInfo("操作成功！");
		//String rest = "[{\"jiuhuid\":\"1\",\"plateNum\":\"京AD1815\",\"time\":\"01:04\"},{\"jiuhuid\":\"2\",\"plateNum\":\"京AD1833\",\"time\":\"02:04\"}]";
		//String rest1 = "[{\"stopid\":\"1\",\"stationName\":\"急救中心\",\"time\":\"01:04\"}]";
		List<String> arrayList = new ArrayList<String>();
		boolean success = false;
		String info = "请求失败!";
		if(rest!=null && rest.length()>0&&rest1!=null && rest1.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			Map restMap1 = (Map)JSONArray.parse(rest1);
			int code1 = (int) restMap1.get("code");
			if(code==200&&code1==200){
				arrayList.add(restMap.get("obj")+"");
				arrayList.add(restMap1.get("obj")+"");
				success = true;
				info = "请求成功!";
			}
		}
		return new ApiReturn(success,info,arrayList);
		
	}
	
	/**
	 * 
	 * @Description:车辆调度
	 * @param jiuhuid
	 * @param stopid
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/busDispatch")
	public @ResponseBody ApiReturn busDispatch(@RequestBody JSONObject jsonObject){
		String jiuhuid = (String)jsonObject.get("jiuhuid");
		String stopid = (String)jsonObject.get("stopid");
		String pointId = (String)jsonObject.get("pointId");
		System.err.println("jiuhuid="+jiuhuid+";stopid="+stopid+";pointId="+pointId);
		String url = busDispatchUrl+"?jiuhuId="+jiuhuid+"&stopId="+stopid+"&id="+pointId;
		logger.info(url);
		String rest = RestUtil.getRest(url)+"";
		//String rest = "true";
		logger.info(rest);
		if(rest!=null&&rest.length()>0){
			if("true".equals(rest)){
				return new ApiReturn(true,"操作成功！");
			}else{
				return new ApiReturn(false,"操作失败！");
			}
		}else{
			return new ApiReturn(false,"操作失败！");
		}
	}
	
	/**
	 * 
	 * @Description:轮询急救点
	 * @return
	 * ApiReturn
	 * @exception:
	 * @time:2018年1月25日
	 */
	@RequestMapping("/selectRescuePoint")
	@ResponseBody
	public ApiReturn selectRescuePoint(){
		String url = selectRescuePointUrl;
		String rest = RestUtil.getRest(url);
		//String rest ="{\"code\":200,\"info\":\"通啦\",\"obj\":[{\"id\":8,\"eventlng\":111.000000,\"eventlat\":111.000000,\"busid\":\"111\",\"trailerid\":null,\"eventnum\":\"111\",\"eventtype\":\"111\",\"roadid\":null,\"state\":0},{\"id\":9,\"eventlng\":222.000000,\"eventlat\":222.000000,\"busid\":\"222\",\"trailerid\":\"222\",\"eventnum\":\"222\",\"eventtype\":\"222\",\"roadid\":\"222\",\"state\":1}]}";
		System.out.println(rest);
		if(rest!=null && rest.length()>0){
			Map restMap = (Map)JSONArray.parse(rest);
			int code = (int) restMap.get("code");
			if(code==200){
				String obj = restMap.get("obj")+"";
				return new ApiReturn(true,"请求成功",obj);
			}else{
				return new ApiReturn(false,"请求失败",null);
			}
		}else{
			return new ApiReturn(false,"请求失败",null);
		}
	}
	
}
