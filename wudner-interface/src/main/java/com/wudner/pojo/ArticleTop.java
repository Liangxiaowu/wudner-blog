package com.wudner.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
//import org.springframework.data.elasticsearch.annotations.Document;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
//@Document(indexName = "blog", type = "_doc")

public class ArticleTop implements Serializable {

    private int id;

    private String title;

    private int readNumber;

}
