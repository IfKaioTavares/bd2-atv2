-- PROCEDURE: public.proc_create_brand(character varying)

-- DROP PROCEDURE IF EXISTS public.proc_create_brand(character varying);

CREATE OR REPLACE PROCEDURE public.proc_create_brand(
	IN p_name character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_existing_brand INTEGER;
BEGIN
    -- Verificar se já existe uma marca ativa com o mesmo nome
    SELECT COUNT(*) INTO v_existing_brand 
    FROM public.brands 
    WHERE name = p_name AND deleted = FALSE;
    
    IF v_existing_brand > 0 THEN
        RAISE EXCEPTION 'Já existe uma marca ativa com este nome.';
    END IF;
    
    -- Inserir a nova marca
    INSERT INTO public.brands (name)
    VALUES (p_name);
    
    RAISE NOTICE 'Marca criada com sucesso.';
END;
$BODY$;
ALTER PROCEDURE public.proc_create_brand(character varying)
    OWNER TO postgres;
