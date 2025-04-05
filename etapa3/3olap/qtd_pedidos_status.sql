SELECT o.status, COUNT(*) AS qtde
FROM public.orders o
GROUP BY o.status;
