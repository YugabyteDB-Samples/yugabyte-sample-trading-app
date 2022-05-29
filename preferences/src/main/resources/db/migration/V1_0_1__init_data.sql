INSERT INTO customers (customer_id, customer_name, contact_email, customer_phone, preferred_region)
VALUES (1, 'test1', 'test1@gmail.com', '512-000-0212', 'US'),
       (2, 'test2', 'test2@gmail.com', '787-000-0212', 'EU'),
       (3, 'test3', 'test3@gmail.com', '888-000-0212', 'AP');

INSERT INTO preferences (customer_id, account_statement_delivery, tax_forms_delivery, trade_confirmation, subscribe_newsletter, subscribe_webinar, subscribe_blog )
VALUES (1, 'EDELIVERY', 'EDELIVERY', 'EDELIVERY', 'OPT_IN', 'OPT_IN','OPT_OUT'),
       (2, 'US_MAIL', 'EDELIVERY', 'EDELIVERY', 'OPT_OUT', 'OPT_OUT','OPT_OUT'),
       (3, 'EDELIVERY', 'US_MAIL', 'EDELIVERY', 'OPT_OUT', 'OPT_OUT','OPT_IN');

