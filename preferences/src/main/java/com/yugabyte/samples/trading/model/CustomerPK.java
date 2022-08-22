package com.yugabyte.samples.trading.model;

import static javax.persistence.EnumType.STRING;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.Serializable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.extern.slf4j.Slf4j;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
@Slf4j
public final class CustomerPK implements Serializable {

  private static final String ID_STRING_FORMAT = "%1$s-%2$s";
  private static final Pattern ID_STRING_PARSER = Pattern.compile("(\\w{2})-(\\d+)");

  @NonNull
  @Column(name = "preferred_region", length = 20)
  @Enumerated(STRING)
  private RegionType region;

  @Column(name = "customer_id")
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer accountNumber;


  public CustomerPK(String region, Integer accountNumber){
    this(RegionType.valueOf(region), accountNumber);
  }
  public static CustomerPK forRegion(RegionType region) {
    return new CustomerPK(region, null);
  }

  public static CustomerPK forRegion(String region) {
    return forRegion(RegionType.valueOf(region));
  }
  public String accountString() {
	  return accountNumber.toString();
  }
  public String asString() {
    return String.format(ID_STRING_FORMAT, region.name(), accountNumber);
  }
  public void fromString(String externalId) {
    Matcher m = ID_STRING_PARSER.matcher(externalId);
    if (m.matches()) {
      log.info("Converting to customer id - id:[{}]", externalId);
      this.region = RegionType.valueOf(m.group(1));
      this.accountNumber = Integer.valueOf(m.group(2));
    }else{
      throw new IllegalArgumentException(String.format("'%1$s': invalid argumante for customer pk string", externalId));
    }
  }
}
