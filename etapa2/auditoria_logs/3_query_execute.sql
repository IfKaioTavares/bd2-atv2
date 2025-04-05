-- 3. Gerar triggers nas tabelas de negócio (ex.: products)
DO $$
DECLARE t TEXT;
BEGIN
    FOR t IN SELECT table_name
             FROM information_schema.tables
             WHERE table_schema='public'
               AND table_type='BASE TABLE'
               AND table_name NOT IN ('audit_log') LOOP
        EXECUTE format(
          'CREATE OR REPLACE TRIGGER trg_audit_%I
             AFTER INSERT OR UPDATE OR DELETE ON %I
             FOR EACH ROW EXECUTE FUNCTION fn_audit();',
          t,t);
    END LOOP;
END $$;
