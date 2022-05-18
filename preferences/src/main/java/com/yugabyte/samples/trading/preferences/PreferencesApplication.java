package com.yugabyte.samples.trading.preferences;

import static java.lang.String.join;
import static java.util.Arrays.stream;
import static java.util.stream.Collectors.joining;

import com.yugabyte.samples.trading.preferences.model.UserPreferences;
import java.util.Arrays;
import java.util.TimeZone;
import java.util.stream.Collectors;
import javax.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;

@SpringBootApplication
@Slf4j
public class PreferencesApplication {

  @PostConstruct
  void started() {
    TimeZone.setDefault(TimeZone.getTimeZone("Etc/UTC"));
  }

  @Autowired
  public PreferencesApplication(Environment environment) {
    log.info("Active profiles: [{}]", join(",", environment.getActiveProfiles()));
  }
	public static void main(String[] args) {

		SpringApplication.run(PreferencesApplication.class, args);
	}

}
