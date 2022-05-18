package com.yugabyte.samples.trading.preferences.repository;

import com.yugabyte.samples.trading.preferences.model.UserPreferences;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import java.util.prefs.Preferences;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

@RepositoryRestResource(path = "preferences")
@OpenAPIDefinition()
public interface UserPreferencesRepository extends JpaRepository<UserPreferences, Integer> {


}
