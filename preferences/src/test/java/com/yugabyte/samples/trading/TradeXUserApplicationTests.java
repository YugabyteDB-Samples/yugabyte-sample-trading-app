package com.yugabyte.samples.trading;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

import com.yugabyte.samples.trading.model.Customer;
import com.yugabyte.samples.trading.model.CustomerPK;
import com.yugabyte.samples.trading.model.DeliveryType;
import com.yugabyte.samples.trading.model.SubscriptionStatus;
import com.yugabyte.samples.trading.repository.CustomerRepository;
import javax.persistence.EntityManager;
import javax.sql.DataSource;
import org.flywaydb.test.annotation.FlywayTest;
import org.flywaydb.test.junit5.FlywayTestExtension;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.testcontainers.containers.YugabyteYSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

//@SpringBootTest(classes = PreferencesApplicationTests.class)
@ExtendWith(SpringExtension.class)
@ExtendWith(FlywayTestExtension.class)
@Testcontainers
@ActiveProfiles("test")
@DataJpaTest
@AutoConfigureTestDatabase(replace = NONE)
@Disabled
class TradeXUserApplicationTests {


  @Autowired
  private DataSource dataSource;

  @Autowired
  private JdbcTemplate jdbcTemplate;

  @Autowired
  private EntityManager entityManager;

  @Autowired
  CustomerRepository customers;

  @Container
  public static YugabyteYSQLContainer container = new YugabyteYSQLContainer(
    "yugabytedb/yugabyte:2.13.1.0-b112")
    .withDatabaseName("yugabyte")
    .withUsername("yugabyte")
    .withPassword("yugabyte")
    .withReuse(true);

  @DynamicPropertySource
  static void datasourceProps(final DynamicPropertyRegistry registry) {
    registry.add("spring.datasource.url", container::getJdbcUrl);
    registry.add("spring.datasource.username", container::getUsername);
    registry.add("spring.datasource.password", container::getPassword);
    registry.add("spring.datasource.driver-class-name", () -> "com.yugabyte.Driver");
    registry.add("spring.flyway.driver-class-name", () -> "com.yugabyte.Driver");
    registry.add("spring.flyway.url", container::getJdbcUrl);
    registry.add("spring.flyway.user", container::getUsername);
    registry.add("spring.flyway.password", container::getPassword);
  }
  @Test
  void injectedComponentsAreNotNull() {
    assertThat(dataSource).isNotNull();
    assertThat(jdbcTemplate).isNotNull();
    assertThat(entityManager).isNotNull();
  }


  @Test
  void contextLoads() {
  }

  @Test
  @FlywayTest
  void shouldCreateOneRecord() {
    var customer = Customer.builder()
      .fullName("Test Customer")
      .id(CustomerPK.forRegion("AP"))
      .accountStatementDelivery(DeliveryType.EDELIVERY)
      .taxFormsDelivery(DeliveryType.EDELIVERY)
      .tradeConfirmation(DeliveryType.EDELIVERY)
      .subscribeWebinar(SubscriptionStatus.OPT_IN)
      .subscribeBlog(SubscriptionStatus.OPT_IN)
      .subscribeNewsletter(SubscriptionStatus.OPT_IN)
      .build();
    var savedCustomer = customers.save(customer);

    var actualOptional =  customers.findById(savedCustomer.getId());
    assertThat(actualOptional).isNotNull().isPresent();
    var actual = actualOptional.get();
    assertThat(savedCustomer).isEqualTo(actual);
  }


}
