
CREATE TABLESPACE us_tablespace WITH (
  replica_placement='{ "num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"us-east-2","zone":"us-east-2c","min_num_replicas":1}]}'
  );

CREATE TABLESPACE eu_tablespace WITH (
  replica_placement='{"num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"eu-central-1","zone":"eu-central-1c","min_num_replicas":1}]}'
  );

CREATE TABLESPACE ap_tablespace WITH (
  replica_placement='{"num_replicas": 1, "placement_blocks":[{"cloud":"aws","region":"ap-southeast-1","zone":"ap-southeast-1c","min_num_replicas":1}]}'
  );

create role flyway login;

alter role flyway set force_global_transaction = TRUE;
grant all privileges on database yugabyte to flyway;
grant all privileges on all tables in schema public to flyway;
grant all privileges on all sequences in schema public to flyway;
grant all privileges on all functions in schema public to flyway;
grant all privileges on all routines in schema public to flyway;
grant all privileges on tablespace ap_tablespace to flyway;
grant all privileges on tablespace eu_tablespace to flyway;
grant all privileges on tablespace us_tablespace to flyway;
grant all privileges ON SCHEMA public to flyway;

