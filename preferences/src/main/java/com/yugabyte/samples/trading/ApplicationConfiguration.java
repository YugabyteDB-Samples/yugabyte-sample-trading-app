package com.yugabyte.samples.trading;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ApplicationConfiguration {

  @Bean
  public OpenAPI customOpenAPI() {
    return new OpenAPI()
      .components(new Components())
      .info(new Info().title("Preferences API")
        .description("Trading System / Preferences API")
        .version("1.0.0"));
  }
}
