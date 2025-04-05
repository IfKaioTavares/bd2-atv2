WITH m AS (
  SELECT d.ano, d.mes,
         SUM(f.total_price) AS receita
  FROM dw.fact_sales f
  JOIN dw.dim_date d ON d.date_id = f.date_id
  GROUP BY d.ano, d.mes
)
SELECT *, 
       ROUND(100 * (receita - LAG(receita) OVER (ORDER BY ano, mes))
             / NULLIF(LAG(receita) OVER (ORDER BY ano, mes),0),2) AS crescimento_pct
FROM m
ORDER BY ano, mes;
