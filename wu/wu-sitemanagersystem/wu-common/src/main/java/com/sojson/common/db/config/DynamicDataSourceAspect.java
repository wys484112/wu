package com.sojson.common.db.config;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.sojson.common.db.DynamicDataSource;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.PropertiesFileUtil;

import java.lang.reflect.Method;
 
/**
 * 自定义注解 + AOP的方式实现数据源动态切换。
 * Created by pure on 2018-05-06.
 */
@Order(1)
@Aspect
//@Component
public class DynamicDataSourceAspect {

    //使用DS注解动作之后清除
    @After("@annotation(DS)")
    public void afterSwitchDS(JoinPoint point){
        System.out.println("清除当前数据源"+DynamicDataSource.getDataSource());
		LoggerUtils.fmtDebug(getClass(), "afterSwitchDS 清除当前数据源"+DynamicDataSource.getDataSource());	                
		String property=PropertiesFileUtil.getInstance().get("domain.www");
		LoggerUtils.fmtDebug(getClass(), "dddddddddproperty=="+property);	
		DynamicDataSource.clearDataSource();
    }
	
    //使用DS注解动态切换
    @Before("@annotation(DS)")
    public void beforeSwitchDS(JoinPoint point){
        //获得当前访问的class
        Class<?> className = point.getTarget().getClass();
        //获得访问的方法名
        String methodName = point.getSignature().getName();
        //得到方法的参数的类型
        Class[] argClass = ((MethodSignature)point.getSignature()).getParameterTypes();
        String dataSource = DynamicDataSource.DEFAULT_DS;
        try {
            // 得到访问的方法对象
            Method method = className.getMethod(methodName, argClass);
            // 判断是否存在@DS注解
            if (method.isAnnotationPresent(DS.class)) {
                DS annotation = method.getAnnotation(DS.class);
                // 取出注解中的数据源名
                dataSource = annotation.value();
        		LoggerUtils.fmtDebug(getClass(), "beforeSwitchDS 当前数据源"+dataSource);	        
                
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 切换数据源
        DynamicDataSource.setDataSource(dataSource);
    }
 
}
