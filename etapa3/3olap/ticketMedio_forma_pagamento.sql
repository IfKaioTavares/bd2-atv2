SELECT c.subscription_plan,
       pm.nome,
       ROUND(AVG(f.total_price), 2) AS avg_ticket
FROM dw.fact_sales f
JOIN dw.dim_customer c ON c.customer_key = f.customer_key
JOIN dw.dim_payment_method pm ON pm.payment_method_key = f.payment_method_key
GROUP BY c.subscription_plan, pm.nome
ORDER BY avg_ticket DESC;
