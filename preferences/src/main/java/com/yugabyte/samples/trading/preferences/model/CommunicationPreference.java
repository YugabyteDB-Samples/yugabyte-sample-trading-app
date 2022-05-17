package com.yugabyte.samples.trading.preferences.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="cpref")
@Data
@NoArgsConstructor
public class CommunicationPreference {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  @Enumerated(EnumType.STRING)
  @Column(name="stmt", length = 30)
  private DeliveryMethod statementDelivery = DeliveryMethod.US_MAIL;

  @Enumerated(EnumType.STRING)
  @Column(name="tx_confirm",length = 30)
  private DeliveryMethod tradeConfirmation = DeliveryMethod.US_MAIL;

  @Enumerated(EnumType.STRING)
  @Column(name="tx_forms", length = 30)
  private DeliveryMethod tradeForms = DeliveryMethod.US_MAIL;

  @Column(unique=true)
  private String customerId;
}


