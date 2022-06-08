package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.CustomerPK;
import com.yugabyte.samples.trading.model.RegionType;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import java.util.Optional;
import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "customers")
@OpenAPIDefinition()
@SecurityRequirement(name = "auth-header-bearer")
public interface CustomerRepository extends JpaRepository<Customer, CustomerPK> {

  Boolean existsByEmail(String email);

  Boolean existsByIdRegionAndEmail( RegionType id_region, String email);

  Optional<Customer> findByEmail(String email);

  Optional<Customer> findByIdRegionAndEmail(RegionType id_region, String email);

  @Query(value = "SELECT NEXTVAL('customers_customer_id_seq')", nativeQuery = true)
  Integer nextAccountNumber();

}
