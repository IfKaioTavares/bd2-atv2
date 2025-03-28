INSERT INTO users(public_id, "name", last_name, birth_day, email, phone_number, role_id, subscription_plan_id)
VALUES(gen_random_uuid(), 'Adm', 'ecommerceAdm', '1996-06-15', 'ecommerce@contato.com', '75922222222', 1, 2);

DO $$
DECLARE
    i INT;
    random_birth_day DATE;
    random_phone_number TEXT;
    random_subscription_plan INT;
BEGIN
    FOR i IN 1..40000 LOOP
        -- Gerar uma data de nascimento aleatória entre 18 e 40 anos atrás
        random_birth_day := CURRENT_DATE - INTERVAL '18 years' - (RANDOM() * (INTERVAL '22 years'));
        
        -- Gerar um número de telefone aleatório (exemplo: 11999999999)
        random_phone_number := '119' || LPAD(FLOOR(RANDOM() * 1000000000)::TEXT, 8, '0');
        
        CALL proc_create_standard_user( 
    		'User' || (i + 1),        
            'Example' || (i + 1),          
            'user' || (i+1) || '@example.com',
    		random_phone_number, 
            random_birth_day
		);
    END LOOP;
END $$;