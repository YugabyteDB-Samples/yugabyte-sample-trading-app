package com.yugabyte.samples.trading.repository;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.CustomerPK;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.ObjectInput;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import lombok.NonNull;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.rest.webmvc.spi.BackendIdConverter;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class CustomerPKConvertor implements BackendIdConverter {

  @SneakyThrows
  @Override
  public Serializable fromRequestId(String id, Class<?> entityType) {
    log.info("Received request for id:[{}] class:[{}]", id, entityType.getSimpleName());
    if(Customer.class.equals(entityType)){
      CustomerPK pk = new CustomerPK();
      pk.fromString(id);
      return pk;
    }
    return null;
  }

  @SneakyThrows
  @Override
  public String toRequestId(Serializable id, Class<?> entityType) {
    if( id instanceof CustomerPK cpk){
      return cpk.asString();
    }else{
      return null;
    }
  }

  @Override
  public boolean supports(@NonNull Class<?> delimiter) {
    return Customer.class.equals(delimiter);
  }
}
