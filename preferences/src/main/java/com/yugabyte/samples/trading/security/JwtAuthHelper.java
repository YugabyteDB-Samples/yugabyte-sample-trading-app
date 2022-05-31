package com.yugabyte.samples.trading.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class JwtAuthHelper {
  private final JwtCodec jwtCodec;
  private final PasswordEncoder passwordEncoder;

  private final UserDetailsService userDetailsService;

  public JwtAuthHelper(JwtCodec jwtCodec, PasswordEncoder passwordEncoder, UserDetailsService userDetailsService) {
    this.jwtCodec = jwtCodec;
    this.passwordEncoder = passwordEncoder;
    this.userDetailsService = userDetailsService;
  }

  public String encodePassword(String password) {
    return passwordEncoder.encode(password);
  }

  public String processLoginAndGenerateJwt(String loginId, String credentials) {
    log.info("{}: Received Login Request", loginId);
    log.info("{}: Trying to auth", loginId);
    UserDetails details = userDetailsService.loadUserByUsername(loginId);
    boolean credentialsMatched = passwordEncoder.matches(credentials, details.getPassword());
    log.info("{}: Finished to auth", loginId);
    if (credentialsMatched) {
      log.info("{}: Authenticated User", loginId);
      String jwt = jwtCodec.generateToken(details);
      log.info("{}: Created JWT Token", loginId);
      return jwt;
    }
    throw new AuthenticationCredentialsNotFoundException("Credentials Not Found");
  }
}
