INSERT INTO dw.dim_category (category_key, nome_categoria, parent_key)
SELECT id, name, parent_id
FROM public.categories
ON CONFLICT DO NOTHING;
