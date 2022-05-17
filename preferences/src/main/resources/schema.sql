create table if not exists public.cpref (
    id bigint primary key not null,
    customer_id character varying(255),
    stmt character varying(30),
    tx_confirm character varying(30),
    tx_forms character varying(30)
);
create unique index if not exists uk_cpref_userid on cpref using lsm (customer_id);
