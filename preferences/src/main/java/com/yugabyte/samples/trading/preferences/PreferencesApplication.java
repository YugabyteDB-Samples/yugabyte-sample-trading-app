package com.yugabyte.samples.trading.preferences;

import com.yugabyte.samples.trading.preferences.model.UserPreferences;
import org.apache.catalina.User;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PreferencesApplication {

	public static void main(String[] args) {

		SpringApplication.run(PreferencesApplication.class, args);
	}

}
