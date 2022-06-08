package com.yugabyte.samples.trading.model;

import static com.yugabyte.samples.trading.model.DeliveryType.EDELIVERY;
import static com.yugabyte.samples.trading.model.DeliveryType.US_MAIL;
import static com.yugabyte.samples.trading.model.SubscriptionStatus.OPT_IN;
import static com.yugabyte.samples.trading.model.SubscriptionStatus.OPT_OUT;
import static javax.persistence.EnumType.STRING;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.Instant;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Entity
@Table(name = "customers")
public class Customer {


  @EmbeddedId
  private CustomerPK id;

  @NonNull
  @NotNull
  @Column(length = 50)
  private String fullName;

  @Column(length = 50)
  private String email;

  @JsonIgnore()
  private String password;

  private Boolean enabled;

  @Column(length = 20)
  private String phoneNumber;

  @Enumerated(STRING)
  private DeliveryType accountStatementDelivery = US_MAIL;

  @Enumerated(STRING)
  private DeliveryType taxFormsDelivery = EDELIVERY;

  @Enumerated(STRING)
  private DeliveryType tradeConfirmation = EDELIVERY;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeBlog = OPT_IN;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeWebinar = OPT_IN;

  @Enumerated(STRING)
  private SubscriptionStatus subscribeNewsletter = OPT_OUT;

  @Column(insertable = false, updatable = false)
  private Instant createdDate;


  @Column(insertable = false, updatable = false)
  private Instant updatedDate;
}
