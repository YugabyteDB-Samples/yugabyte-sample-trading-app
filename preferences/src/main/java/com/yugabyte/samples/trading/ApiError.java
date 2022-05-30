package com.yugabyte.samples.trading;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import java.util.List;
import lombok.Builder;


@Builder
public record ApiError(
  String message,
  @JsonInclude(Include.NON_NULL)
  List<FieldError<?>> fieldErrors
) {

}


@Builder
record FieldError<T>(String fieldName, T value, String error) {

}
