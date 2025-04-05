INSERT INTO dw.dim_brand (brand_id, nome_marca)
SELECT id, "name" FROM public.brands
ON CONFLICT DO NOTHING;
