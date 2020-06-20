package com.wudner.thread;

import com.wudner.mapper.ArticleMapper;

import com.wudner.util.RedisUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
@Component
public class AddArticleNumberThread implements Runnable{

    @Resource
    RedisUtil redisUtil;

    @Resource
    ArticleMapper articleMapper;


    @Override
    public void run() {
        String key = "blog";
        if(redisUtil.get(key) == null || redisUtil.get(key) == ""){
            //记录访问
//            redisUtil.set(key, "true", 30L);
            //记录访问次数
            System.out.println(12121);

        }
    }
}
