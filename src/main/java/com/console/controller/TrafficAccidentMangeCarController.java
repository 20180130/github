package com.console.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.exception.JsonInvalidException;
import com.console.utill.DateUtil;
import com.console.utill.HttpUtil;
import com.console.utill.HttpUtil.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"/trafficAccidentMangeCar"})
public class TrafficAccidentMangeCarController
{
  public static Log log = LogFactory.getLog(TrafficAccidentMangeCarController.class);

  @ResponseBody
  @RequestMapping(value={"/trafficAccidentList"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public JSONObject getTrafficAccidentList()
  {
    List strategylist = new ArrayList();

    String url = "http://10.0.1.40:8080/AccidentSys/api/list";
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.GET, url, null, null);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }
    JSONArray mapreult = JSONArray.parseArray(responsse.getBody());
    if (mapreult == null) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject jsonobj = new JSONObject();
    for (int i = 0; i < mapreult.size(); i++)
    {
      JSONObject objjson = mapreult.getJSONObject(i);
      String longstring = objjson.getString("eventTime");
      String eventTime = DateUtil.getDateString(longstring, DateUtil.DATAFORM[0]);
      objjson.put("eventTime", eventTime);
    }

    jsonobj.put("data", mapreult);

    return jsonobj;
  }

  @ResponseBody
  @RequestMapping(value={"/playTrafficAccidentToBack"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String playTrafficAccidentToBack(String eventID, String startsecond, String endsecond)
  {
    List strategylist = new ArrayList();

    String url = "http://10.0.1.40:8080/MonitorManagementSystem/getCallBackCarData?id=" + eventID + "&beforeTime=" + startsecond + "&afterTime=" + endsecond;
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.GET, url, null, null);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }

    String backreplay = responsse.getBody();

    return backreplay;
  }

  @ResponseBody
  @RequestMapping(value={"/playTrafficAccidentToBackStart"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public String playTrafficAccidentToBackStart()
  {
    List strategylist = new ArrayList();

    String url = "http://10.0.1.40:8080/MonitorManagementSystem/pushMsg?type=start";
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.GET, url, null, null);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }

    String backreplay = responsse.getBody();

    return backreplay;
  }
}