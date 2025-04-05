-- 3. Grants
GRANT CONNECT ON DATABASE "bd2-atv2" TO app_readonly, app_rw;
GRANT USAGE  ON SCHEMA public TO app_readonly, app_rw;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_readonly;
GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO app_rw;
