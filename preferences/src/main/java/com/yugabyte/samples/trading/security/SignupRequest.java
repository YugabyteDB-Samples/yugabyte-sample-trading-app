package com.yugabyte.samples.trading.security;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public final class SignupRequest {
  private String fullName;
  private String lastName;
  private String email;
  private String phoneNumber;
  private String preferredRegion;
  private String password;
}
