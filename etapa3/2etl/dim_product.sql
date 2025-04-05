INSERT INTO dw.dim_product (product_id, nome_produto, brand_id, category_id)
SELECT p.id, p."name", p.brand_id, pc.category_id
FROM public.products p
LEFT JOIN public.product_categories pc ON pc.product_id = p.id
ON CONFLICT DO NOTHING;
