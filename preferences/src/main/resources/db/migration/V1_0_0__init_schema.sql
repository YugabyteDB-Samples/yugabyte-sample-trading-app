CREATE TABLE IF NOT EXISTS customers
(
  customer_id                SERIAL,
  full_name                  VARCHAR(50)  NOT NULL,
  email                      VARCHAR(50),
  password                   VARCHAR(500) NOT NULL,
  enabled                    BOOLEAN      NOT NULL DEFAULT TRUE,
  phone_number               VARCHAR(20),
  preferred_region           VARCHAR(20)  NOT NULL,
  account_statement_delivery VARCHAR(20)  NOT NULL DEFAULT ('US_MAIL'),
  tax_forms_delivery         VARCHAR(20)  NOT NULL DEFAULT ('EDELIVERY'),
  trade_confirmation          VARCHAR(20) NOT NULL DEFAULT ('EDELIVERY'),
  subscribe_blog             VARCHAR(10)  NOT NULL DEFAULT ('OPT_IN'),
  subscribe_webinar          VARCHAR(10)  NOT NULL DEFAULT ('OPT_IN'),
  subscribe_newsletter       VARCHAR(10)  NOT NULL DEFAULT ('OPT_OUT'),
  created_date               TIMESTAMP             DEFAULT NOW(),
  updated_date               TIMESTAMP             DEFAULT NOW()

    CONSTRAINT preferred_region_values CHECK ( preferred_region IN ('US', 'AP', 'EU') )
    CONSTRAINT tax_form_delivery_values CHECK ( tax_forms_delivery IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT trade_confirmation_values CHECK ( trade_confirmation IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT account_statement_delivery_values CHECK ( account_statement_delivery IN ('US_MAIL', 'EDELIVERY') )
    CONSTRAINT subscribe_blog_values CHECK ( subscribe_blog IN ('OPT_IN', 'OPT_OUT') )
    CONSTRAINT subscribe_webinar_values CHECK ( subscribe_webinar IN ('OPT_IN', 'OPT_OUT') )
    CONSTRAINT subscribe_newsletter_values CHECK ( subscribe_newsletter IN ('OPT_IN', 'OPT_OUT') ),


  PRIMARY KEY (customer_id, preferred_region)
) PARTITION BY LIST (preferred_region);
--
-- CREATE TABLESPACE us_tablespace WITH (
--   replica_placement='{ "num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"us-east-2","zone":"us-east-2c","min_num_replicas":1}]}'
--   );
--
-- CREATE TABLESPACE eu_tablespace WITH (
--   replica_placement='{"num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"eu-central-1","zone":"eu-central-1c","min_num_replicas":1}]}'
--   );
--
-- CREATE TABLESPACE ap_tablespace WITH (
--   replica_placement='{"num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"ap-southeast-1","zone":"ap-southeast-1c","min_num_replicas":1}]}'
--   );


CREATE TABLE IF NOT EXISTS customer_us
  PARTITION OF customers
    (
      customer_id,
      full_name,
      email,
      password,
      enabled,
      phone_number,
      preferred_region,
      account_statement_delivery,
      tax_forms_delivery,
      trade_confirmation,
      subscribe_blog,
      subscribe_webinar,
      subscribe_newsletter,
      created_date,
      updated_date
      )
    FOR VALUES IN ('US')
  TABLESPACE us_tablespace;

CREATE TABLE if not exists customer_eu
  PARTITION OF customers
    (
      customer_id,
      full_name,
      email,
      password,
      enabled,
      phone_number,
      preferred_region,
      account_statement_delivery,
      tax_forms_delivery,
      trade_confirmation,
      subscribe_blog,
      subscribe_webinar,
      subscribe_newsletter,
      created_date,
      updated_date
      )
    FOR VALUES IN ('EU')
  TABLESPACE eu_tablespace;

CREATE TABLE if not exists customer_ap
  PARTITION OF customers
    (
      customer_id,
      full_name,
      email,
      password,
      enabled,
      phone_number,
      preferred_region,
      account_statement_delivery,
      tax_forms_delivery,
      trade_confirmation,
      subscribe_blog,
      subscribe_webinar,
      subscribe_newsletter,
      created_date,
      updated_date
      )
    FOR VALUES IN ('AP')
  TABLESPACE ap_tablespace;
