-- auto-generated definition
create sequence if not exists hibernate_sequence;

CREATE TABLE if not exists public.cpref (
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

create unique index if not exists uk_cpref_userid on cpref using lsm (customer_id);

--create table if not exists public.cpref (
 --   id bigint primary key not null,
 --   customer_id character varying(255),
 --   stmt character varying(30),
 --   tx_confirm character varying(30),
 --   tx_forms character varying(30)
-- );

