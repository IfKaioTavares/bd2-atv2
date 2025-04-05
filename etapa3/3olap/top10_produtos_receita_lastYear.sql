SELECT p.nome_produto,
       SUM(f.qty)         AS unidades,
       SUM(f.total_price) AS receita
FROM dw.fact_sales f
JOIN dw.dim_product p ON p.product_id = f.product_id
JOIN dw.dim_date d    ON d.date_id    = f.date_id
WHERE d.date_id >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY p.nome_produto
ORDER BY receita DESC
LIMIT 10;
