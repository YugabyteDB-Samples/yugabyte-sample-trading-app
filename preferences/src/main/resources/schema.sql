-- auto-generated definition
create sequence if not exists hibernate_sequence;

CREATE TABLE if not exists public.Customer_Preferences (
     customer_id integer DEFAULT nextval('hibernate_sequence'),
     customer_name  varchar(50),
     account_id varchar(50),
     contact_email varchar(50),
     account_statement_delivery varchar(20) DEFAULT ('US MAIL'),
     tax_forms_delivery  varchar(20) DEFAULT ('eDelivery'),
     trade_confirmation  varchar(20) DEFAULT ('eDelivery'),
     Trade_education_blog varchar(20)  DEFAULT ('Opt-in'),
     preferred_region varchar(20),
     created_date TIMESTAMP DEFAULT NOW(),
     updated_date TIMESTAMP DEFAULT NOW()
) PARTITION BY LIST (preferred_region);

create unique index if not exists uk_cpref_userid on customer_Preferences using lsm (customer_id);

--create table if not exists public.cpref (
 --   id bigint primary key not null,
 --   customer_id character varying(255),
 --   stmt character varying(30),
 --   tx_confirm character varying(30),
 --   tx_forms character varying(30)
-- );

--crate tablespaces
drop tablespace  eu_central_1_tablespace;
CREATE TABLESPACE eu_central_1_tablespace WITH (
  replica_placement='{"num_replicas": 3, "placement_blocks":
  [{"cloud":"aws","region":"eu-central-1","zone":"eu-central-1a","min_num_replicas":1},
  {"cloud":"aws","region":"eu-central-1","zone":"eu-central-1a","min_num_replicas":1},
  {"cloud":"aws","region":"eu-central-1","zone":"eu-central-1a","min_num_replicas":1}]}'
);

CREATE TABLESPACE us_west_2_tablespace WITH (
  replica_placement='{"num_replicas": 3, "placement_blocks":
  [{"cloud":"aws","region":"us-west-2","zone":"us-west-2a","min_num_replicas":1},
  {"cloud":"aws","region":"us-west-2","zone":"us-west-2a","min_num_replicas":1},
  {"cloud":"aws","region":"us-west-2","zone":"us-west-2a","min_num_replicas":1}]}'
);

CREATE TABLESPACE ap_southeast_1_tablespace WITH (
  replica_placement='{"num_replicas": 3, "placement_blocks":
  [{"cloud":"aws","region":"ap-southeast-1","zone":"ap-southeast-1a","min_num_replicas":1},
  {"cloud":"aws","region":"ap-southeast-1","zone":"ap-southeast-1a","min_num_replicas":1},
  {"cloud":"aws","region":"ap-southeast-1","zone":"ap-southeast-1a","min_num_replicas":1}]}'
);

--create tables
CREATE TABLE Customer_Preferences_eu_central
    PARTITION OF Customer_Preferences
      (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery,trade_confirmation, 
       trade_education_blog, preferred_region,created_date, updated_date, 
      PRIMARY KEY (customer_id HASH, account_id))
    FOR VALUES IN ('EU') TABLESPACE eu_central_1_tablespace;

CREATE INDEX ON Customer_Preferences_us_east(customer_id) TABLESPACE eu_central_1_tablespace;


CREATE TABLE Customer_Preferences_us_west
    PARTITION OF Customer_Preferences
       (customer_id, customer_name, account_id, contact_email, account_statement_delivery, tax_forms_delivery,trade_confirmation, 
       trade_education_blog, preferred_region,created_date, updated_date, 
       PRIMARY KEY (customer_id HASH, account_id))
    FOR VALUES IN ('US') TABLESPACE us_west_2_tablespace;

CREATE INDEX ON Customer_Preferences_us_west(customer_id) TABLESPACE us_west_2_tablespace;

CREATE TABLE Customer_Preferences_ap_southeast
    PARTITION OF Customer_Preferences
      (user_id, name, contact_email, account_statement_delivery, sub_view_points, preferred_region,
      created_date, updated_date, 
       PRIMARY KEY (user_id HASH, account_id))
    FOR VALUES IN ('AP') TABLESPACE ap_southeast_1_tablespace;

CREATE INDEX ON Customer_Preferences_ap_southeast(customer_id) TABLESPACE ap_southeast_1_tablespace;
