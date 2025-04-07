INSERT INTO dw.dim_coupon (coupon_key, code, discount_pct, start_date, end_date)
SELECT id, code, discount_percentage, start_date, end_date
FROM public.coupons
ON CONFLICT DO NOTHING;
