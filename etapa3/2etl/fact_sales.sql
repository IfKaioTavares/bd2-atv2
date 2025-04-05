INSERT INTO dw.fact_sales
      (order_id, product_id, date_id, customer_id, payment_method_id,
       coupon_id, qty, unit_price, discount_pct, total_price)
SELECT  o.id,
        oi.product_id,
        o.created_at::date AS date_id,
        o.user_id,
        o.payment_method_id,
        o.coupon_id,
        oi.quantity,
        oi.unit_price,
        COALESCE(c.discount_percentage, 0),
        o.total_price
FROM public.orders o
JOIN public.order_items oi ON oi.order_id = o.id
LEFT JOIN public.coupons   c ON c.id = o.coupon_id
LEFT JOIN dw.fact_sales fs ON fs.order_id = o.id
WHERE fs.order_id IS NULL;
