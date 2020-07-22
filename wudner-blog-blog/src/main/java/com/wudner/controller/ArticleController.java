package com.wudner.controller;

import com.wudner.dto.ArticleDto;
import com.wudner.pojo.Article;
import com.wudner.service.ArticleService;
import com.wudner.util.ApiResult;
import com.wudner.util.IpUtil;
import com.wudner.util.PageObj;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin  // 支持跨域
@Api(value = "文章接口", tags = "ArticleController", description = "测试接口相关")
public class ArticleController {

    @Autowired
    ArticleService articleService;

    @ApiOperation(value = "文章列表")
    @GetMapping(value = "/article")
    public ApiResult list(
            @RequestParam(name = "pageNo") int pageNo,
            @RequestParam(name = "pageSize") int pageSize,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String tag
            ) {

        PageObj<Article> list = articleService.list(pageNo, pageSize, keyword, tag);
        return new ApiResult<PageObj>(0, "文章列表", list);
    }

    @ApiOperation(value = "文章详情")
    @ApiImplicitParam(name = "id", value = "文章ID")
    @GetMapping(value = "/article/{id}")
    public ApiResult article(@PathVariable(value = "id") int id, HttpServletRequest request){

        String ip = IpUtil.getIp(request);

        Article article = articleService.getArticleById(id, ip);
        return new ApiResult<Article>(0, "文章详情",article);
    }

    @ApiOperation(value = "文章排行")
    @GetMapping(value = "/article/top")
    public ApiResult top(){

        List top = articleService.top();

        return new ApiResult<List>(0, "排行榜", top);
    }
    @ApiOperation(value = "文章分类")
    @GetMapping(value = "/article/menu")
    public ApiResult menu(){

        List menu = articleService.menu();

        return new ApiResult(0, "分类", menu);
    }

}
