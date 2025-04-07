INSERT INTO dw.dim_product (product_key, nome_produto, brand_key, category_key)
SELECT p.id, p.name, p.brand_id, pc.category_id
FROM public.products p
JOIN public.product_categories pc ON pc.product_id = p.id
ON CONFLICT DO NOTHING;
