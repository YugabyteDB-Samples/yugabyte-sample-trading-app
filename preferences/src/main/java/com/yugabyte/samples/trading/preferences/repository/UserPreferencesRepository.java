package com.yugabyte.samples.trading.preferences.repository;

import com.yugabyte.samples.trading.preferences.model.UserPreferences;
import java.util.prefs.Preferences;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserPreferencesRepository extends JpaRepository<UserPreferences, Integer> {


}
