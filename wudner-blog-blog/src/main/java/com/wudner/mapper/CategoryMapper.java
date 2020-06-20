package com.wudner.mapper;

import com.wudner.pojo.Category;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface CategoryMapper {

     public List<Category> getCategoryList();

}
