DO $$ 
DECLARE 
    brand_id INT;
BEGIN 
    FOR i IN 1..10000 LOOP
        -- Escolhe um ID de marca aleatório dentro do intervalo existente
        SELECT id INTO brand_id FROM public.brands ORDER BY RANDOM() LIMIT 1;

        INSERT INTO public.products (name, description, brand_id, price, stock_quantity) 
        VALUES (
            'Produto ' || i::TEXT, 
            'Descrição do produto ' || i::TEXT, 
            brand_id, 
            ROUND((RANDOM() * 900 + 100)::NUMERIC, 2), -- Converte para NUMERIC antes de arredondar
            FLOOR(RANDOM() * 100 + 1) -- Gera um estoque entre 1 e 100
        );
    END LOOP;
END $$;