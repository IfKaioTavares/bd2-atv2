DO $$ 
DECLARE 
    i INT;
    coupon_code TEXT;
    discount NUMERIC(5,2);
    start_date TIMESTAMP;
    end_date TIMESTAMP;
    usage_limit INT;
BEGIN 
    FOR i IN 1..500 LOOP
        -- Gera um código de cupom único
        coupon_code := 'CUPOM' || LPAD(i::TEXT, 5, '0');

        -- Gera um desconto aleatório entre 5% e 50%, múltiplo de 5
        discount := (FLOOR(RANDOM() * 10) * 5 + 5)::NUMERIC;

        -- Define a data de início como hoje
        start_date := NOW();

        -- Define a data de término entre 30 e 90 dias após a data de início
        end_date := start_date + (30 + FLOOR(RANDOM() * 60)) * INTERVAL '1 day';

        -- Define um limite de uso aleatório entre 10 e 1000
        usage_limit := FLOOR(RANDOM() * 991 + 10);

        INSERT INTO public.coupons (code, discount_percentage, start_date, end_date, usage_limit)
        VALUES (coupon_code, discount, start_date, end_date, usage_limit);
    END LOOP;
END $$;
