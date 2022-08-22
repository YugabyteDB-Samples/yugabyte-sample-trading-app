package com.yugabyte.samples.trading.security;

import com.yugabyte.samples.trading.model.RegionType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthenticationResponse {

  private String token;
  private String customerId;
  private String accountNumber;
  private String type;
  private String status;
  private String message;
}
