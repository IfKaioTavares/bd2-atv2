INSERT INTO dw.dim_brand (brand_key, nome_marca)
SELECT id, name
FROM public.brands
ON CONFLICT DO NOTHING;
