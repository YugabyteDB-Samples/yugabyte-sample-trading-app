package com.yugabyte.samples.trading.security;

import com.yugabyte.samples.trading.model.RegionType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public final class SignUpResponse {

  private Integer accountNumber;
  private RegionType region;
  private String login;
}
