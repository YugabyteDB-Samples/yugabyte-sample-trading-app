-- All Password = Password#123

INSERT INTO users (username, password)
VALUES ('superadmin', '{bcrypt}$2a$10$tSM9pJKQBwcTUmF2JU0OMeXp.xw5Jrpkod9We7ViCCAJhi16OBCBC'),
       ('admin', '{bcrypt}$2a$10$H8HTaI2dT9Udr2OfsY8n3eZQX.dZTiSCJOAxD9zeRTX9yZ/OAIE2.'),
       ('support', '{bcrypt}$2a$10$H8HTaI2dT9Udr2OfsY8n3eZQX.dZTiSCJOAxD9zeRTX9yZ/OAIE2.'),
       ('test1@gmail.com', '{bcrypt}$2a$10$GddY6N91rEZb2w8HctJ22OpTew9rEbBOzvHmoNBRW0eBTns57cLPW'),
       ('test2@gmail.com', '{bcrypt}$2a$10$yff4ZmyqBIOsYPBe.NDnte7DR7bTdT.4T/YlkeB02boc5HdH/hg1W'),
       ('test3@gmail.com', '{bcrypt}$2a$10$v7K90bPUvAubpRMBcjEdQOaQR87LsGLN0kOCELk24GB3cMy7siWNi');

INSERT INTO authorities (username, authority)
VALUES ('superadmin', 'SUPERADMIN'),
       ('admin', 'ADMIN'),
       ('support', 'SUPPORT'),
       ('test1@gmail.com', 'USER'),
       ('test2@gmail.com', 'USER'),
       ('test3@gmail.com', 'USER');


