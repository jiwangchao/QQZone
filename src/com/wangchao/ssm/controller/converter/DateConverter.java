package com.wangchao.ssm.controller.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * @author 吉王超
 * @date 2016年12月23日 上午10:41:56
 * @Description 自定义日期类型转换
 */
public class DateConverter implements Converter<String, Date>{

	@Override
	public Date convert(String source) {
		//spring框架默认date类型为年月日
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			//转换成功则直接返回，失败则抛出异常，返回null
			return sdf.parse(source);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
