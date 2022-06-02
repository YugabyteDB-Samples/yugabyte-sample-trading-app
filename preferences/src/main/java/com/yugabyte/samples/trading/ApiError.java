package com.yugabyte.samples.trading;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.ArrayList;
import java.util.List;


@JsonInclude(Include.NON_NULL)
public record ApiError(
  String status,
  String message,
  List<FieldError<?>> fieldErrors
) {

  public ApiError(String message) {
    this("ERROR", message, new ArrayList<>());
  }

  public ApiError(Exception ex) {
    this(ex.getMessage());
  }

  public ApiError(String error, FieldError<?>... fieldErrors) {
    this("ERROR", error, List.of(fieldErrors));
  }

  public ApiError(Exception error, FieldError<?>... fieldErrors) {
    this("ERROR", error.getMessage(), List.of(fieldErrors));
  }

  public <T> ApiError field(String fieldName, T value, String error) {
    this.fieldErrors.add(new FieldError<>(fieldName, value, error));
    return this;
  }
}

@JsonInclude(Include.NON_NULL)
record FieldError<T>(String fieldName, T value, String error) {

  public FieldError(String fieldName, String error) {
    this(fieldName, null, error);
  }
}
