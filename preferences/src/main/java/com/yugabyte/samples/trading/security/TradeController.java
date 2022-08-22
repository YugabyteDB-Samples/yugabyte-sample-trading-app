package com.yugabyte.samples.trading.security;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Tuple;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.RegionType;
import com.yugabyte.samples.trading.repository.CustomerRepository;
import com.yugabyte.samples.trading.repository.TradeRepository;

import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.extern.slf4j.Slf4j;
import com.yugabyte.samples.trading.model.Trade;

@Slf4j
@RestController
@RequestMapping("/api/v1/trades")
public class TradeController {
	 private  TradeRepository trades = null;

	 @Autowired
	  public TradeController(TradeRepository trades)
	  {
	    this.trades = trades;    
	  }

	  @GetMapping("/list/{customerId}")
	  @ResponseStatus(HttpStatus.OK)
	  @SecurityRequirement(name = "auth-header-bearer")
	  public List<Trade> getCustomerTrades(@PathVariable("customerId")Integer id){
		  return trades.findByCustomerId(id);
	  }
	  
	  @GetMapping("/chartData/{customerId}")
	  @ResponseStatus(HttpStatus.OK)
	  @SecurityRequirement(name = "auth-header-bearer")
	  public List<HashMap> getCustomerTradesChart(@PathVariable("customerId")Integer id){
		  List <HashMap> chartDataList = new ArrayList();
		  List<Tuple> tradeData=trades.getTradeChartDataByCustomerId(id);
		  
		  for(Tuple row: tradeData) {
			  //log.info( row.get("pricesum").toString());
			  HashMap<String, String> chartDataMap = new HashMap<>();
			  chartDataMap.put("date",row.get("order_time").toString());
			  chartDataMap.put("price",row.get("pricesum").toString());
			  chartDataList.add(chartDataMap);
		  }

		  return chartDataList;
	  }
	  
	  @GetMapping("/recentOrders/{customerId}")
	  @ResponseStatus(HttpStatus.OK)
	  @SecurityRequirement(name = "auth-header-bearer")
	  public List<HashMap> getRecentTradesByCustomerId(@PathVariable("customerId")Integer id){
		  List <HashMap> tradeList = new ArrayList();
		  List<Tuple> tradeData=trades.getRecentTradesByCustomerId(id);
		  
		  for(Tuple row: tradeData) {
			 
			  HashMap<String, String> tradeDataMap = new HashMap<>();
			  tradeDataMap.put("id",row.get("trade_id").toString());
			  tradeDataMap.put("symbol",row.get("symbol").toString());
			  tradeDataMap.put("type",row.get("trade_type").toString());
			  tradeDataMap.put("price",row.get("bid_price").toString());
			  tradeDataMap.put("time",row.get("order_time").toString());
			  tradeList.add(tradeDataMap);
		  }

		  return tradeList;
	  }
	  
}
