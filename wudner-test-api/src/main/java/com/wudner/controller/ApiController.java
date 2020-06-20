package com.wudner.controller;

import com.wudner.util.ApiResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "test")
public class ApiController {


    @PostMapping(value = "/api")
    public ApiResult addApi(
            String name,
            String data
    ){


        return new ApiResult();
    }


}
