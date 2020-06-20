package com.wudner.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

@Data
@ApiModel(value = "")
public class ArticleDto implements Serializable {

    @ApiModelProperty(value = "开始数", name = "pageNo", dataType = "String", example = "0")
    @NotBlank(message = "pageNo 不能为空")
    private String pageNo;

    @ApiModelProperty(value = "页码", name = "pageSize", dataType = "String", example = "10")
    @NotBlank(message = "pageSize 不能为空")
    private String pageSize;

    @ApiModelProperty(value = "关键字", name = "keyword", dataType = "String", example = "")
    private String keyword;
}
