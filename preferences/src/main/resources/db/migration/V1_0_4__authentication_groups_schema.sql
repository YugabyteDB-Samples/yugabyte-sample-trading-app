CREATE TABLE IF NOT EXISTS groups
(
  id         SERIAL PRIMARY KEY,
  group_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS group_authorities
(
  group_id  SERIAL PRIMARY KEY,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_group_authorities_group FOREIGN KEY (group_id) REFERENCES groups (id)
);

CREATE TABLE IF NOT EXISTS group_members
(
  id       SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  group_id BIGINT      NOT NULL,
  CONSTRAINT fk_group_members_group FOREIGN KEY (group_id) REFERENCES groups (id)
);
