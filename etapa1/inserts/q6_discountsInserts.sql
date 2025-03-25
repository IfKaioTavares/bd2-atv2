DO $$
DECLARE
    i INTEGER;
    v_discount NUMERIC(5,2);
    v_start_date TIMESTAMPTZ;
    v_end_date TIMESTAMPTZ;
BEGIN
    FOR i IN 1..5000 LOOP
        -- Gera um desconto aleatório entre 5% e 50%
        v_discount := round((random() * 45 + 5)::numeric, 2);
        
        IF random() < 0.5 THEN
            -- Desconto expirado:
            -- Data de início entre (now() - 365 dias) e (now() - 30 dias)
            v_start_date := now() - interval '30 days' - (random() * interval '335 days');
            -- Data de fim um pouco após a data de início, mas antes de now()
            v_end_date := v_start_date + (random() * interval '29 days');
        ELSE
            -- Desconto ativo:
            -- Data de início entre (now() - 365 dias) e agora
            v_start_date := now() - (random() * interval '365 days');
            -- Data de fim entre (now() + 1 dia) e (now() + 365 dias)
            v_end_date := now() + interval '1 day' + (random() * interval '364 days');
        END IF;
        
        INSERT INTO public.discounts(product_id, discount_percentage, start_date, end_date)
        VALUES (i, v_discount, v_start_date, v_end_date);
    END LOOP;
END $$;