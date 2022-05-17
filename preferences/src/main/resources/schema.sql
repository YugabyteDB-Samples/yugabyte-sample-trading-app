create sequence if not exists s_user_id;
CREATE TABLE if not exists User_Preferences (
     customer_id integer DEFAULT nextval('s_user_id'),
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

create unique index if not exists uk_cpref_userid on User_Preferences using lsm (customer_id);
