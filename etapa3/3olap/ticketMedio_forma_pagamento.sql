SELECT c.subscription_plan,
       pm.nome,
       ROUND(AVG(f.total_price),2) AS avg_ticket
FROM dw.fact_sales f
JOIN dw.dim_customer c         ON c.customer_id        = f.customer_id
JOIN dw.dim_payment_method pm ON pm.payment_method_id = f.payment_method_id
GROUP BY c.subscription_plan, pm.nome
ORDER BY avg_ticket DESC;
