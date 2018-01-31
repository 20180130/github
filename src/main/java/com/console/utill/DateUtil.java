package com.console.utill;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期转换工具类
 * @author d
 *
 */
public class DateUtil {
	public static String DATAFORM[]={"yyyy-MM-dd HH:mm:ss"};
	private static SimpleDateFormat simpleDateFormat=null;
	
	/**
	 * 根据dateformat格式化日期数据
	 * @param longstring
	 * @param dateformat
	 * @return
	 */
public static String getDateString(String longstring,String dateformat){
	 getformat(dateformat);
	 long lt = new Long(longstring);
     Date date = new Date(lt);
      
	return simpleDateFormat.format(date);
}


private static SimpleDateFormat getformat(String datefromat){
	if(simpleDateFormat==null){
		
		simpleDateFormat= new SimpleDateFormat(datefromat==null||datefromat==""?"yyyy-MM-dd":datefromat);
	}
	return simpleDateFormat;
}
}
