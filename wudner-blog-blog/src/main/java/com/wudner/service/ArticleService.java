package com.wudner.service;

import com.wudner.pojo.Article;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

public interface ArticleService {

    public Article getArticleById(int id, String ip);

    public Map list(int pageNo, int pageSize, String keyword);

    public List top();

    public List menu();

}
