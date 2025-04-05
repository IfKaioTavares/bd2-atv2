-- 2. Função genérica (captura INSERT/UPDATE/DELETE)
CREATE OR REPLACE FUNCTION fn_audit() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log(schema_name,table_name,op,changed_by,pk,new_data)
        VALUES (TG_TABLE_SCHEMA,TG_TABLE_NAME,'I',current_user,
                to_jsonb(NEW.*)->'id',to_jsonb(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log(schema_name,table_name,op,changed_by,pk,old_data,new_data)
        VALUES (TG_TABLE_SCHEMA,TG_TABLE_NAME,'U',current_user,
                to_jsonb(NEW.*)->'id',to_jsonb(OLD),to_jsonb(NEW));
        RETURN NEW;
    ELSE -- DELETE
        INSERT INTO audit_log(schema_name,table_name,op,changed_by,pk,old_data)
        VALUES (TG_TABLE_SCHEMA,TG_TABLE_NAME,'D',current_user,
                to_jsonb(OLD.*)->'id',to_jsonb(OLD));
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;