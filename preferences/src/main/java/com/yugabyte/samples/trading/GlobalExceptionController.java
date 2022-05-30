package com.yugabyte.samples.trading;

import org.springframework.core.convert.ConversionFailedException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionController {

  @ExceptionHandler({ConversionFailedException.class, BadRequestException.class})
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  public ResponseEntity<ApiError> handleBadRequest(RuntimeException exception) {
    var apiError = ApiError.builder()
      .message(exception.getMessage())
      .build();
    return ResponseEntity.badRequest()
      .body(apiError);
  }


  @ExceptionHandler(ResourceNotFoundException.class)
  @ResponseStatus(HttpStatus.NOT_FOUND)
  public ResponseEntity<String> handleNotFound(RuntimeException ex) {
    return new ResponseEntity<>(ex.getMessage(), HttpStatus.NOT_FOUND);
  }

}
