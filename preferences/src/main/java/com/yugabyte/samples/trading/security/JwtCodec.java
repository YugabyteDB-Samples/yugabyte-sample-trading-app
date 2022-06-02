package com.yugabyte.samples.trading.security;

import static java.time.Instant.now;
import static java.util.Date.from;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import java.util.Date;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class JwtCodec {

  @Value("${app.security.jwt.secret}")
  private String jwtSecret;

  @Value("${app.security.jwt.expiry}")
  private Integer expirySeconds;

  public String generateToken(UserDetails userDetails) {
    Date now = from(now());
    Date expiryDate = from(now().plusSeconds(expirySeconds));
    var subject = userDetails.getUsername();
    return Jwts.builder()
      .setIssuedAt(now)
      .setExpiration(expiryDate)
      .setSubject(subject)
      .signWith(SignatureAlgorithm.HS512, jwtSecret)
      .compact();
  }

  public String getUserIdFromJWT(String token) {
    return Jwts
      .parser()
      .setSigningKey(jwtSecret)
      .parseClaimsJws(token)
      .getBody()
      .getSubject();
  }

  public boolean validateToken(String authToken) {
    try {
      Jwts.parser()
        .setSigningKey(jwtSecret)
        .parseClaimsJws(authToken);
      return true;
    } catch (SignatureException ex) {
      log.error("Invalid JWT signature");
    } catch (MalformedJwtException ex) {
      log.error("Invalid JWT token");
    } catch (ExpiredJwtException ex) {
      log.error("Expired JWT token");
    } catch (UnsupportedJwtException ex) {
      log.error("Unsupported JWT token");
    } catch (IllegalArgumentException ex) {
      log.error("JWT claims string is empty.");
    }
    return false;
  }

}
