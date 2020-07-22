package com.wudner.service.impl;

import com.github.pagehelper.PageHelper;
import com.wudner.mapper.ArticleMapper;
import com.wudner.mapper.CategoryMapper;
import com.wudner.pojo.Article;
import com.wudner.pojo.Category;
import com.wudner.service.ArticleService;
import com.wudner.util.PageObj;
import com.wudner.util.RedisUtil;
//import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ArticleServiceImpl  implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    RedisTemplate redisTemplate;


    @Autowired
    private RedisUtil redisUtil;

//
//    @Autowired
//    private RestHighLevelClient restHighLevelClient;

    /**
     * 文章详情
     * @param id
     * @param ip
     * @return
     */
    public Article getArticleById(int id, String ip) {

        addArticleReadNum(id, ip);

        return articleMapper.getArticleById(id);
    }

    /**
     * 添加访问访问次数
     * @param id
     * @param ip
     * @return
     */
    private boolean addArticleReadNum (int id, String ip){
        String key = id+"_"+ip;
        if(redisUtil.get(key) == null || redisUtil.get(key) == ""){
            //记录访问
            redisUtil.set(key, "true", 60L);
            //记录访问次数
            articleMapper.incrementReadNumber(id);

//            //
//            String pid = id+"";
//            UpdateRequest request = new UpdateRequest("blog", pid);
//            request.timeout(new TimeValue(2,TimeUnit.SECONDS));
//
//            User user = new User("wudner", 20, "2020-02-02");
//            request.doc(JSON.toJSONString(user), XContentType.JSON);
//            UpdateResponse response = restHighLevelClient.update(request, RequestOptions.DEFAULT);
//            System.out.println(response.status()); // OK
        }
        return  false;
    }

    /**
     * 文章列表
     * @param pageNo
     * @param pageSize
     * @param keyword
     * @return
     */
    public PageObj<Article> list(int pageNo, int pageSize, String keyword, String tag) {

        PageHelper.startPage(pageNo, pageSize);

        List<Article> list = articleMapper.selectArticleList(keyword, tag);
        return new PageObj<Article>(list);

//        List<Article> list = new ArrayList<>();
//        Pageable pageable = new Pageable(0);
//        BoolQueryBuilder qb = QueryBuilders.boolQuery();

//        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
//        qb.must(QueryBuilders.matchQuery("title", "单"));
//        Page<Article> all = (Page<Article>)articleEsMapper.search(qb);
//
//        return all;

//        SearchRequest searchRequest = new SearchRequest("blog");
//        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
//
//        if(keyword != null & keyword != ""){
//            MatchQueryBuilder matchQuery = QueryBuilders.matchQuery("title", keyword);
//            sourceBuilder.query(matchQuery);
//        }
//
//        sourceBuilder
//                .from(pageNo)
//                .size(pageSize)
//                .sort("createdTime", SortOrder.DESC)
//                .timeout(new TimeValue(10, TimeUnit.SECONDS));
//
//
//        searchRequest.source(sourceBuilder);
//        SearchResponse response = null;
//        try {
//            response = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        ArrayList<Map> objects = new ArrayList();
//
//        for (SearchHit hit : response.getHits().getHits()) {
//            objects.add(hit.getSourceAsMap());
//        }
//        HashMap page = new HashMap();
//        page.put("total", response.getTotalShards());
//        page.put("pageNo", pageNo);
//
//        HashMap result = new HashMap();
//
//        result.put("page",page);
//        result.put("list",objects);

//        return null;
    }

    public List top(){
        return  articleMapper.selectArticleTop();
    }

    public List menu(){
        List<Category> list = categoryMapper.getCategoryList();
        return  list;
    }
}
