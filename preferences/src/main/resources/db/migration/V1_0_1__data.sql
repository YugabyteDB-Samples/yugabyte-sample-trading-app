insert into user_preferences (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery, trade_confirmation, trade_education_blog, preferred_region, created_date, updated_date)
values
  (1, 'Customer 1', 'ACTID-1', 'customer-1@yugabyte.com', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', TRUE, 'US', '2022-05-18 19:00:00', '2022-05-18 19:00:00'),
  (2, 'Customer 2', 'ACTID-2', 'customer-2@yugabyte.com', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', TRUE, 'EU', '2022-05-18 19:00:00', '2022-05-18 19:00:00'),
  (3, 'Customer 3', 'ACTID-3', 'customer-3@yugabyte.com', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', TRUE, 'AP', '2022-05-18 19:00:00', '2022-05-18 19:00:00');
