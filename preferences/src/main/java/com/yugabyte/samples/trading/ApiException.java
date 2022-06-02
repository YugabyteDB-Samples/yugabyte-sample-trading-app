package com.yugabyte.samples.trading;

public class ApiException extends RuntimeException {

  private final ApiError error;

  public ApiException(ApiError apiError) {
    super();
    this.error = apiError;
  }

  public ApiException(String error) {
    super(error);
    this.error = new ApiError(error);
  }

  public ApiException(String error, String field, Object value, String fieldError) {
    super(error);
    this.error = new ApiError(error, new FieldError<>(field, value, fieldError));
  }

  public ApiError getError() {
    return error;
  }
}
