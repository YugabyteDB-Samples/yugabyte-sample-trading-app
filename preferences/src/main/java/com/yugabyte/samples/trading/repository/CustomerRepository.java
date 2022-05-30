package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.Preference;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "customers")
@OpenAPIDefinition()
public interface CustomerRepository extends JpaRepository<Customer, Integer> {
  public Optional<Customer> findByContactEmail(String contactEmail);

}
