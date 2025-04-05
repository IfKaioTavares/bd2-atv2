DO $$
DECLARE
    carrinho RECORD;
    ts TIMESTAMPTZ;
BEGIN
    FOR carrinho IN
        SELECT cp.cart_id,
               MIN(cp.created_at) AS criado_em,
               c.user_id,
               a.id AS address_id
        FROM cart_products cp
        JOIN carts c ON c.id = cp.cart_id
        JOIN addresses a ON a.user_id = c.user_id
        WHERE cp.deleted = false
        GROUP BY cp.cart_id, c.user_id, a.id
    LOOP
        BEGIN
            ts := carrinho.criado_em + (INTERVAL '1 day' * (1 + floor(random() * 6)));

            CALL proc_finish_order(
                p_cart_id := carrinho.cart_id,
                p_user_id := carrinho.user_id,
                p_address_id := carrinho.address_id,
                p_payment_method_id := 1
            );

            UPDATE orders
            SET created_at = ts, updated_at = ts
            WHERE id = (SELECT MAX(id) FROM orders WHERE user_id = carrinho.user_id);

            UPDATE delivery_logistics
            SET created_at = ts, updated_at = ts
            WHERE order_id = (SELECT MAX(id) FROM orders WHERE user_id = carrinho.user_id);

            UPDATE order_items
            SET created_at = ts, updated_at = ts
            WHERE order_id = (SELECT MAX(id) FROM orders WHERE user_id = carrinho.user_id);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Erro ao finalizar carrinho %: %', carrinho.cart_id, SQLERRM;
        END;
    END LOOP;
END $$;
