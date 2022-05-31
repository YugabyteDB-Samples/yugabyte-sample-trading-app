package com.yugabyte.samples.trading.security;

import com.yugabyte.samples.trading.BadRequestException;
import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.RegionType;
import com.yugabyte.samples.trading.repository.CustomerRepository;
import javax.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/api/v1/users")
public class UserController {

  private final CustomerRepository customers;
  private final JwtAuthHelper authHelper;
  @Autowired
  public UserController(CustomerRepository customers, CustomerBasedUserDetailsService userDetailsService, JwtAuthHelper authHelper) {
    this.customers = customers;
    this.authHelper = authHelper;
  }

  @PostMapping("/sign-up")
  @ResponseStatus(HttpStatus.CREATED)
  public SignupResponse signup(@Valid @RequestBody SignupRequest form)  {
    Customer customer = createCustomer(form);
    return SignupResponse.builder()
      .customerId(customer.getCustomerId())
      .login(form.getEmail())
      .build();
  }

  @PostMapping("/sign-in")
  @ResponseStatus(HttpStatus.ACCEPTED)
  public AuthenticationResponse authenticate(@Valid @RequestBody AuthenticationRequest request) {

      String jwt = authHelper.processLoginAndGenerateJwt(request.getLogin(), request.getCredentials());
      return AuthenticationResponse.builder()
        .token(jwt)
        .type("Bearer")
        .status("SUCCESS")
        .build();
  }

  private Customer createCustomer(SignupRequest form) {
    if (customers.existsByEmail(form.getEmail())) {
      throw new BadRequestException("Email already in use");
    }

    Customer customer = Customer.builder()
      .fullName(form.getFullName())
      .preferredRegion(RegionType.valueOf(form.getPreferredRegion()))
      .email(form.getEmail())
      .password(authHelper.encodePassword(form.getPassword()))
      .phoneNumber(form.getPhoneNumber())
      .enabled(true)
      .build();

    customer = customers.save(customer);
    return customer;
  }
}
