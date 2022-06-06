package com.yugabyte.samples.trading.security;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthenticationResponse {

  private String token;
  private Integer customerId;
  private String type;
  private String status;
  private String message;
}