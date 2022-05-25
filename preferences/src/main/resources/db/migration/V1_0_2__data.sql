
insert into customers (customer_id, customer_name, contact_email, customer_phone,preferred_region)
values
  (1, 'test1', 'test1@gmail.com', '512-000-0212', 'US'),
  (2, 'test2', 'test2@gmail.com', '787-000-0212', 'EU'),
 (3, 'test3', 'test3@gmail.com', '888-000-0212', 'AP');

insert into customer_preferences (customer_id, account_id, account_statement_delivery, tax_forms_delivery, trade_confirmation, daily_trade_blog )
values
  (1, 'ACTID-1', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', 'OPT_IN'),
  (2, 'ACTID-2', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', 'OPT_OUT'),
  (3, 'ACTID-3', 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', 'OPT_OUT');
