package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.CustomerPK;
import com.yugabyte.samples.trading.model.RegionType;
import com.yugabyte.samples.trading.model.Trade;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;

import java.util.List;
import java.util.Optional;

import javax.persistence.Table;
import javax.persistence.Tuple;

import lombok.NonNull;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(path = "trades")
@OpenAPIDefinition()

@SecurityRequirement(name = "auth-header-bearer")
public interface TradeRepository extends JpaRepository<Trade, Integer> {

	List<Trade> findByCustomerId(Integer customerId);
	@Query(value="select sum(bid_price) as pricesum, date (order_time) as order_time from trades where customer_id=:customerId AND order_time > current_timestamp - interval '30 day' group by date(order_time) order by order_time", nativeQuery=true)
	List<Tuple> getTradeChartDataByCustomerId(@Param("customerId")Integer customerId);

	@Query(value="select trade_id,symbol,trade_type,to_char(bid_price,'LFM99999999999999D00') as bid_price,order_time  from trades where customer_id=:customerId AND order_time > current_timestamp - interval '30 day' order by order_time limit 30", nativeQuery=true)
	List<Tuple> getRecentTradesByCustomerId(@Param("customerId")Integer customerId);


}
