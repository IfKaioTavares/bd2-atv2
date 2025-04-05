INSERT INTO dw.dim_payment_method (payment_method_id, nome, descricao)
SELECT id, "name", description FROM public.payment_methods
ON CONFLICT DO NOTHING;
