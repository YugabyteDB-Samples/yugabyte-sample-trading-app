package com.yugabyte.samples.trading.security;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import com.yugabyte.samples.trading.ApiError;
import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.RegionType;
import com.yugabyte.samples.trading.repository.CustomerRepository;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import lombok.Builder;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

  private final CustomerRepository customers;
  private final UserDetailsManager users;

  private final PasswordEncoder passwordEncoder;

  private final AuthenticationManager authenticationManager;


  private final JwtCodec jwtCodec;

  @Autowired
  public UserController(CustomerRepository customers, UserDetailsManager users, PasswordEncoder passwordEncoder, AuthenticationManager authenticationManager, JwtCodec jwtCodec) {
    this.customers = customers;
    this.users = users;
    this.passwordEncoder = passwordEncoder;
    this.authenticationManager = authenticationManager;
    this.jwtCodec = jwtCodec;
  }

  @RequestMapping(method = POST, value = "/sign-up")
  public SignupResponse signup(@Valid @RequestBody UserController.SignupRequest form) throws SignupException {
    Customer customer = createCustomer(form);
    return SignupResponse.builder()
      .customerId(customer.getCustomerId())
      .login(form.email)
      .build();
  }

  @RequestMapping(method = GET, value = "/check-availability")
  public Boolean checkAvailability(@RequestParam("login") String login) {
    return !users.userExists(login);
  }

  @ExceptionHandler(SignupException.class)
  @ResponseStatus(HttpStatus.BAD_REQUEST)
  public ApiError handleSingUpError(SignupException exception) {
    return ApiError.builder()
      .message(exception.getMessage())
      .build();
  }

  @RequestMapping(method = POST, value = "/sign-in")
  public AuthenticationResponse authenticate(@Valid @RequestBody AuthenticationRequest request) {
    var userToken = new UsernamePasswordAuthenticationToken(request.getLogin(), request.getCredentials());
    Authentication authentication = authenticationManager.authenticate(userToken);
    if (authentication.isAuthenticated()) {
      String jwt = jwtCodec.generateToken(authentication);
      return AuthenticationResponse.builder()
        .token(jwt)
        .type("Bearer")
        .status("SUCCESS")
        .build();
    }
    throw new RuntimeException("Invalid credentials");
  }

  private Customer createCustomer(SignupRequest form) throws SignupException {
    if (users.userExists(form.getEmail())) {
      throw new SignupException("Email already used");
    }

    Customer customer = Customer.builder()
      .customerName(String.format("%1$s $2%s", form.getFirstName(), form.getLastName()))
      .preferredRegion(RegionType.valueOf(form.getPreferredRegion()))
      .contactEmail(form.getEmail())
      .build();

    UserDetails user = User.builder()
      .username(form.getEmail())
      .password(form.getPassword())
      .passwordEncoder(passwordEncoder::encode)
      .build();

    users.createUser(user);
    customer = customers.save(customer);
    return customer;
  }

  @Data
  @Builder
  public static class AuthenticationResponse {

    private String token;
    private String type;
    private String status;
    private String message;
  }

  @Data
  @Builder
  public static class AuthenticationRequest {

    @NotBlank
    private String login;
    @NotBlank
    private String credentials;
  }

  public static final class SignupException extends Exception {

    public SignupException(String message) {
      super(message);
    }
  }

  @Data
  @Builder
  public static final class SignupRequest {

    private String firstName;
    private String lastName;
    private String email;
    private String preferredRegion;
    private String password;
  }

  @Data
  @Builder
  public static final class SignupResponse {

    private Integer customerId;
    private String login;
  }
}
