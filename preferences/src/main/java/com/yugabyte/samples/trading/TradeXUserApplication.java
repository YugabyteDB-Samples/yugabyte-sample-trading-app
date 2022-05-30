package com.yugabyte.samples.trading;

import static java.lang.String.join;

import java.util.TimeZone;
import javax.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;

@SpringBootApplication
@Slf4j
public class TradeXUserApplication {

  @PostConstruct
  void started() {
    TimeZone.setDefault(TimeZone.getTimeZone("Etc/UTC"));
  }

  @Autowired
  public TradeXUserApplication(Environment environment) {
    log.info("Active profiles: [{}]", join(",", environment.getActiveProfiles()));
  }
	public static void main(String[] args) {

		SpringApplication.run(TradeXUserApplication.class, args);
	}

}
