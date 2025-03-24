DO $$
DECLARE
    i INT;
    user_id INT;
    random_address_count INT;
    random_postal_code TEXT;
    random_state TEXT;
    random_street TEXT;
    random_number INT;
    random_complement TEXT;
BEGIN
    -- Loop para percorrer os 100 usuários (assumindo que os usuários começam no id 2)
    FOR i IN 2..101 LOOP
        -- Obter o user_id do usuário
        user_id := i;
        
        -- Gerar um número aleatório de endereços entre 1 e 2
        random_address_count := FLOOR(RANDOM() * 2) + 1;
        
        -- Inserir de 1 a 2 endereços para cada usuário
        FOR j IN 1..random_address_count LOOP
            -- Gerar código postal aleatório (exemplo: 12345-678)
            random_postal_code := LPAD(FLOOR(RANDOM() * 10000000)::TEXT, 8, '0');
            
            -- Gerar estado aleatório (aleatório entre os estados)
            random_state := CASE FLOOR(RANDOM() * 26) + 1
                WHEN 1 THEN 'AC' WHEN 2 THEN 'AL' WHEN 3 THEN 'AP' WHEN 4 THEN 'AM' 
                WHEN 5 THEN 'BA' WHEN 6 THEN 'CE' WHEN 7 THEN 'DF' WHEN 8 THEN 'ES' 
                WHEN 9 THEN 'GO' WHEN 10 THEN 'MA' WHEN 11 THEN 'MT' WHEN 12 THEN 'MS' 
                WHEN 13 THEN 'MG' WHEN 14 THEN 'PA' WHEN 15 THEN 'PB' WHEN 16 THEN 'PR' 
                WHEN 17 THEN 'PE' WHEN 18 THEN 'PI' WHEN 19 THEN 'RJ' WHEN 20 THEN 'RN' 
                WHEN 21 THEN 'RS' WHEN 22 THEN 'RO' WHEN 23 THEN 'RR' WHEN 24 THEN 'SC' 
                WHEN 25 THEN 'SP' WHEN 26 THEN 'SE' ELSE 'TO' END;
            
            -- Gerar nome da rua aleatório
            random_street := 'Rua ' || CHR(65 + (RANDOM() * 25)::INT);  -- Nome da rua aleatório (A a Z)
            
            -- Gerar número aleatório entre 1 e 1000
            random_number := FLOOR(RANDOM() * 1000) + 1;
            
            -- Gerar complemento aleatório
            random_complement := 'Complemento ' || (RANDOM() * 100)::INT;
            
            -- Inserir o endereço na tabela de endereços
            INSERT INTO public.addresses (
                name, postal_code, state, street, number, complement, user_id, created_at, updated_at
            ) VALUES (
                'Endereço ' || j,  -- Nome do endereço
                random_postal_code,
                random_state,
                random_street,
                random_number,
                random_complement,
                user_id,  -- Associar o endereço ao user_id gerado
                CURRENT_TIMESTAMP, 
                CURRENT_TIMESTAMP
            );
        END LOOP;
    END LOOP;
END $$;
