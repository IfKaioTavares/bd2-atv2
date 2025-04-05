DO $$
DECLARE
    i INTEGER := 1;
    cart_id INTEGER := 2;
    j INTEGER;
    max_cart_id INTEGER;
    random_product_id INTEGER;
BEGIN
    -- Obter o maior ID da tabela carts
    SELECT MAX(id) INTO max_cart_id FROM carts;

    WHILE cart_id <= max_cart_id LOOP
        FOR j IN 1..7 LOOP
            random_product_id := FLOOR(1 + RANDOM() * 582)::INTEGER;
            IF product_exists(random_product_id) THEN
                INSERT INTO cart_products (cart_id, product_id, quantity)
                VALUES (
                    cart_id,
                    random_product_id,
                    FLOOR(1 + RANDOM() * 10)::INTEGER
                );
            END IF;
        END LOOP;
        cart_id := cart_id + 1;
        i := i + 1;
    END LOOP;
END $$;