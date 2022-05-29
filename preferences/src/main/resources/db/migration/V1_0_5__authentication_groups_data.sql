INSERT INTO groups (group_name)
VALUES ('SUPER_ADMINS'),
       ('ADMINS'),
       ('SUPPORT'),
       ('USERS'),
       ('AUDITORS');



INSERT INTO group_authorities (group_id, authority)
select id, 'SUPERADMIN'
from groups
where group_name = 'SUPER_ADMINS';


INSERT INTO group_authorities (group_id, authority)
select id, 'ADMIN'
from groups
where group_name = 'ADMINS';

INSERT INTO group_authorities (group_id, authority)
select id, 'SUPPORT'
from groups
where group_name = 'SUPPORT';

INSERT INTO group_authorities (group_id, authority)
select id, 'USER'
from groups
where group_name = 'USERS';

INSERT INTO group_authorities (group_id, authority)
select id, 'AUDITOR'
from groups
where group_name = 'AUDITORS';
