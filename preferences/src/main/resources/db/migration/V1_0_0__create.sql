
CREATE TYPE delivery AS ENUM ('US_MAIL','EDELIVERY');

CREATE TYPE region AS ENUM ('US', 'EU','AP','OTHER');

CREATE SEQUENCE IF NOT EXISTS s_user_id;

CREATE TABLE IF NOT EXISTS user_preferences
(
  customer_id                integer     DEFAULT nextval('s_user_id'),
  customer_name              varchar(50),
  account_id                 varchar(50),
  contact_email              varchar(50),
  account_statement_delivery delivery DEFAULT ('US_MAIL'),
  tax_forms_delivery         delivery DEFAULT ('EDELIVERY'),
  trade_confirmation         delivery DEFAULT ('EDELIVERY'),
  Trade_education_blog       bool DEFAULT FALSE,
  preferred_region           region NULL NULL,
  created_date               TIMESTAMP   DEFAULT NOW(),
  updated_date               TIMESTAMP   DEFAULT NOW()
) PARTITION BY LIST (preferred_region);

--create unique index if not exists uk_cpref_userid on user_preferences using lsm (customer_id,preferred_region);

CREATE TABLE if not exists user_preferences_us_west
  PARTITION OF user_preferences
    (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery,trade_confirmation,
      trade_education_blog, preferred_region,created_date, updated_date,
      PRIMARY KEY (customer_id HASH, account_id))
    FOR VALUES IN ('US');-- TABLESPACE us_west_2_tablespace

CREATE TABLE if not exists user_preferences_eu_central
  PARTITION OF user_preferences
    (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery,trade_confirmation,
      trade_education_blog, preferred_region,created_date, updated_date,
      PRIMARY KEY (customer_id HASH, account_id))
    FOR VALUES IN ('EU');
--TABLESPACE eu_central_1_tablespace;

CREATE TABLE if not exists user_preferences_ap_southeast
  PARTITION OF user_preferences
    (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery,trade_confirmation,
      trade_education_blog, preferred_region,created_date, updated_date,
      PRIMARY KEY (customer_id HASH, account_id))
    FOR VALUES IN ('AP'); --TABLESPACE ap_southeast_1_tablespace;
