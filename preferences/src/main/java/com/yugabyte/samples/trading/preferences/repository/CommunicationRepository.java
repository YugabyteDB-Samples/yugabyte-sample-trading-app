package com.yugabyte.samples.trading.preferences.repository;

import com.yugabyte.samples.trading.preferences.model.CommunicationPreferences;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.webmvc.RepositoryRestController;

@RepositoryRestResource(path = "communication-preferences")
public interface CommunicationRepository extends JpaRepository<CommunicationPreferences, Long> {

  public Optional<CommunicationPreferences> getAllByCustomerId(String customerId);

}
