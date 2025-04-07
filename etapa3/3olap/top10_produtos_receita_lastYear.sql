SELECT p.nome_produto,
       SUM(f.qty) AS unidades,
       SUM(f.total_price) AS receita
FROM dw.fact_sales f
JOIN dw.dim_product p ON p.product_key = f.product_key
JOIN dw.dim_date d ON d.date_key = f.date_key
WHERE d.full_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY p.nome_produto
ORDER BY receita DESC
LIMIT 10;
