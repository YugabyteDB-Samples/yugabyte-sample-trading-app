package com.yugabyte.samples.trading.model;

import static javax.persistence.EnumType.STRING;

import java.time.Instant;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Entity
@Table(name = "preferences")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Preference {

  @Id
  @NonNull
  private Integer customerId;

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
