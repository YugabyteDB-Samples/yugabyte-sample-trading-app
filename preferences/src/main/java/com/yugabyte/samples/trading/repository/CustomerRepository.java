package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "customers")
@OpenAPIDefinition()
@SecurityRequirement(name = "auth-header-bearer")
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

  Optional<Customer> findByContactEmail(String contactEmail);

}
