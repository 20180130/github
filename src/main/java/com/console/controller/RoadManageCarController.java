package com.console.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.exception.JsonInvalidException;
import com.console.utill.DateUtil;
import com.console.utill.HttpUtil;
import com.console.utill.HttpUtil.HttpResponse;
/**
 * 路政系统事件操作
 * @author d
 *
 */
@Controller
@RequestMapping("/roadManageCar")
public class RoadManageCarController {
	public static Log logger = LogFactory.getLog(RoadManageCarController.class);
	
	
	
	/**
	 * 获取冰
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getRoadList", method = { RequestMethod.GET})
	public JSONObject getRoadList() {
		//构建返回结果
		
		List<String> strategylist = new ArrayList<String>();
		//final String url = getUrl(permbaseurl + "/imaUser/getPermissions.do", map);
		String url="http://10.0.1.40:8080/RoadSys/api/getRoadList";
		HttpResponse  responsse=HttpUtil.execute(HttpMethod.GET, url, null, null);
		

		
		
	
		int statuscode=responsse.getStatusCode();
		if (statuscode!=200) {
			throw new JsonInvalidException("接口异常");
		}
		JSONArray mapreult = JSONArray.parseArray(responsse.getBody());
		if (mapreult == null) {
			throw new JsonInvalidException("接口异常");
		}
		JSONObject jsonobj=new JSONObject();
		for(int i=0;i<mapreult.size();i++){
			//JSONObject e=new JSONObject();
			JSONObject objjson=mapreult.getJSONObject(i);
			String longstring=objjson.getString("eventTime");
			String eventTime=DateUtil.getDateString(longstring,DateUtil.DATAFORM[0]);
			objjson.put("eventTime", eventTime);
		}
		
		
		
		
	
/*	JSONObject pmp=new JSONObject();
		pmp.put("overState", 1);
		pmp.put("startLat",120.0);
		pmp.put("overstateName", "待处理");
		pmp.put("eventstateName", "路面结冰");
		pmp.put("eventState", "1003");
		pmp.put("eventTime" ,"1516362688000");
		pmp.put("roadID" ,7);
		pmp.put("startLng", 100.0);
		
		JSONObject pmp1=new JSONObject();
		pmp1.put("overState", 1);
		pmp1.put("startLat",520.0);
		pmp1.put("overstateName", "待处理");
		pmp1.put("eventstateName", "路面结冰");
		pmp1.put("eventState", "1003");
		pmp1.put("eventTime" ,"1516362688000");
		pmp1.put("roadID" ,8);
		pmp1.put("startLng", 600.0);
		JSONArray ary=new JSONArray();
				ary.add(pmp);
				ary.add(pmp1);
		
	
		JSONObject jsonobj=new JSONObject();
		for(int i=0;i<ary.size();i++){
			//JSONObject e=new JSONObject();
			JSONObject objjson=ary.getJSONObject(i);
			String longstring=objjson.getString("eventTime");
			String eventTime=DateUtil.getDateString(longstring,DateUtil.DATAFORM[0]);
			objjson.put("eventTime", eventTime);
		}
		*/
		
	jsonobj.put("data", mapreult);
		//jsonobj.put("data", ary);
		return jsonobj;
	}
	
	
	/**
	 * 除冰
	 * @param json
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/removFreezeBlock", method = { RequestMethod.PUT})
	public JSONObject removFreezeBlock(@RequestBody String json) {
		//构建返回结果
		JSONObject object=JSONObject.parseObject(json);
		String removblok="{\"roadID\":"+object.getString("RoadID")+"}";
		String url="http://10.0.1.40:8080/RoadSys/api/update";
		HttpResponse  responsse=HttpUtil.execute(HttpMethod.PUT, url, null, removblok);
	
	    int statuscode=responsse.getStatusCode();
		if (statuscode!=200) {
			throw new JsonInvalidException("接口异常");
		}
		JSONObject mapreult = JSONObject.parseObject(responsse.getBody());
		if (mapreult == null) {
			throw new JsonInvalidException("接口异常");
		}
		JSONObject jsonobj=new JSONObject();
	/*	for(int i=0;i<mapreult.size();i++){
			//JSONObject e=new JSONObject();
			JSONObject objjson=mapreult.getJSONObject(i);
			String longstring=objjson.getString("eventTime");
			String eventTime=DateUtil.getDateString(longstring,DateUtil.DATAFORM[0]);
			objjson.put("eventTime", eventTime);
		}*/
		
	//jsonobj.put("data", mapreult);
		jsonobj.put("data",mapreult);
		return jsonobj;
	}
	
	
	
/*	
    private Map<String, String> getHeaders(HttpServletRequest request){
    	User user = super.getCurrentUser();
    	Map<String, String> headers = new HashMap<String, String>();
    	headers.put("userName", user.getUsername());
    	headers.put("userEmail", user.getEmail());
    	headers.put("userId", String.valueOf(getMasterUserid()));
		headers.put("createBy", String.valueOf(user.getUserid()));
    	headers.put("ip", IpUtil.getClientIpAddr(request));
    	return headers;
    }*/
	
	
	public static void main(String args[]){
	    String res;
	    String s="1516362688000";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long lt = new Long(s);
        Date date = new Date(lt);
        res = simpleDateFormat.format(date);
      //  return res;
	}
	
}
