package com.wudner.service;

import com.wudner.pojo.Article;
import com.wudner.util.PageObj;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

public interface ArticleService {

    public Article getArticleById(int id, String ip);

    public PageObj<Article> list(int pageNo, int pageSize, String keyword, String tag);

    public List top();

    public List menu();

}
