CREATE OR REPLACE FUNCTION check_cart_stock(p_cart_id INT)
RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
DECLARE
    faltando RECORD;
BEGIN
    SELECT cp.product_id, cp.quantity, p.stock_quantity
      INTO faltando
      FROM cart_products cp
      JOIN products p ON p.id = cp.product_id
     WHERE cp.cart_id = p_cart_id
       AND cp.quantity > p.stock_quantity
     LIMIT 1;

    IF faltando IS NOT NULL THEN
        RAISE EXCEPTION 'Produto % sem estoque suficiente (solicitado %, disponível %)',
            faltando.product_id, faltando.quantity, faltando.stock_quantity;
    END IF;

    RETURN TRUE;
END $$;
