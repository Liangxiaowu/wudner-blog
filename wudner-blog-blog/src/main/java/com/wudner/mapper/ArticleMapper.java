package com.wudner.mapper;

import com.wudner.pojo.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface ArticleMapper {
    public Article getArticleById(@Param("id") int id);

    public int incrementReadNumber(@Param("id") int id);

}
