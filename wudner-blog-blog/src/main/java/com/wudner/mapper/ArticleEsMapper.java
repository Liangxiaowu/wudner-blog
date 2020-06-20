package com.wudner.mapper;


import com.wudner.pojo.Article;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ArticleEsMapper  extends ElasticsearchRepository<Article,String> {
}
