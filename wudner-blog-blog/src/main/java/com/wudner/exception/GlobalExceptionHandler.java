package com.wudner.exception;

import com.wudner.util.ApiResult;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;
import java.util.stream.Collectors;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseBody
    public ApiResult HandleMethodArgumentNotValidException(MethodArgumentNotValidException exception){

        String message = exception.getBindingResult().getAllErrors().stream().map(error -> getArgMessageByError(error)).collect(Collectors.joining(","));

        return new ApiResult(422, message);
    }

    private String getArgMessageByError(ObjectError error){

        if(Objects.equals(error.getCode(), "NotBlank")){
            return String.format("%s", error.getDefaultMessage());
        }
        if(Objects.equals(error.getCode(), "NotNull")){
            return String.format("%s", error.getDefaultMessage());
        }

        return null;
    }

    private String getLastArg(Object[] args){
        return args != null && args.length > 0 ? args[args.length - 1].toString():null;
    }


    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(BindException.class)
    @ResponseBody
    public ApiResult HandleBindException(BindException exception){

        String message = exception.getBindingResult().getAllErrors().stream().map(error -> getArgMessageByError(error)).collect(Collectors.joining(","));

        return new ApiResult(422, message);
    }
}
