package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Preference;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "preferences")
@OpenAPIDefinition()
public interface PreferenceRepository extends JpaRepository<Preference, Integer> {


}
