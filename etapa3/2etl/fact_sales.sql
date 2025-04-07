INSERT INTO dw.fact_sales
      (order_id, product_key, date_key, customer_key, payment_method_key,
       coupon_key, qty, unit_price, discount_pct, total_price)
SELECT  o.id,
        oi.product_id,
        dd.date_key,
        o.user_id,
        o.payment_method_id,
        o.coupon_id,
        oi.quantity,
        oi.unit_price,
        COALESCE(c.discount_percentage, 0),
        o.total_price
FROM public.orders o
JOIN public.order_items oi ON oi.order_id = o.id
JOIN dw.dim_date dd ON dd.full_date = o.created_at::date
LEFT JOIN public.coupons c ON c.id = o.coupon_id
LEFT JOIN dw.fact_sales fs ON fs.order_id = o.id
WHERE fs.order_id IS NULL;
