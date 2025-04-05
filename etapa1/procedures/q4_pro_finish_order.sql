-- PROCEDURE: public.proc_finish_order(integer, integer, integer, integer, integer, integer)

-- DROP PROCEDURE IF EXISTS public.proc_finish_order(integer, integer, integer, integer, integer, integer);

CREATE OR REPLACE PROCEDURE public.proc_finish_order(
	IN p_cart_id integer,
	IN p_user_id integer,
	IN p_address_id integer,
	IN p_payment_method_id integer,
	IN p_coupon_id integer DEFAULT NULL::integer,
	IN p_discount_id integer DEFAULT NULL::integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    v_total   NUMERIC(10,2) := 0;
    v_order   INT;
    v_item    RECORD;
BEGIN
    PERFORM check_cart_stock(p_cart_id);

    FOR v_item IN
        SELECT cp.product_id, cp.quantity, p.price
        FROM cart_products cp
        JOIN products p ON cp.product_id = p.id
        WHERE cp.cart_id = p_cart_id
    LOOP
        v_total := v_total + v_item.price * v_item.quantity;
    END LOOP;

    INSERT INTO orders (
        user_id, address_id, payment_method_id,
        total_price, coupon_id, discount_id, status
    )
    VALUES (
        p_user_id, p_address_id, p_payment_method_id,
        v_total, p_coupon_id, p_discount_id, 'pendente'
    )
    RETURNING id INTO v_order;

    FOR v_item IN
        SELECT cp.product_id, cp.quantity, p.price
        FROM cart_products cp
        JOIN products p ON cp.product_id = p.id
        WHERE cp.cart_id = p_cart_id
    LOOP
        INSERT INTO order_items (
            order_id, product_id, quantity, unit_price
        )
        VALUES (
            v_order, v_item.product_id, v_item.quantity, v_item.price
        );

        UPDATE products
        SET stock_quantity = stock_quantity - v_item.quantity
        WHERE id = v_item.product_id;
    END LOOP;

    INSERT INTO delivery_logistics (
        order_id, status
    )
    VALUES (
        v_order, 'em separação'
    );

    DELETE FROM cart_products WHERE cart_id = p_cart_id;
END;
$BODY$;
ALTER PROCEDURE public.proc_finish_order(integer, integer, integer, integer, integer, integer)
    OWNER TO postgres;
