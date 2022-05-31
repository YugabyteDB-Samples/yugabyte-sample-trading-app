package com.yugabyte.samples.trading.security;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public final class SignupResponse {

  private Integer customerId;
  private String login;
}
