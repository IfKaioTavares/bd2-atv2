
-- q1 dos helpers cria um loop para criar o trigger para todas as tabelas existentes
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza a coluna updated_at para o momento atual em um UPDATE
    IF TG_OP = 'UPDATE' THEN
        NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
    END IF;

    -- Para DELETE, a trigger só atualiza a coluna updated_at antes da exclusão
    IF TG_OP = 'DELETE' THEN
        UPDATE public.users SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Depois de criar essa trigger function, crie a event trigger q1
CREATE OR REPLACE FUNCTION create_trigger_for_new_table()
RETURNS EVENT_TRIGGER AS $$
DECLARE
    cmd record;
    full_name text;
    schema_name text;
    table_name text;
BEGIN
    -- Recupera o nome da tabela recém-criada
    FOR cmd IN
        SELECT object_identity
        FROM pg_event_trigger_ddl_commands()
        WHERE command_tag = 'CREATE TABLE'
    LOOP
        full_name := cmd.object_identity::text;
        
        -- Extrai o esquema e o nome da tabela a partir do nome qualificado
        -- O formato é tipicamente "esquema.tabela" ou, às vezes, apenas "tabela"
        IF full_name LIKE '%.%' THEN
            schema_name := split_part(regexp_replace(full_name, '"', '', 'g'), '.', 1);
            table_name := split_part(regexp_replace(full_name, '"', '', 'g'), '.', 2);
        ELSE
            schema_name := 'public';
            table_name := regexp_replace(full_name, '"', '', 'g');
        END IF;
        
        -- Cria a trigger de atualização para a nova tabela
        EXECUTE format('
            CREATE TRIGGER trigger_update_timestamp_%I
            BEFORE UPDATE OR DELETE ON %I.%I
            FOR EACH ROW
            EXECUTE FUNCTION update_timestamp();', 
            table_name, schema_name, table_name);
        
        RAISE NOTICE 'Trigger criada para a tabela: %.%', schema_name, table_name;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
