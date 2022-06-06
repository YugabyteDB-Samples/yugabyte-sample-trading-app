package com.yugabyte.samples.trading.security;

import com.yugabyte.samples.trading.ApiException;
import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.RegionType;
import com.yugabyte.samples.trading.repository.CustomerRepository;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import java.security.Principal;
import javax.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
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
  public SignUpResponse signup(@Valid @RequestBody SignUpRequest form) {
    Customer customer = createCustomer(form);
    return SignUpResponse.builder()
      .customerId(customer.getCustomerId())
      .login(form.getEmail())
      .build();
  }

  @PostMapping("/password-reset")
  @ResponseStatus(HttpStatus.ACCEPTED)
  public PasswordResetResponse passwordReset(@Valid @RequestBody PasswordResetRequest request) {
    String login = request.login();
    String newPassword = "Password#123";
    var customer = customers.getByEmail(login)
      .orElseThrow();
    customer.setPassword(authHelper.encodePassword(newPassword));
    log.info("{}: Password reset successful", login);
    return new PasswordResetResponse(login, newPassword);
  }

  @PostMapping("/sign-in")
  @ResponseStatus(HttpStatus.ACCEPTED)
  public AuthenticationResponse authenticate(@Valid @RequestBody AuthenticationRequest request) {

    String jwt = authHelper.processLoginAndGenerateJwt(request.getLogin(), request.getCredentials());
    var customerId = customers.getByEmail(request.getLogin())
      .orElseThrow()
      .getCustomerId();
    return AuthenticationResponse.builder()
      .token(jwt)
      .type("Bearer")
      .status("SUCCESS")
      .customerId(customerId)
      .build();
  }

  @PostMapping("/sign-out")
  @ResponseStatus(HttpStatus.ACCEPTED)
  @SecurityRequirement(name = "auth-header-bearer")
  public MessageResponse signOut(Principal principal) {
    log.info("{}: Got sign out request", principal.getName());
    return new MessageResponse("Sign Out Successful");
  }

  @GetMapping("/me")
  @ResponseStatus(HttpStatus.OK)
  @SecurityRequirement(name = "auth-header-bearer")
  public Customer getMe(Principal principal) {
    return customers.getByEmail(principal.getName())
      .orElseThrow();
  }

  private Customer createCustomer(SignUpRequest form) {
    if (customers.existsByEmail(form.getEmail())) {
      throw new ApiException("Failed to complete signup", "email", form.getEmail(), "Already in use");
    }

    Customer customer = Customer.builder()
      .fullName(form.getFullName())
      .preferredRegion( RegionType.valueOf(form.getPreferredRegion()))
      .email(form.getEmail())
      .password(authHelper.encodePassword(form.getPassword()))
      .phoneNumber(form.getPhoneNumber())
      .enabled(true)
      .build();

    customer = customers.save(customer);
    return customer;
  }

  public record PasswordResetRequest(String login) {

  }

  public record PasswordResetResponse(String login, String password) {

  }

  public record MessageResponse(String message) {

  }
}
