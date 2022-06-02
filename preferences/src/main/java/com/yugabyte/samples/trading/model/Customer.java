package com.yugabyte.samples.trading.model;

import static javax.persistence.EnumType.STRING;

import java.time.Instant;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import net.minidev.json.annotate.JsonIgnore;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Entity
@Table(name = "customers")
public class Customer {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer customerId;

  @NonNull
  @NotNull
  @Column(length = 50)
  private String fullName;

  @Column(length = 50)
  private String email;

  @JsonIgnore
  private String password;

  private Boolean enabled;

  @Column(length = 20)
  private String phoneNumber;

  @NonNull
  @Column(length = 20)
  @Enumerated(STRING)
  private RegionType preferredRegion;

  @Enumerated(STRING)
  private DeliveryType accountStatementDelivery;

  @Enumerated(STRING)
  private DeliveryType taxFormsDelivery;

  @Enumerated(STRING)
  private DeliveryType tradeConfirmation;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeBlog;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeWebinar;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeNewsletter;

  @Column(insertable = false, updatable = false)
  private Instant createdDate;


  @Column(insertable = false, updatable = false)
  private Instant updatedDate;
}
