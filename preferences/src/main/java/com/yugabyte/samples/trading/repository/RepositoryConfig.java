package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Component
public class RepositoryConfig implements RepositoryRestConfigurer {

  @Override
  public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
//    RepositoryRestConfigurer.super.configureRepositoryRestConfiguration(config, cors);
    config.exposeIdsFor(Customer.class);
  }
}
