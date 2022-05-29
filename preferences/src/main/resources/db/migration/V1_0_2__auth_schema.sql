CREATE TABLE IF NOT EXISTS users
(
  username VARCHAR(50)  NOT NULL PRIMARY KEY,
  password VARCHAR(500) NOT NULL,
  enabled  BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS authorities
(
  id        SERIAL PRIMARY KEY,
  username  VARCHAR(50) NOT NULL,
  authority VARCHAR(50) NOT NULL,
  CONSTRAINT fk_authorities_users FOREIGN KEY (username) REFERENCES users (username)
);
CREATE UNIQUE INDEX ix_auth_username on authorities (username, authority);


