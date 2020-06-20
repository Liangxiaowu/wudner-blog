package com.wudner.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.concurrent.TimeUnit;

@Component
public final  class RedisUtil {

    @Resource
    private  StringRedisTemplate stringRedisTemplate;

    @Resource
    private RedisTemplate<Object, Object> redisTemplate;


    private String prefix = "blog_";

    /**
     * 获取缓存字符串 根据key
     *
     * @param key 字符串key
     * @return value
     */
    public  String get(String key) {
        key = prefix + key;
        return stringRedisTemplate.opsForValue().get(key);
    }

    /**
     * set value and  cache timeout by str key
     *
     * @param key    字符串key
     * @param value  字符串value
     * @param second 过期时间 单位 秒
     */
    public void set(String key, String value, Long second) {
        key = prefix + key;
        stringRedisTemplate.opsForValue().set(key, value, second, TimeUnit.SECONDS);
    }

    /**
     * get object value by key
     *
     * @param key obj key
     * @return obj value
     */
    public Object getObj(Object key) {
        key = prefix + key.toString();
        return redisTemplate.opsForValue().get(key);
    }

    /**
     * set value by key
     *
     * @param key    obj key
     * @param value  obj value
     * @param second 过期时间 单位户 秒
     */
    public void setObj(Object key, Object value, Long second) {
        key = prefix + key.toString();
        redisTemplate.opsForValue().set(key, value, second,TimeUnit.SECONDS);
    }

    /**
     * delete by key
     *
     * @param key key
     */
    public void del(String key) {
        stringRedisTemplate.delete(prefix + key);
    }

    /**
     * delete by key
     *
     * @param key obj key
     */
    public void delObj(Object key) {
        redisTemplate.delete(prefix + key.toString());
    }
}
