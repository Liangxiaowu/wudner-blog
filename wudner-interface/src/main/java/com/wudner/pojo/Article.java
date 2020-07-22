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

public class Article implements Serializable {

    private int id;

    private String title;

    private String content;

    private int readNumber;

    private int topNum;

    private int status;

    private String createdTime;

    private Category category;

}
