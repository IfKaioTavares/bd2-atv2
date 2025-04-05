
CREATE USER reader WITH PASSWORD '1234';
GRANT app_readonly TO reader;


CREATE USER app_user WITH PASSWORD '12345';
GRANT app_rw TO app_user;