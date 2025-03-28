-- PROCEDURE: public.proc_create_standard_user(character varying, character varying, character varying, character, date)

-- DROP PROCEDURE IF EXISTS public.proc_create_standard_user(character varying, character varying, character varying, character, date);

CREATE OR REPLACE PROCEDURE public.proc_create_standard_user(
	IN p_name character varying,
	IN p_last_name character varying,
	IN p_email character varying,
	IN p_phone_number character,
	IN p_birth_day date)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_existing_user INTEGER;
    v_age INTEGER;
BEGIN
    -- Verificar se já existe um usuário ativo com o mesmo email
    SELECT COUNT(*) INTO v_existing_user 
    FROM public.users 
    WHERE email = p_email AND deleted = FALSE;
    
    IF v_existing_user > 0 THEN
        RAISE EXCEPTION 'Já existe um usuário ativo com este email.';
    END IF;
    
    -- Calcular a idade do usuário
    SELECT EXTRACT(YEAR FROM AGE(p_birth_day)) INTO v_age;
    
    IF v_age < 18 THEN
        RAISE EXCEPTION 'O usuário deve ter pelo menos 18 anos.';
    END IF;
    
    -- Inserir o novo usuário
    INSERT INTO public.users (
        public_id, name, last_name, email, role_id, subscription_plan_id, 
        phone_number, birth_day
    ) VALUES (
        gen_random_uuid(), p_name, p_last_name, p_email, 2, 1, 
        p_phone_number, p_birth_day
    );
    
    RAISE NOTICE 'Usuário criado com sucesso.';
END;
$BODY$;
ALTER PROCEDURE public.proc_create_standard_user(character varying, character varying, character varying, character, date)
    OWNER TO postgres;
