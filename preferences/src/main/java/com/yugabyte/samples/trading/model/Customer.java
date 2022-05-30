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

@Entity
@Table(name = "customers")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class Customer {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer customerId;

  @NonNull
  @NotNull
  @Column(length = 50)
  private String customerName;

  @Column(length = 50)
  private String contactEmail;

  @Column(length = 20)
  private String customerPhone;

  @NonNull
  @Column(length = 20)
  @Enumerated(STRING)
  private RegionType preferredRegion;

  @Column(insertable = false, updatable = false)
  private Instant createdDate;


  @Column(insertable = false, updatable = false)
  private Instant updatedDate;
}
