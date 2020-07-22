package com.wudner.mapper;

import com.wudner.pojo.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface ArticleMapper {

    public List<Article> selectArticleList(@Param("keyword") String keyword, @Param("tag")  String tag);

    public List selectArticleTop();

    public Article getArticleById(@Param("id") int id);

    public int incrementReadNumber(@Param("id") int id);

}
