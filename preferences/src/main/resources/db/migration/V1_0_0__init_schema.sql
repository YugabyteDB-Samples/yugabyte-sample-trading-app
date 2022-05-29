CREATE TABLE IF NOT EXISTS customers
(
  customer_id      SERIAL,
  customer_name    varchar(50) NOT NULL,
  contact_email    varchar(50),
  customer_phone   varchar(20),
  preferred_region varchar(20) NOT NULL,
  created_date     TIMESTAMP DEFAULT NOW(),
  updated_date     TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (customer_id, preferred_region)
) PARTITION BY LIST (preferred_region);

--create unique index if not exists uk_cpref_userid on user_preferences using lsm (customer_id,preferred_region);

CREATE TABLE IF NOT EXISTS customer_us_west
  PARTITION OF customers
    (customer_id, customer_name, contact_email, customer_phone,
      preferred_region,created_date, updated_date)
    FOR VALUES IN ('US');-- TABLESPACE us_west_2_tablespace

CREATE TABLE if not exists customer_eu_central
  PARTITION OF customers
    (customer_id, customer_name, contact_email, customer_phone,
      preferred_region,created_date, updated_date)
    FOR VALUES IN ('EU'); --TABLESPACE eu_central_1_tablespace;

CREATE TABLE if not exists customer_ap_southeast
  PARTITION OF customers
    (customer_id, customer_name, contact_email, customer_phone,
      preferred_region,created_date, updated_date)
    FOR VALUES IN ('AP'); --TABLESPACE ap_southeast_1_tablespace;


CREATE TABLE IF NOT EXISTS preferences
(
  customer_id                    INTEGER PRIMARY KEY NOT NULL,
  account_statement_delivery VARCHAR(20)         NOT NULL DEFAULT ('US_MAIL'),
  tax_forms_delivery         VARCHAR(20)         NOT NULL DEFAULT ('EDELIVERY'),
  trade_confirmation         VARCHAR(20)         NOT NULL DEFAULT ('EDELIVERY'),
  subscribe_blog                 VARCHAR(10)         NOT NULL DEFAULT ('OPT_IN'),
  subscribe_webinar                    VARCHAR(10)         NOT NULL DEFAULT ('OPT_IN'),
  subscribe_newsletter         VARCHAR(10)         NOT NULL DEFAULT ('OPT_OUT'),
  created_date               TIMESTAMP           NOT NULL DEFAULT NOW(),
  updated_date               TIMESTAMP                    DEFAULT NOW()
    CONSTRAINT tax_form_delivery_values CHECK ( tax_forms_delivery IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT trade_confirmation_values CHECK ( trade_confirmation IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT account_statement_delivery_values CHECK ( account_statement_delivery IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT subscribe_blog_values CHECK ( subscribe_blog IN ('OPT_IN', 'OPT_OUT') )
    CONSTRAINT subscribe_webinar_values CHECK ( subscribe_webinar IN ('OPT_IN', 'OPT_OUT') )
    CONSTRAINT subscribe_newsletter_values CHECK ( subscribe_newsletter IN ('OPT_IN', 'OPT_OUT') )
);
