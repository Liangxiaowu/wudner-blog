/*
Navicat MySQL Data Transfer

Source Server         : 14.29.232.152
Source Server Version : 80019
Source Host           : 14.29.232.152:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2020-06-08 23:59:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_img` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '文章内容',
  `read_number` int NOT NULL DEFAULT '0' COMMENT '阅读次数',
  `top_num` tinyint DEFAULT '0' COMMENT '次序(置顶功能)',
  `status` tinyint DEFAULT '0' COMMENT '0未发布 1发布',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `del_flag` tinyint NOT NULL DEFAULT '0' COMMENT '0正常1删除',
  `user_id` int DEFAULT NULL COMMENT '作者',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `title_content_fulltext` (`title`,`content`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', null, '单例模式', '<h2>饿汉式</h2>\r\n\r\n<pre style=\"font-size: 18px; \"><code>\r\npublic class Singleton {\r\n    private static final Singleton instance = new Singleton();\r\n\r\n    private Singleton() {\r\n    }\r\n\r\n    public static Singleton2 getInstance() {\r\n        return instance;\r\n    }\r\n}\r\n</code></pre>\r\n\r\n<h2>懒汉式</h2>\r\n\r\n<pre style=\"font-size: 18px; \"><code>\r\npublic class Singleton{\r\n\r\n    private static boolean tab = false;\r\n\r\n    private volatile static Singleton singleton;\r\n\r\n    private Singleton(){\r\n        // 防止反射破坏\r\n        synchronized(Singleton.class){\r\n          if(tab == false){\r\n            tab = true;\r\n          }else{\r\n             if(singleton == null){\r\n                    throw new RuntimeException(\"不允许反射\");\r\n             }\r\n          }\r\n        }\r\n      }\r\n\r\n    // 双重检测锁模式\r\n      public static Singleton getInstance(){\r\n\r\n    if(singleton == null){\r\n      synchronized(Singleton.class){\r\n        if(singleton == null){\r\n          singleton = new Singleton();\r\n        }\r\n      }\r\n    }\r\n\r\n    return singleton;\r\n    }\r\n}\r\n</code></pre>\r\n\r\n<h2>枚举方式</h2>\r\n\r\n<pre  style=\"font-size: 18px; \"><code>\r\npublic enum EnumSingleton{\r\n\r\n  INSTANCE;\r\n\r\n  public EnumSingleton getInstance(){\r\n      return INSTANCE;\r\n    }\r\n\r\n}\r\n</code></pre>\r\n\r\n<h2>总结</h2>\r\n\r\n<ul style=\"font-size: 18px;\">\r\n<li>一般情况下单线程直接使用饿汉式就好；</li>\r\n<li>多线程环境推荐使用懒汉式；</li>\r\n<li>如果考虑到反射、反序列化创建的问题，推荐使用枚举方式。</li>\r\n</ul>', '17', '0', '1', '2020-03-03 18:57:20', null, '0', '1');
INSERT INTO `article` VALUES ('2', null, '工厂模式', '<h2>作用</h2>\r\n\r\n<p>实现创造与调用分离。</p>\r\n\r\n<h2>简单工厂模式</h2>\r\n\r\n<p>作用：用来生产同一等级结构中的任意产品。</p>\r\n\r\n<pre><code> \r\n// 口红接口类\r\npublic interface Lipstick {\r\n    void name();\r\n}\r\n\r\n// mac品牌\r\npublic class MAC implements Lipstick {\r\n    public void name() {\r\n        System.out.println(\"MAC品牌\");\r\n    }\r\n}\r\n\r\n// ysl品牌\r\npublic class YSL implements Lipstick {\r\n    public void name() {\r\n        System.out.println(\"YSL品牌\");\r\n    }\r\n}\r\n\r\n// 口红工厂类\r\npublic class LipstickFactory {\r\n    public static Lipstick getLipstick(String lipstick){\r\n        if(lipstick.equals(\"MAC\")){\r\n            return new MAC();\r\n        }else if(lipstick.equals(\"YSL\")){\r\n            return new YSL();\r\n        }\r\n\r\n   return null ;\r\n}\r\n\r\n\r\n}</code></pre>\r\n\r\n<h2>工厂方法模式</h2>\r\n\r\n<p>作用：用于生产同一等级结构中的固定产品。</p>\r\n\r\n<pre><code> \r\n// 口红接口\r\npublic interface Lipstick {\r\n    void name();\r\n}\r\n// 口红工厂接口\r\npublic interface LipstickFactory {\r\n    Lipstick getLipstick();\r\n}\r\n\r\n// mac品牌类\r\npublic class MAC implements Lipstick {\r\n    public void name() {\r\n        System.out.println(\"MAC品牌\");\r\n    }\r\n}\r\n\r\n//ysl品牌类 \r\npublic class YSL implements Lipstick {\r\n    public void name() {\r\n        System.out.println(\"YSL品牌\");\r\n    }\r\n}\r\n// mac工厂类\r\npublic class MacFactory implements LipstickFactory {\r\n\r\n  public Lipstick getLipstick() {\r\n      return new MAC();\r\n  }\r\n\r\n\r\n}\r\n// ysl工厂类\r\npublic class YslFactory implements LipstickFactory {\r\n    public Lipstick getLipstick() {\r\n        return new YSL();\r\n    }\r\n}\r\n\r\n// 消费者\r\npublic class Consumer {\r\n    public static void main(String[] args) {\r\n        Lipstick lipstick = new MacFactory().getLipstick();\r\n        Lipstick lipstick1 = new YslFactory().getLipstick();</p>\r\n\r\n        lipstick.name();\r\n        lipstick1.name();\r\n    }\r\n\r\n}\r\n</code></pre>\r\n\r\n<h2>抽象工厂模式</h2>\r\n\r\n<p>作用：围绕一个超级工厂创建其他工厂。</p>', '12', '0', '1', '2020-03-04 19:22:39', null, '0', '1');
INSERT INTO `article` VALUES ('11', null, 'Java线程使用', '<p>最近因为公司的业务需求，为了解决一定的并发，所以使用到了线程相关的编程，公司的某个同事比较好奇，就问了我相关线程的知识点。俗话说教一些不善于理解的人，直接拿案例展示比较能让他通俗易懂，于是乎我就给他写了一些小案例，顺便总结一些自己的笔记。</p>\r\n\r\n<h2>什么线程</h2>\r\n\r\n<p>线程是操作系统能够进行运算的调度的最小单位，它被包含在进程之中，是进程中的实际运作单位。一条线程指的是进程中一个单一顺序的控制流，一个进程中可以并发多个线程，每条线程并行执行不同的任务。进程的内存空间是共享的，每个线程都可以使用这些共享内存。</p>\r\n\r\n<h2>为什么用线程</h2>\r\n\r\n<p>前面我有说过线程能做到一定的并发处理。多线程还能满足编程充分利用 CPU来达到高效率的目的。</p>\r\n\r\n<p>这时候我们顺便来了解一下并发和并行的概念。</p>\r\n\r\n<p>并发：指短时间间隔内，执行了多个任务。</p>\r\n\r\n<p>并行：指在同一个时刻，执行了多个任务。</p>\r\n\r\n<p>单核 CPU在同一个时刻只能执行一个任务点，为什么我们电脑会程序和程序之间是同时在运行，那是因为我们伟大的cpu切换的速度足够快，快到我们凡人是感觉不出来他在切换处理中。</p>\r\n\r\n<p>所以并行的前提，常理来说要多核运行才行。</p>\r\n\r\n<p>这个时候这位同事就问我，那我每次的任务都开启多线程，我的程序不就变的飞快了吗？</p>\r\n\r\n<p>非也，线程的使用是有消耗的，越多的线程消耗就会越多，如果你执行是一些不怎么消耗时间的任务，你执意要去使用多线程就会变得物极必反的效果。而且我们还需要考虑到线程安全的问题等。</p>\r\n\r\n<h2>创建线程</h2>\r\n\r\n<ul>\r\n<li><p>通过继承Thread类</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\npublic class ThreadTest extends java.lang.Thread {\r\n\r\n// 线程入口\r\n  @Override\r\n  public void run(){\r\n      // 线程执行体\r\n      for (int i=0;i &lt;= 100; i++){\r\n          System.out.println(\"Thread线程执行-----\"+i);\r\n      }\r\n\r\n}\r\n\r\npublic static void main(String[] args){\r\n\r\n  // 创建线程对象\r\n  ThreadTest threadTest = new ThreadTest();\r\n\r\n  // 启动线程\r\n  threadTest.start();\r\n\r\n  for (int i=0;i&lt;=100;i++){\r\n      System.out.println(\"ThreadTest程序正在执行----\"+i);\r\n  }\r\n}\r\n\r\n}\r\n</pre></li>\r\n<li><p>通过实现Runnable接口【推荐】</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\npublic class RunnableTest implements Runnable{\r\n\r\n// 线程入口\r\n  @Override\r\n  public void run(){\r\n      // 线程执行体\r\n      for (int i=0;i &lt;= 100; i++){\r\n          System.out.println(\"Runnable线程执行-----\"+i);\r\n      }\r\n\r\n  }\r\n\r\n  public static void main(String[] args){\r\n\r\n    // 创建线程对象\r\n    RunnableTest runnableTest = new RunnableTest();\r\n\r\n    Thread thread = new Thread(runnableTest);\r\n\r\n    // 启动线程\r\n    thread.start();\r\n\r\n    for (int i=0;i&lt;=100;i++){\r\n        System.out.println(\"RunnableTest程序正在执行----\"+i);\r\n    }\r\n  }\r\n}</pre></li>\r\n</ul>\r\n\r\n<h2>小案例</h2>\r\n\r\n<p>假如银行里只有一个窗口那么办理业务，有个老奶奶来了办卡，窗口就会受理老奶奶的办卡需求，这时候来了个小伙子也要办卡，老奶奶还没办理完成小伙子只能等待老奶奶完成之后再到窗口办理。</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\npublic class SynBank  {\r\n\r\n  public static void run(String name){\r\n      for (int i=1;i&lt;=10;i++){\r\n          try {\r\n              Thread.sleep(1000);\r\n          } catch (InterruptedException e) {\r\n              e.printStackTrace();\r\n          }\r\n          //老奶奶的动作缓慢需要消耗的时间长点\r\n          if(name.equals(\"老奶奶\")){\r\n              try {\r\n                  Thread.sleep(500);\r\n              } catch (InterruptedException e) {\r\n                  e.printStackTrace();\r\n              }\r\n          }\r\n          System.out.println(name+\"完成了办卡第\"+i+\"步\");\r\n      }\r\n  }\r\n\r\n  public static void main(String[] args){\r\n      long startTime = System.currentTimeMillis();\r\n      run(\"老奶奶\");\r\n      run(\"小伙机\");\r\n      long endTime = System.currentTimeMillis();\r\n      System.out.println(\"总共耗时：\"+(endTime-startTime));\r\n  }\r\n}</pre>\r\n\r\n<p>通过以上程序的模拟得到，这种情况下需要的时间会在25秒以上</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\n老奶奶完成了办卡第1步\r\n老奶奶完成了办卡第2步\r\n...\r\n小伙机完成了办卡第9步\r\n小伙机完成了办卡第10步\r\n总共耗时：25110\r\n\r\nProcess finished with exit code 0\r\n\r\n</pre>\r\n\r\n<p>于是银行觉得这种效率太慢了，决定开启多窗口受理方式来接待银行的顾客。</p>\r\n\r\n<p>那么老奶奶第一个来的时候，会被分配到窗口一去受理，这时候小伙子过来了，就会被分配到窗口二去办理。</p>\r\n\r\n<pre style=\"font-size: 18px\">java\r\npublic class Bank implements Runnable {\r\n\r\n@Override\r\npublic void run(){\r\n    long startTime = System.currentTimeMillis();\r\n    for (int i=1;i&lt;=10;i++){\r\n        // 假如每一步的流程都要消耗1秒钟\r\n\r\n        if(Thread.currentThread().getName().equals(\"老奶奶\")){\r\n            System.out.println(Thread.currentThread().getName()+\"完成了办卡第\"+i+\"步\");\r\n            try {\r\n                Thread.sleep(1500);\r\n            } catch (InterruptedException e) {\r\n                e.printStackTrace();\r\n            }\r\n        }else {\r\n            System.out.println(Thread.currentThread().getName()+\"完成了办卡第\"+i+\"步\");\r\n            try {\r\n                Thread.sleep(1000);\r\n            } catch (InterruptedException e) {\r\n                e.printStackTrace();\r\n            }\r\n\r\n        }\r\n    }\r\n    if(Thread.currentThread().getName().equals(\"老奶奶\")){\r\n        long endTime = System.currentTimeMillis();\r\n        System.out.println(\"总共耗时：\"+(endTime-startTime));\r\n    }\r\n\r\n}\r\n\r\npublic static void main(String[] args){\r\n    Bank bank = new Bank();\r\n    new Thread(bank,\"老奶奶\").start();\r\n    new Thread(bank,\"小伙机\").start();\r\n}\r\n\r\n\r\n}</pre>\r\n\r\n<p>通过以上程序的模拟得到，总共消耗的时间为15秒，我们会发现小伙子最终完成的比老奶奶要快，他们的任务互不干扰，所以不需要等待老奶奶办理完成才开始受理其他人，这样大大提升了银行的效率。</p>\r\n\r\n<pre style=\"font-size: 18px\">java\r\n老奶奶完成了办卡第1步\r\n小伙机完成了办卡第1步\r\n...\r\n老奶奶完成了办卡第8步\r\n小伙机完成了办卡第10步\r\n老奶奶完成了办卡第9步\r\n老奶奶完成了办卡第10步\r\n总共耗时：15039\r\nProcess finished with exit code 0\r\n</pre>\r\n\r\n<h2>总结</h2>\r\n\r\n<p>在某种耗时任务的时候，我们适当去使用多线程模式，时间上不单单会快很多，还解决我们一部分的并发。但是需要注意的是线程的开启是对资源有一定的消耗，所以不能盲目去使用线程做开发。</p>', '5', '0', '1', '2020-02-05 23:12:55', null, '0', '1');
INSERT INTO `article` VALUES ('12', null, 'redis锁', '<h4>前言</h4>\r\n\r\n<p>本文章只是简单的介绍redis分布式锁的使用和基本原理。</p>\r\n\r\n<h2>单体架构</h2>\r\n\r\n<p>在java单体架构下的多线程模式，一般使用<strong>synchronized</strong>就可以实现了本地锁。</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\nsynchronized (this){\r\n  ... 库存处理\r\n}\r\n</pre>\r\n\r\n<h2>分布式架构</h2>\r\n\r\n<p>现在绝大部分的公司都会使用分布式的系统，这时候使用<strong>synchronized</strong>就没法解决互斥性。</p>\r\n\r\n<h3>简单的锁</h3>\r\n\r\n<pre style=\"font-size: 18px\">\r\nString lockKey = \"lock_01\";\r\nBoolean lock = stringRedisTemplate.opsForValue().setIfAbsent(lockKey, \"lock\");//相当于 redis SETNX lock_01 \"lock\"\r\n// 锁还存在\r\nif(!lock){\r\n    return \"error\";\r\n}\r\n// ... 业务处理\r\n// 释放锁\r\nstringRedisTemplate.delete(lockKey);\r\n</pre>\r\n\r\n<p>SETNX的文档介绍：http://redisdoc.com/string/setnx.html</p>\r\n\r\n<p>简单的锁处理，但是以上锁并不能解决问题，假如我使用锁时，在业务处理的代码中出现了异常错误，那么锁将无法释放，导致了死锁的出现。</p>\r\n\r\n<h3>分布式锁</h3>', '1', '0', '1', '2020-03-11 12:21:22', null, '0', '1');
INSERT INTO `article` VALUES ('20', null, 'ElasticSearch基本语法', '<h2>API基本格式与http动词</h2>\r\n\r\n<pre style=\"font-size: 18px\">\r\n格式：http://&lt;ip&gt;:&lt;port&gt;/&lt;索引&gt;/&lt;类型&gt;/&lt;文档id&gt;\r\n\r\nhttp动词：GET/POST/PUT/DELETE\r\n</pre>\r\n\r\n<h2>创建索引</h2>\r\n\r\n<p>索引：是含有相同属性的文档集合。</p>\r\n\r\n<p>类型： 索引可以定义一个或者多个类型，文档必须属于一个类型。</p>\r\n\r\n<p>文档：是可以被索引的基本数据单位。</p>\r\n\r\n<ul>\r\n<li><p>非结构化索引</p>\r\n\r\n</li>\r\n<li><p>结构化索引</p>\r\n\r\n<pre style=\"font-size: 18px\">\r\nput: 127.0.0.1:9200/&lt;索引&gt;\r\n{\r\n\"settings\": {\r\n    \"number_of_shards\": 3,\r\n    \"number_of_replicas\": 1\r\n},\r\n\"mappimgs\": {\r\n    \"man\": {\r\n        \"properties\": {\r\n            \"name\":{\r\n                \"type\": \"text\"\r\n            },\r\n            \"age\": {\r\n                \"type\": \"integer\"\r\n            }\r\n            \"date\": {\r\n                \"type\": \"date\",\r\n                \"format\": \"yyy-MM-dd||yyy-MM-dd HH:mm:ss\"\r\n            }\r\n        }\r\n    }\r\n}\r\n}\r\n</pre></li>\r\n</ul>\r\n\r\n<h2>插入</h2>\r\n\r\n<pre style=\"font-size: 18px\">\r\n  put: 127.0.0.1:9200/&lt;索引>/&lt;类型>/id        #   指定ID\r\n  post: 127.0.0.1:9200/&lt;索引>/&lt;类型>          # 自动生成ID\r\n  {\r\n      \"name\": \"xiaowu\",\r\n      \"age\": 18,\r\n      \"date\": \"2000-02-20\"\r\n  }\r\n</pre>\r\n<h2>修改</h2>\r\n\r\n<pre style=\"font-size: 18px\">\r\n直接修改：post: 127.0.0.1:9200/&lt;索引>/&lt;类型>/id/_update</p>\r\n{\r\n    \"doc\": {\r\n        \"name\": \"修改信息\"\r\n    }\r\n}\r\n脚本修改：\r\n{\r\n    \"script\": {\r\n        \"lang\": \"painless\",\r\n        \"inline\": \"ctx._source.age = params.age\",\r\n        \"params\": {\r\n            \"age\": 20\r\n        }\r\n    }\r\n\r\n}\r\n</pre>>\r\n\r\n<h2>删除</h2>\r\n\r\n<pre style=\"font-size: 18px\">\r\n  delete : 127.0.0.1:9200/&lt;索引&gt;/&lt;类型&gt;/id # 删除文档\r\n  delete : 127.0.0.1:9200/&lt;索引&gt;  # 删除索引\r\n</pre>\r\n\r\n<h2>查询</h2>\r\n\r\n<pre style=\"font-size: 18px\">\r\n简单查询\r\n  GET :127.0.0.1:9200/&lt;索引&gt;/&lt;类型&gt;/id\r\n  POST: 127.0.0.1:9200/&lt;索引&gt;/_search\r\n</pre>\r\n\r\n<h2>复杂查询</h2>\r\n\r\n<pre style=\"font-size: 18px\">java\r\nGET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"match\":{\r\n      \"name\": \"小五\"\r\n    }\r\n  }\r\n}\r\n</pre>\r\n\r\n<h2>过滤结果</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"match\":{\r\n      \"name\": \"五\"\r\n    }\r\n  },\r\n    \"_source\": [\"name\",\"desc\"]\r\n}</pre>\r\n\r\n<h2>排序</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"match\":{\r\n      \"name\": \"小\"\r\n    }\r\n  },\r\n  \"sort\": [\r\n    {\r\n      \"age\": {\r\n        \"order\": \"desc\"\r\n      }\r\n    }\r\n  ]\r\n}</pre>\r\n\r\n<h2>分页 form 开始数据  size 数据条数</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"match\":{\r\n      \"name\": \"小\"\r\n    }\r\n  },\r\n  \"from\": 0,\r\n  \"size\": 1\r\n}</pre>\r\n\r\n<h2>布尔值查询</h2>\r\n\r\n<h2>多条件查询（and）</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"bool\": {\r\n      \"must\":[\r\n        {\r\n          \"match\": {\r\n            \"name\": \"四\"\r\n          }\r\n        },\r\n        {\r\n          \"match\": {\r\n            \"age\": 13\r\n          }\r\n        }\r\n      ]\r\n    }\r\n  }\r\n}</pre>\r\n\r\n<h2>多条件查询（or）</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"bool\": {\r\n      \"should\":[\r\n        {\r\n          \"match\": {\r\n            \"name\": \"五\"\r\n          }\r\n        },\r\n        {\r\n          \"match\": {\r\n            \"age\": 13\r\n          }\r\n        }\r\n      ]\r\n    }\r\n  }\r\n}</pre>\r\n\r\n<h2>多条件查询（not）</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"bool\": {\r\n      \"must_not\":[\r\n        {\r\n          \"match\": {\r\n            \"age\": 13\r\n          } <br>\r\n        }\r\n      ]\r\n    }\r\n  }\r\n}</pre>\r\n\r\n<h2>范围查询 gt:大于 gte:大于等于  lt:小于 lte:小于等于</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n    \"bool\": {\r\n      \"filter\": {\r\n        \"range\": {\r\n          \"age\": {\r\n            \"gt\":12,\r\n            \"lt\":25\r\n          }\r\n        }\r\n      }\r\n    }\r\n  }\r\n}</pre>\r\n\r\n<h2>多词查询 只要满足其一即可</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n      \"match\": {\r\n        \"tags\": \"打球 唱歌\"\r\n        }\r\n  }\r\n}</pre>\r\n\r\n<h2>高亮查询</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n      \"match\": {\r\n        \"name\": \"小五\"\r\n        }\r\n  },\r\n  \"highlight\": {\r\n    \"fields\": {\r\n      \"name\":{}\r\n    }\r\n  }\r\n}</pre>\r\n\r\n<h2>自定义高亮查询</h2>\r\n\r\n<pre style=\"font-size: 18px\">GET xiaowu/_doc/_search\r\n{\r\n  \"query\": {\r\n      \"match\": {\r\n        \"name\": \"小五\"\r\n        }\r\n  },\r\n  \"highlight\": {\r\n    \"pre_tags\": \"<xmp><spen style=\'color:red\'></xmp>\",\r\n    \"post_tags\": \"<xmp></spen></xmp>\",\r\n    \"fields\": {\r\n      \"name\":{}\r\n    }\r\n  }\r\n}</pre>', '26', '0', '1', '2020-05-01 12:27:46', null, '0', '1');
INSERT INTO `article` VALUES ('22', null, 'Springboot2.x + ElasticSearch 基本使用.md', '<h2>maven配置依赖 内容添加到您的<code>pom.xml</code>文件中。</h2>\r\n\r\n<pre style=\"font-size: 18px\"><code>\r\n<xmp><properties>\r\n     <java.version>1.8</java.version>\r\n     <!--  注意 这个版本号要与你连接的es版本号一致 -->\r\n     <elasticsearch.version>7.7.0</elasticsearch.version>\r\n</properties>\r\n\r\n<dependency>\r\n    <groupId>org.springframework.boot</groupId>\r\n    <artifactId>spring-boot-starter-data-elasticsearch</artifactId>\r\n</dependency>\r\n</xmp>\r\n</code></pre>\r\n\r\n<h2>config文件</h2>\r\n\r\n<pre style=\"font-size: 18px\"><code>\r\n@Configuration\r\npublic class ElasticsearchConfig {\r\n\r\n@Bean\r\npublic RestHighLevelClient restHighLevelClient(){\r\n    RestHighLevelClient client = new RestHighLevelClient(\r\n            RestClient.builder(\r\n\r\n\r\n//              new HttpHost(\"localhost\", 9200, \"http\"), //开启多个集群\r\n                        new HttpHost(\"127.0.0.1\", 9200, \"http\")));\r\n        return client;\r\n    }\r\n\r\n}\r\n</code></pre>\r\n<h2>使用</h2>\r\n\r\n<pre style=\"font-size: 18px\"><code>\r\npackage com.xiaowu;\r\n\r\nimport com.alibaba.fastjson.JSON;\r\nimport com.sun.java.accessibility.util.EventID;\r\nimport com.xiaowu.pojo.User;\r\nimport org.elasticsearch.action.admin.indices.create.CreateIndexRequest;\r\nimport org.elasticsearch.action.admin.indices.create.CreateIndexResponse;\r\nimport org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;\r\nimport org.elasticsearch.action.bulk.BulkRequest;\r\nimport org.elasticsearch.action.bulk.BulkResponse;\r\nimport org.elasticsearch.action.delete.DeleteRequest;\r\nimport org.elasticsearch.action.delete.DeleteResponse;\r\nimport org.elasticsearch.action.get.GetRequest;\r\nimport org.elasticsearch.action.get.GetResponse;\r\nimport org.elasticsearch.action.index.IndexRequest;\r\nimport org.elasticsearch.action.index.IndexResponse;\r\nimport org.elasticsearch.action.search.SearchRequest;\r\nimport org.elasticsearch.action.search.SearchResponse;\r\nimport org.elasticsearch.action.support.master.AcknowledgedResponse;\r\nimport org.elasticsearch.action.update.UpdateRequest;\r\nimport org.elasticsearch.action.update.UpdateResponse;\r\nimport org.elasticsearch.client.RequestOptions;\r\nimport org.elasticsearch.client.RestHighLevelClient;\r\nimport org.elasticsearch.client.indices.GetIndexRequest;\r\nimport org.elasticsearch.common.unit.TimeValue;\r\nimport org.elasticsearch.common.xcontent.XContentType;\r\nimport org.elasticsearch.index.query.MatchAllQueryBuilder;\r\nimport org.elasticsearch.index.query.MatchQueryBuilder;\r\nimport org.elasticsearch.index.query.QueryBuilders;\r\nimport org.elasticsearch.index.query.TermQueryBuilder;\r\nimport org.elasticsearch.search.SearchHit;\r\nimport org.elasticsearch.search.builder.SearchSourceBuilder;\r\nimport org.junit.jupiter.api.Test;\r\nimport org.omg.CORBA.PUBLIC_MEMBER;\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.boot.test.context.SpringBootTest;</p>\r\n\r\nimport java.io.IOException;\r\nimport java.util.ArrayList;\r\nimport java.util.Date;\r\nimport java.util.concurrent.TimeUnit;\r\n\r\n@SpringBootTest\r\nclass EsApplicationTests {\r\n\r\n@Autowired\r\nprivate RestHighLevelClient restHighLevelClient;\r\n\r\n@Test\r\nvoid created() throws IOException {\r\n\r\n    // 创建索引请求\r\n    CreateIndexRequest request = new CreateIndexRequest(\"wudner_index\");\r\n\r\n    // 客户端执行请求 请求后获得响应\r\n    CreateIndexResponse createIndexResponse = restHighLevelClient.indices().create(request, RequestOptions.DEFAULT);\r\n    System.out.println(createIndexResponse);\r\n\r\n}\r\n\r\n// 获取索引\r\n@Test\r\npublic void testExistIndex() throws IOException {\r\n    GetIndexRequest request = new GetIndexRequest(\"wudner_index\");\r\n\r\n    // 判断索引是否存在\r\n    boolean exists = restHighLevelClient.indices().exists(request, RequestOptions.DEFAULT);\r\n    System.out.println(exists);\r\n\r\n}\r\n\r\n\r\n// 删除索引\r\n@Test\r\npublic void testDeleteIndex() throws IOException {\r\n    DeleteIndexRequest request = new DeleteIndexRequest(\"wudner_index\");\r\n\r\n    AcknowledgedResponse delete = restHighLevelClient.indices().delete(request, RequestOptions.DEFAULT);\r\n    System.out.println(delete.isAcknowledged());\r\n}\r\n\r\n// 添加文档\r\n@Test\r\npublic void testAddDocument() throws IOException {\r\n    User user = new User(\"五爹\", 18, \"1992-02-12\");\r\n    IndexRequest request = new IndexRequest(\"wudner_index\");\r\n    // 规则\r\n    request.id(\"1\");\r\n    request.timeout(\"1s\");\r\n\r\n    // 将数据放入请求\r\n    String userJson = JSON.toJSONString(user);\r\n    request.source(userJson, XContentType.JSON);\r\n\r\n    // 客户端发起请求\r\n    IndexResponse response = restHighLevelClient.index(request, RequestOptions.DEFAULT);\r\n\r\n    System.out.println(response.toString());\r\n    System.out.println(response.status());\r\n}\r\n\r\n// 判断文档是否存在\r\n@Test\r\nvoid testIsExists() throws IOException {\r\n    GetRequest request = new GetRequest(\"wudner_index\", \"1\");\r\n\r\n    boolean exists = restHighLevelClient.exists(request, RequestOptions.DEFAULT);\r\n    System.out.println(exists); // true\r\n}\r\n\r\n// 获取文档\r\n@Test\r\nvoid testGetDocument() throws IOException {\r\n    GetRequest request = new GetRequest(\"wudner_index\", \"1\");\r\n    GetResponse response = restHighLevelClient.get(request, RequestOptions.DEFAULT);\r\n    System.out.println(response.getSourceAsString()); // {\"age\":20,\"birth\":\"2020-02-02\",\"name\":\"wudner\"}\r\n    System.out.println(response); // {\"_index\":\"xiaowu_index\",\"_type\":\"_doc\",\"_id\":\"1\",\"_version\":2,\"_seq_no\":1,\"_primary_term\":1,\"found\":true,\"_source\":{\"age\":20,\"birth\":\"2020-02-02\",\"name\":\"wudner\"}}\r\n}\r\n\r\n//更新文档\r\n@Test\r\nvoid testUpdateDocument() throws IOException {\r\n    UpdateRequest request = new UpdateRequest(\"wudner_index\", \"1\");\r\n    request.timeout(new TimeValue(1, TimeUnit.SECONDS)); // 超时时间\r\n\r\n    User user = new User(\"wudner\", 20, \"2020-02-02\");\r\n    request.doc(JSON.toJSONString(user), XContentType.JSON);\r\n    UpdateResponse response = restHighLevelClient.update(request, RequestOptions.DEFAULT);\r\n    System.out.println(response.status()); // OK\r\n\r\n}\r\n\r\n// 删除文档\r\n@Test\r\nvoid testDeleteDocument() throws IOException {\r\n    DeleteRequest request = new DeleteRequest(\"wudner_index\", \"1\");\r\n    request.timeout(new TimeValue(1, TimeUnit.SECONDS)); // 超时时间\r\n    DeleteResponse response = restHighLevelClient.delete(request, RequestOptions.DEFAULT);\r\n    System.out.println(response.status()); // OK\r\n}\r\n\r\n// 批量操作\r\n@Test\r\nvoid testBulkRequest() throws IOException {\r\n    BulkRequest bulkRequest = new BulkRequest();\r\n    bulkRequest.timeout(new TimeValue(5, TimeUnit.SECONDS));\r\n    ArrayList&lt;User&gt; users = new ArrayList&lt;&gt;();\r\n    users.add(new User(\"张三1\",18, \"2003-01-18\"));\r\n    users.add(new User(\"张三2\",19, \"2004-02-18\"));\r\n    users.add(new User(\"张三3\",20, \"2005-03-18\"));\r\n    users.add(new User(\"李四1\",18, \"2003-01-18\"));\r\n    users.add(new User(\"李四2\",19, \"2004-02-18\"));\r\n    users.add(new User(\"李四3\",19, \"2005-03-18\"));\r\n\r\n\r\n    for (int i = 0; i &lt; users.size() ; i++) {\r\n        bulkRequest.add(\r\n                new IndexRequest(\"wudner_index\").id((i+1)+\"\").source(JSON.toJSONString(users.get(i)), XContentType.JSON)\r\n        );\r\n    }\r\n\r\n    BulkResponse response = restHighLevelClient.bulk(bulkRequest, RequestOptions.DEFAULT);\r\n\r\n    System.out.println(response.hasFailures()); // 是否失败 false代表操作成功，没有失败\r\n}\r\n\r\n// 查询\r\n@Test\r\nvoid testSearch() throws IOException {\r\n    SearchRequest request = new SearchRequest(\"wudner_index\");\r\n    // 构建搜索条件\r\n    SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();\r\n\r\n    // 精确查询\r\n\r\n\r\n//        TermQueryBuilder queryBuilder = QueryBuilders.termQuery(\"name\", \"张三1\");\r\n        // 匹配所有\r\n//        MatchAllQueryBuilder queryBuilder = QueryBuilders.matchAllQuery();</p>\r\n\r\n    // 模糊匹配\r\n    MatchQueryBuilder queryBuilder = QueryBuilders.matchQuery(\"name\", \"张三\");\r\n\r\n    searchSourceBuilder.query(queryBuilder);\r\n\r\n    searchSourceBuilder.timeout(new TimeValue(10, TimeUnit.SECONDS));\r\n\r\n    request.source(searchSourceBuilder);\r\n\r\n    SearchResponse response = restHighLevelClient.search(request, RequestOptions.DEFAULT);\r\n\r\n    System.out.println(JSON.toJSONString(response.getHits()));\r\n    for (SearchHit searchHit:response.getHits().getHits()){\r\n        System.out.println(searchHit.getSourceAsMap());\r\n    }\r\n\r\n}\r\n\r\n\r\n}\r\n</code></pre>', '3', '0', '1', '2020-05-02 13:06:45', null, '0', '1');

-- ----------------------------
-- Table structure for article_category
-- ----------------------------
DROP TABLE IF EXISTS `article_category`;
CREATE TABLE `article_category` (
  `article_id` int NOT NULL COMMENT '文章id',
  `category_id` int NOT NULL COMMENT '标签id',
  PRIMARY KEY (`article_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章标签表';

-- ----------------------------
-- Records of article_category
-- ----------------------------
INSERT INTO `article_category` VALUES ('1', '2');
INSERT INTO `article_category` VALUES ('2', '2');

-- ----------------------------
-- Table structure for article_tag
-- ----------------------------
DROP TABLE IF EXISTS `article_tag`;
CREATE TABLE `article_tag` (
  `article_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`article_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL,
  `sequence` tinyint NOT NULL DEFAULT '0',
  `code` varchar(16) NOT NULL COMMENT '搜索code',
  `name` varchar(64) NOT NULL COMMENT '类别名称',
  `parent_id` int NOT NULL DEFAULT '0' COMMENT '上层id(目前最多两次层)',
  `created_at` datetime DEFAULT NULL,
  `updatd_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='类别表';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '3', 'PHP', 'PHP', '0', '2018-10-12 22:30:18', null);
INSERT INTO `category` VALUES ('2', '1', 'Java', 'Java', '0', '2018-10-12 22:30:18', null);
INSERT INTO `category` VALUES ('3', '2', 'Linux', 'Linux', '0', '2018-10-12 22:30:18', null);
INSERT INTO `category` VALUES ('4', '4', '其他', '其他', '0', '2018-10-12 22:30:18', null);

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `deptno` bigint NOT NULL AUTO_INCREMENT,
  `dname` varchar(60) DEFAULT NULL,
  `db_source` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('1', '技术部', 'blog');
INSERT INTO `dept` VALUES ('2', '人事部', 'blog');
INSERT INTO `dept` VALUES ('3', '财务部', 'blog');
INSERT INTO `dept` VALUES ('4', '市场部', 'blog');
INSERT INTO `dept` VALUES ('5', '运维部', 'blog');

-- ----------------------------
-- Table structure for seckill
-- ----------------------------
DROP TABLE IF EXISTS `seckill`;
CREATE TABLE `seckill` (
  `id` int DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of seckill
-- ----------------------------
INSERT INTO `seckill` VALUES ('1', 'iphone10', '2');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_code` varchar(16) NOT NULL COMMENT '标签code',
  `tag_name` varchar(255) NOT NULL COMMENT '标签name',
  `color` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='标签表';

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES ('1', 'PHP', 'PHP', '#2d8cf0');
INSERT INTO `tag` VALUES ('2', 'Swoole', 'Swoole', '#19be6b');
INSERT INTO `tag` VALUES ('3', 'Laravel', 'Laravel', '#ed4014');
INSERT INTO `tag` VALUES ('4', 'Java', 'Java', '#f90');
INSERT INTO `tag` VALUES ('5', 'Spring boot', 'Spring boot', '#2d8cf0');
INSERT INTO `tag` VALUES ('6', 'Spring cloud', 'Spring cloud', '#19be6b');
INSERT INTO `tag` VALUES ('7', 'Mybatis', 'Mybatis', '#ed4014');
INSERT INTO `tag` VALUES ('8', 'Linux', 'Linux', '#f90');
INSERT INTO `tag` VALUES ('9', 'Docker', 'Docker', '#2d8cf0');
INSERT INTO `tag` VALUES ('10', 'Redis', 'Redis', '#19be6b');
INSERT INTO `tag` VALUES ('11', 'Mysql', 'Mysql', '#ed4014');
INSERT INTO `tag` VALUES ('12', 'VUE', 'VUE', '#f90');
INSERT INTO `tag` VALUES ('13', 'Composer', 'Composer', '#2d8cf0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `photo` varchar(255) DEFAULT NULL COMMENT '头像',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0可用1封禁',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'wudner', '740234880e3d4ac04f6c23cfcc8cf470', '965391514@qq.com', null, '0', null, null);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `age` int DEFAULT NULL COMMENT '年龄',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `banks_num` tinyint DEFAULT NULL COMMENT '银行卡数',
  PRIMARY KEY (`id`),
  KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('206', 'xiaowu1', '123456', '20', '2020-03-09 12:06:09', null, null);
INSERT INTO `users` VALUES ('207', 'xiaowu2', '123456', '25', '2020-03-09 12:06:18', null, null);
INSERT INTO `users` VALUES ('208', 'xiaowu3', '123456', '25', null, null, null);
INSERT INTO `users` VALUES ('209', 'xiaowu4', '123456', '25', '2020-03-09 12:17:22', null, null);
