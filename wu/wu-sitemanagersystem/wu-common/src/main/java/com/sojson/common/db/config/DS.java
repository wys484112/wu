package com.sojson.common.db.config;

import java.lang.annotation.*;
 
/**
 * 自定义注解
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
@Documented
public @interface DS {
    String value() default "masterDataSource";
}
