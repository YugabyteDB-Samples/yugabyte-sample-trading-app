package com.yugabyte.samples.trading.security;

import com.yugabyte.samples.trading.repository.CustomerRepository;
import java.util.Collections;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class CustomerBasedUserDetailsService implements UserDetailsService {

  private final CustomerRepository customers;


  public CustomerBasedUserDetailsService(CustomerRepository customers) {
    this.customers = customers;
  }

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    log.info("{}: Received request for loading user details", username);
    var customer = customers.getByEmail(username)
      .orElseThrow(() -> new UsernameNotFoundException("User doest not exists"));
    log.info("{}: User found", username);
    return new User(customer.getEmail(), customer.getPassword(), customer.getEnabled(), false, false, false, Collections.emptyList());
  }

}
