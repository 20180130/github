package com.console.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.console.exception.JsonInvalidException;
import com.console.utill.HttpUtil;
import com.console.utill.HttpUtil.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping({"/publicTrafficMangeCarController"})
public class PublicTrafficMangeCarController
{
  public static Log log = LogFactory.getLog(PublicTrafficMangeCarController.class);

  @ResponseBody
  @RequestMapping(value={"/createTrafficController"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public JSONObject createTrafficController(@RequestBody String json)
  {
    List strategylist = new ArrayList();

    JSONObject jsonto = JSONObject.parseObject(json);
    String url = "http://10.0.1.40:8080/TransManagerSys/api/save";
    String jsontoroad = "{\"rangeName\":\"" + jsonto.getString("rangeName") + "\",\"eventSeq\":\"" + jsonto.getString("eventSeq") + "\"}";
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.POST, url, null, jsontoroad);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject mapreult = JSONObject.parseObject(responsse.getBody());
    if (mapreult == null) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject jsonobj = new JSONObject();

    jsonobj.put("data", mapreult);
    return jsonobj;
  }

  @ResponseBody
  @RequestMapping(value={"/releaseTrafficController"}, method={org.springframework.web.bind.annotation.RequestMethod.POST})
  public JSONObject releaseTrafficController(@RequestBody String json)
  {
    List strategylist = new ArrayList();

    JSONObject jsonto = JSONObject.parseObject(json);
    String url = "http://10.0.1.40:8080/TransManagerSys/api/update";
    String jsontoroad = "{\"cid\":\"" + jsonto.getString("cid") + "\"}";
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.POST, url, null, jsontoroad);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject mapreult = JSONObject.parseObject(responsse.getBody());
    if (mapreult == null) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject jsonobj = new JSONObject();

    jsonobj.put("data", mapreult);
    return jsonobj;
  }

  @ResponseBody
  @RequestMapping(value={"/getPublicTrafficController"}, method={org.springframework.web.bind.annotation.RequestMethod.GET})
  public JSONObject getPublicTrafficController()
  {
    String url = "http://10.0.1.40:8080/TransManagerSys/api/findAll";
    HttpUtil.HttpResponse responsse = HttpUtil.execute(HttpMethod.GET, url, null, null);

    int statuscode = responsse.getStatusCode();
    if (statuscode != 200) {
      throw new JsonInvalidException("接口异常");
    }
    String body = responsse.getBody();
    JSONArray mapreult = JSONArray.parseArray(responsse.getBody());
    if (mapreult == null) {
      throw new JsonInvalidException("接口异常");
    }
    JSONObject jsonobj = new JSONObject();

    jsonobj.put("data", mapreult);

    return jsonobj;
  }
}