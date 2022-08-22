package com.yugabyte.samples.trading.model;
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
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
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
@Table(name = "trades")

public class Trade {
	  @Id
	  @Column(name = "trade_id")
	  @GeneratedValue(strategy = GenerationType.IDENTITY)
	  private Integer tradeId;
	  /*
	  @ManyToOne
	  @JoinColumns({
		  @JoinColumn(name="customer_id"),
	  	  @JoinColumn(name="preferred_region")})
	  private Customer customer;
	 */ 
	  @Column(name="customer_id")
	  private Integer customerId;
	  
	  @Column(name="symbol",length = 6)
	  private String symbol;
	  
	  @Column(name="trade_type",length = 20)
	  private String tradeType;
	  
	  @Column(name="order_time",insertable = true, updatable = true)
	  private Instant orderTime;
	  
	  @Column(name="bid_price")
	  private float bidPrice;
	  
	
	
}
