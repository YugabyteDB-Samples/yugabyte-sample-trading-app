package com.yugabyte.samples.trading;

import static java.lang.String.join;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import java.util.TimeZone;
import javax.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;

@SpringBootApplication
@Slf4j
@OpenAPIDefinition(
  info = @Info(title = "TradeX API", version = "1.0", description = "Trading API")
)
@SecurityScheme(name = "auth-header-bearer", scheme = "bearer", type = SecuritySchemeType.HTTP, in = SecuritySchemeIn.HEADER)

public class TradeXUserApplication {

  @Autowired
  public TradeXUserApplication(Environment environment) {
    log.info("Active profiles: [{}]", join(",", environment.getActiveProfiles()));
  }

  public static void main(String[] args) {

    SpringApplication.run(TradeXUserApplication.class, args);
  }

  @PostConstruct
  void started() {
    TimeZone.setDefault(TimeZone.getTimeZone("Etc/UTC"));
  }

}
