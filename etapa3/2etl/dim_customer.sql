INSERT INTO dw.dim_customer (customer_id, public_id, nome, last_name, email, role, subscription_plan)
SELECT u.id, u.public_id, u."name", u.last_name, u.email, r."name", sp."name"
FROM public.users u
JOIN public.roles r              ON r.id  = u.role_id
JOIN public.subscription_plans sp ON sp.id = u.subscription_plan_id
ON CONFLICT DO NOTHING;
