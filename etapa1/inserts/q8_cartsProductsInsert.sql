DO $$
DECLARE 
    i INTEGER;
    v_cart_id INTEGER;
    v_product_id INTEGER;
    v_quantity INTEGER;
BEGIN
    FOR i IN 1..20000 LOOP
        v_cart_id := floor(random() * 10001) + 1;
        v_product_id := floor(random() * 10000) + 1;
        v_quantity := floor(random() * 50) + 1;

        INSERT INTO public.cart_products (cart_id, product_id, quantity)
        VALUES (v_cart_id, v_product_id, v_quantity);
    END LOOP;
END $$;
