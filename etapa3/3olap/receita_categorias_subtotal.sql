SELECT COALESCE(cat.nome_categoria, 'TOTAL') AS categoria,
       SUM(f.total_price) AS receita
FROM dw.fact_sales f
LEFT JOIN dw.dim_product p ON p.product_key = f.product_key
LEFT JOIN dw.dim_category cat ON cat.category_key = p.category_key
GROUP BY ROLLUP (cat.nome_categoria)
ORDER BY receita DESC;
