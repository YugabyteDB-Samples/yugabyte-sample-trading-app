package com.yugabyte.samples.trading.preferences.model;

import static javax.persistence.EnumType.STRING;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.With;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "user_preferences", schema = "public", catalog = "tradepref")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserPreferences {

  @Id
  @Basic
  @Column(name = "customer_id")
  @GeneratedValue(generator = "s_user_id")
  @GenericGenerator(
    name = "s_user_id",
    strategy = "org.hibernate.id.enhanced.SequenceStyleGenerator",
    parameters = {
      @Parameter(name = "sequence_name", value = "s_user_id")
    }
  )
  private Integer customerId;

  @Basic
  @Column(name = "customer_name", length = 50)
  private String customerName;

  @Basic
  @Column(name = "account_id", length = 50)
  private String accountId;

  @Basic
  @Column(name = "contact_email", length = 50)
  private String contactEmail;

  @Basic
  @Column(name = "account_statement_delivery")
  @Enumerated(STRING)
  private DeliveryType accountStatementDelivery;

  @Basic
  @Column(name = "tax_forms_delivery")
  @Enumerated(STRING)
  private DeliveryType taxFormsDelivery;

  @Basic
  @Column(name = "trade_confirmation")
  @Enumerated(STRING)
  private DeliveryType tradeConfirmation;

  @Basic
  @Column(name = "trade_education_blog")
  private Boolean tradeEducationBlog;

  @Basic
  @Column(name = "preferred_region")
  @Enumerated(STRING)
  private RegionType preferredRegion;

  @Basic
  @Column(name = "created_date")
  private Instant createdDate;

  @Basic
  @Column(name = "updated_date")
  private Instant updatedDate;

}
