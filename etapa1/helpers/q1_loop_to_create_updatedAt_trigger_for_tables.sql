DO $$ 
DECLARE 
    tbl RECORD;
BEGIN
    FOR tbl IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
    LOOP
        -- Verifica se a trigger já existe antes de criá-la
        IF NOT EXISTS (
            SELECT 1 FROM pg_trigger 
            WHERE tgrelid = tbl.tablename::regclass 
            AND tgname = format('trigger_update_timestamp_%s', tbl.tablename)
        ) THEN
            EXECUTE format('
                CREATE TRIGGER trigger_update_timestamp_%s
                BEFORE UPDATE OR DELETE ON %I
                FOR EACH ROW
                EXECUTE FUNCTION update_timestamp();', tbl.tablename, tbl.tablename);
        END IF;
    END LOOP;
END $$;
