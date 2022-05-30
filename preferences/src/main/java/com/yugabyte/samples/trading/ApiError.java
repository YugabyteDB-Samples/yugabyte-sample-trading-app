package com.yugabyte.samples.trading;

import java.time.LocalDateTime;
import java.util.List;
import lombok.Builder;
import lombok.Value;


@Builder
public record ApiError (
  String message,
  List<FieldError<?>> fieldErrors
  ){

}


@Builder
record FieldError<T>(String fieldName, T value, String error) {}
