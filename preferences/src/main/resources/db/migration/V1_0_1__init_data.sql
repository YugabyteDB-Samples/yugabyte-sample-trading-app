SET force_global_transaction = TRUE;
INSERT INTO customers (customer_id, full_name, email, password, enabled, phone_number, preferred_region, account_statement_delivery, tax_forms_delivery, trade_confirmation, subscribe_newsletter, subscribe_webinar, subscribe_blog)
VALUES (nextval('customers_customer_id_seq'), 'Demo US User', 'us-user@example.com','$2a$10$GddY6N91rEZb2w8HctJ22OpTew9rEbBOzvHmoNBRW0eBTns57cLPW', TRUE, '512-000-0212', 'US','EDELIVERY', 'EDELIVERY', 'EDELIVERY', 'OPT_IN', 'OPT_IN','OPT_OUT'),
       (nextval('customers_customer_id_seq'), 'Demo EU User', 'eu-user@example.com','$2a$10$yff4ZmyqBIOsYPBe.NDnte7DR7bTdT.4T/YlkeB02boc5HdH/hg1W', TRUE, '787-000-0212', 'EU','US_MAIL', 'EDELIVERY', 'EDELIVERY', 'OPT_OUT', 'OPT_OUT','OPT_OUT'),
       (nextval('customers_customer_id_seq'), 'Demo AP User', 'ap-user@example.com','$2a$10$v7K90bPUvAubpRMBcjEdQOaQR87LsGLN0kOCELk24GB3cMy7siWNi', TRUE, '888-000-0212', 'AP','EDELIVERY', 'US_MAIL', 'EDELIVERY', 'OPT_OUT', 'OPT_OUT','OPT_IN');
SET force_global_transaction = FALSE;
