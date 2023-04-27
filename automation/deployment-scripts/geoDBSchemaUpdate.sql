truncate table trade_orders ;
drop view if exists stock_period_info_v;
drop view if exists current_stocks_v;
drop table if exists app_user cascade;
drop table if exists trade_orders;

CREATE TABLE APP_USER (
  ID                    SERIAL,
  EMAIL                      VARCHAR(50),
  PASSKEY                   VARCHAR(100) NOT NULL,
  ENABLED                    BOOLEAN      NOT NULL DEFAULT TRUE,
  PERSONAL_DETAILS           JSON NOT NULL,
  USER_LANGUAGE VARCHAR(50) DEFAULT 'EN-UK',
  USER_NOTIFICATIONS                JSON NOT NULL,
  PREFERRED_REGION           VARCHAR(20)  NOT NULL,
  CREATED_DATE               TIMESTAMP             DEFAULT NOW(),
  UPDATED_DATE               TIMESTAMP             DEFAULT NOW(),
  FAVOURITES                 INTEGER[],
  SECURITY_PIN               NUMERIC(4),
  UNIQUE(EMAIL, PREFERRED_REGION)
) partition by LIST(PREFERRED_REGION);



CREATE TABLE APP_USER_BOSTON partition of APP_USER (
  ID,  EMAIL, PASSKEY , ENABLED, PERSONAL_DETAILS, USER_LANGUAGE, USER_NOTIFICATIONS, PREFERRED_REGION, CREATED_DATE, UPDATED_DATE, PRIMARY KEY (ID hash, PREFERRED_REGION)
) for values in ('boston') tablespace boston_tablespace;

CREATE TABLE APP_USER_WASHINGTON partition of APP_USER (
  ID,  EMAIL, PASSKEY , ENABLED, PERSONAL_DETAILS, USER_LANGUAGE, USER_NOTIFICATIONS, PREFERRED_REGION, CREATED_DATE, UPDATED_DATE, PRIMARY KEY (ID hash, PREFERRED_REGION)
) for values in ('washington') tablespace washington_tablespace;

CREATE TABLE APP_USER_LONDON partition of APP_USER (
  ID,  EMAIL, PASSKEY , ENABLED, PERSONAL_DETAILS, USER_LANGUAGE, USER_NOTIFICATIONS, PREFERRED_REGION, CREATED_DATE, UPDATED_DATE, PRIMARY KEY (ID hash, PREFERRED_REGION)
) for values in ('london') tablespace london_tablespace;

CREATE TABLE APP_USER_MUMBAI partition of APP_USER (
  ID,  EMAIL, PASSKEY , ENABLED, PERSONAL_DETAILS, USER_LANGUAGE, USER_NOTIFICATIONS, PREFERRED_REGION, CREATED_DATE, UPDATED_DATE, PRIMARY KEY (ID hash, PREFERRED_REGION)
) for values in ('mumbai') tablespace mumbai_tablespace;

CREATE TABLE APP_USER_SYDNEY partition of APP_USER (
  ID,  EMAIL, PASSKEY , ENABLED, PERSONAL_DETAILS, USER_LANGUAGE, USER_NOTIFICATIONS, PREFERRED_REGION, CREATED_DATE, UPDATED_DATE, PRIMARY KEY (ID hash, PREFERRED_REGION)
) for values in ('sydney') tablespace sydney_tablespace;


CREATE TABLE TRADE_ORDERS (
  ORDER_ID integer NOT NULL DEFAULT NEXTVAL('ORDER_ID_SEQ'),
  USER_ID integer NOT NULL,
  SYMBOL_ID integer,
  TRADE_TYPE character varying(5),
  ORDER_TIME timestamp(0) without time zone DEFAULT now(),
  BID_PRICE decimal(10,3),
  PREFERRED_REGION           VARCHAR(20)  NOT NULL,
  STOCK_UNITS decimal(10,3) not null default 1.0,
  PAY_METHOD varchar(20)
) partition by LIST(PREFERRED_REGION);

CREATE TABLE TRADE_ORDERS_BOSTON partition of TRADE_ORDERS (
  ORDER_ID, USER_ID, SYMBOL_ID, TRADE_TYPE, ORDER_TIME, BID_PRICE, PREFERRED_REGION, STOCK_UNITS, PAY_METHOD, PRIMARY key (ORDER_ID hash, PREFERRED_REGION)
) for values in ('boston') tablespace boston_tablespace;

CREATE TABLE TRADE_ORDERS_WASHINGTON partition of TRADE_ORDERS (
  ORDER_ID, USER_ID, SYMBOL_ID, TRADE_TYPE, ORDER_TIME, BID_PRICE, PREFERRED_REGION, STOCK_UNITS, PAY_METHOD, PRIMARY key (ORDER_ID hash, PREFERRED_REGION)
) for values in ('washington') tablespace washington_tablespace;


CREATE TABLE TRADE_ORDERS_LONDON partition of TRADE_ORDERS (
  ORDER_ID, USER_ID, SYMBOL_ID, TRADE_TYPE, ORDER_TIME, BID_PRICE, PREFERRED_REGION, STOCK_UNITS, PAY_METHOD, PRIMARY key (ORDER_ID hash, PREFERRED_REGION)
) for values in ('london') tablespace london_tablespace;

CREATE TABLE TRADE_ORDERS_MUMBAI partition of TRADE_ORDERS (
  ORDER_ID, USER_ID, SYMBOL_ID, TRADE_TYPE, ORDER_TIME, BID_PRICE, PREFERRED_REGION, STOCK_UNITS, PAY_METHOD, PRIMARY key (ORDER_ID hash, PREFERRED_REGION)
) for values in ('mumbai') tablespace mumbai_tablespace;

CREATE TABLE TRADE_ORDERS_SYDNEY partition of TRADE_ORDERS (
  ORDER_ID, USER_ID, SYMBOL_ID, TRADE_TYPE, ORDER_TIME, BID_PRICE, PREFERRED_REGION, STOCK_UNITS, PAY_METHOD, PRIMARY key (ORDER_ID hash, PREFERRED_REGION)
) for values in ('sydney') tablespace sydney_tablespace;



create or replace view current_stocks_v as (
	   select o.user_id, o.symbol_id, sum ( case when trade_type = 'BUY' then stock_units else -stock_units end) as units from trade_orders o group by o.user_id , o.symbol_id
);

create or replace view stock_period_info_v as (
   select trade_symbol_id, high_price, price_time, interval_period  from trade_symbol_price_historic tsph, current_stocks_v c where tsph.trade_symbol_id = c.symbol_id
);

INSERT INTO public.app_user (email,passkey,enabled,personal_details,user_notifications,preferred_region,SECURITY_PIN,created_date,updated_date) VALUES
	 ('mickey@tradex.com','$2a$10$.F2QPGfG8YzHRqQ1o5uuLeHiWPxLwinmFz67TIEg.4VS8PHITiHxy',true,'{"fullName":"mickey mouse", "address":"wallstreet", "phone":"+10000007", "country":"USA", "gender":"MALE"}','{"generalNotification":"ENABLED", "sound":"DISABLED", "vibrate":"ENABLED", "appUpdates":"DISABLED", "billReminder":"DISABLED", "promotion":"DISABLED", "discountAvailable":"DISABLED", "paymentReminder":"DISABLED", "newServiceAvailable":"DISABLED", "newTipsAvailable":"DISABLED" }','boston',9999, '2022-10-26 11:30:47.624492','2022-10-26 11:30:47.624492'),
	 ('donald@tradex.com','$2a$10$wK4JTnG6H02BkTBpyqbfi.O1YyMC.81FM1biSEtrvqRbA005/mR.m',true,'{"fullName":"donald duck", "address":"wallstreet", "phone":"+10000009", "country":"USA", "gender":"MALE"}','{"generalNotification":"ENABLED", "sound":"DISABLED", "vibrate":"ENABLED", "appUpdates":"DISABLED", "billReminder":"DISABLED", "promotion":"DISABLED", "discountAvailable":"DISABLED", "paymentReminder":"DISABLED", "newServiceAvailable":"DISABLED", "newTipsAvailable":"DISABLED"}','sydney',8888, '2022-10-26 11:31:41.758602','2022-10-26 11:31:41.758602');

commit;

/*

*/
--select * from pg_tablespace;

select * from app_user;

