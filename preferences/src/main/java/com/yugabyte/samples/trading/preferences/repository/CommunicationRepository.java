package com.yugabyte.samples.trading.preferences.repository;

import com.yugabyte.samples.trading.preferences.model.CommunicationPreference;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "communication-preferences")
public interface CommunicationRepository extends JpaRepository<CommunicationPreference, Long> {

  public Optional<CommunicationPreference> getAllByCustomerId(String customerId);

}
