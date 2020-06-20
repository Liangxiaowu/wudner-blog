package com.wudner.util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApiResult<T> implements Serializable {

    private boolean success=true;

    private int code = 0;

    private String message = "OK";

    private T data;

    public ApiResult(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public ApiResult(int code, String message) {
        this.code = code;
        this.message = message;
    }

}
