package com.console.vo;

/**
 * 
 * @ClassName: ApiReturn 
 * @Description: 封装的一个返回类型，用于转换json
 * @author malongcheng 
 * @date 2018年1月3日
 *
 */
public class ApiReturn {
	// 成功标识
	private Boolean success = false;
	// 信息
	private String info = "操作失败！";
	// 结果对象
	private Object obj;
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	public ApiReturn(Boolean success, String info, Object obj) {
		super();
		this.success = success;
		this.info = info;
		this.obj = obj;
	}
	public ApiReturn() {
		super();
	}
	public ApiReturn(Boolean success, Object obj) {
		super();
		this.success = success;
		if(success){
			this.info = "操作成功！";
		}
		this.obj = obj;
	}
	public ApiReturn(Boolean success) {
		super();
		this.success = success;
		if(success){
			this.info = "操作成功！";
		}
	}
	
	
}

