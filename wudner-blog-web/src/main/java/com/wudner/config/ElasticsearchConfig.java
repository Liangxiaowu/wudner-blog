package com.wudner.config;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ElasticsearchConfig {
//    @Value("${elasticsearch.ip}")
//    String ipAddress;


    @Bean
    public RestHighLevelClient restHighLevelClient(){
        RestHighLevelClient client = new RestHighLevelClient(
                RestClient.builder(
//                        new HttpHost("localhost", 9200, "http"),
                        new HttpHost("127.0.0.1", 9200, "http")));
        return client;
    }

}
