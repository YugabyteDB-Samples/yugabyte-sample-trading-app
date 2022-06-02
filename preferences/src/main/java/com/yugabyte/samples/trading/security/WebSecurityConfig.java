package com.yugabyte.samples.trading.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(
  jsr250Enabled = true,
  securedEnabled = true,
  prePostEnabled = true
)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


  //  private UserDetailsService userDetailsService;


  private final JwtAuthenticationFilter jwtAuthenticationFilter;

  @Autowired
  public WebSecurityConfig(JwtAuthenticationFilter jwtAuthenticationFilter) {
    this.jwtAuthenticationFilter = jwtAuthenticationFilter;
  }

  @Override
  protected void configure(HttpSecurity http) throws Exception {

    http
      .cors()
      .and()
      .csrf()
      .disable()
      .exceptionHandling()
      .and()
      .sessionManagement()
      .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
      .and()
      .exceptionHandling()
      .and()
      .authorizeRequests()
      // Static assets
      .antMatchers("/",
        "/static/**/*",
        "/asset-manifest.json",
        "/favicon.ico",
        "/index.html",
        "/logo192.png",
        "/logo512.png",
        "/manifest.json",
        "/robots.txt"
      )
      .permitAll()
      // API Docs
      .antMatchers(
        "/swagger-ui/**",
        "/v3/api-docs/**",
        "/v3/api-docs.*"
      )
      .permitAll()
      // Registration and Authentication endpoints
      .antMatchers(
        "/api/v1/users/sign-up",
        "/api/v1/users/sign-in",
        "/api/v1/users/sign-out",
        "/api/v1/users/check-availability",
        "/api/v1/users/password-reset",
        "/error"
      )
      .permitAll()
      .anyRequest()
      .authenticated();

    http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

  }


  @Bean
  public CorsFilter corsFilter() {
    UrlBasedCorsConfigurationSource source =
      new UrlBasedCorsConfigurationSource();
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowCredentials(true);
    config.addAllowedOrigin("*");
    config.addAllowedHeader("*");
    config.addAllowedMethod("*");
    source.registerCorsConfiguration("/**", config);

    return new CorsFilter(source);
  }

  @Bean
  @Override
  protected AuthenticationManager authenticationManager() throws Exception {
    return super.authenticationManager();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }
}
