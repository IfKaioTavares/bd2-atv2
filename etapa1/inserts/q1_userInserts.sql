DO $$
DECLARE
    i INT;
    random_birth_day DATE;
    random_phone_number TEXT;
    random_subscription_plan INT;
BEGIN
    FOR i IN 1..100 LOOP
        -- Gerar uma data de nascimento aleatória entre 18 e 40 anos atrás
        random_birth_day := CURRENT_DATE - INTERVAL '18 years' - (RANDOM() * (INTERVAL '22 years'));
        
        -- Gerar um número de telefone aleatório (exemplo: 11999999999)
        random_phone_number := '119' || LPAD(FLOOR(RANDOM() * 1000000000)::TEXT, 8, '0');
        
        -- Mesclar o subscription_plan_id entre 1 e 2
        random_subscription_plan := FLOOR(RANDOM() * 2) + 1;
        
        INSERT INTO public.users (
            public_id, name, last_name, email, role_id, subscription_plan_id, phone_number, birth_day
        ) VALUES (
            gen_random_uuid(),  -- Gerando um UUID aleatório para public_id
            'User' || (i + 1),        -- Nome 'User' concatenado com o índice
            'Example' || (i + 1),          -- Sobrenome fixo
            'user' || (i+1) || '@example.com',  -- Email gerado dinamicamente
            1,                  -- ID de um papel de usuário (ajuste conforme necessário)
            random_subscription_plan,  -- Subscription plan aleatório entre 1 e 2
            random_phone_number,  -- Número de telefone aleatório gerado
            random_birth_day  -- Data de nascimento aleatória
        );
    END LOOP;
END $$;
