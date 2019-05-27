package com.sojson.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;

/**
 * 启动解压zhengAdmin-x.x.x.jar到resources目录
 * Created by shuzheng on 2016/12/18.
 */
public class ZhengAdminUtil implements InitializingBean, ServletContextAware {


    @Override
    public void afterPropertiesSet() throws Exception {
        LoggerUtils.fmtDebug(getClass(), "zheng-admin.jar 解afterPropertiesSet: {}", "afterPropertiesSet");

    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        String jarPath = servletContext.getRealPath("/WEB-INF/lib/mybatis-3.1.0" + ".jar");
        LoggerUtils.fmtDebug(getClass(), "zheng-admin.jar 包路径: {%s}", jarPath);
        String resources = servletContext.getRealPath("/") + "/resources/zheng-admin";
        LoggerUtils.fmtDebug(getClass(), "zheng-admin.jar 解压到: {%s}", resources);
        
//        JarUtil.decompress(jarPath, resources);
    }

}
