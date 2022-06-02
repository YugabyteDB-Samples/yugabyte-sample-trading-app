package com.yugabyte.samples.trading;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
@Slf4j
public class GlobalExceptionController {

  @ExceptionHandler({RuntimeException.class})
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  @ResponseBody
  public ApiError handleBadRequest(RuntimeException exception) {
    ApiError error = new ApiError(exception);
    log.error("Other Error: {}", error);
    return error;
  }


  @ExceptionHandler({ApiException.class})
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  @ResponseBody
  public ApiError handleApiException(ApiException exception) {
    ApiError error = exception.getError();
    log.error("API Error: {}", error);
    return error;
  }
}
