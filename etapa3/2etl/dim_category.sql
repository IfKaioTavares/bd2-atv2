INSERT INTO dw.dim_category (category_id, nome_categoria, parent_id)
SELECT id, "name", parent_id FROM public.categories
ON CONFLICT DO NOTHING;
