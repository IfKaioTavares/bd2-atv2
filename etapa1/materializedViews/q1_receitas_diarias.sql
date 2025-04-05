CREATE MATERIALIZED VIEW mv_receita_diaria AS
SELECT DATE_TRUNC('day', created_at)::date AS dia,
       SUM(total_price) AS receita
FROM   orders
WHERE  deleted = false
GROUP  BY 1
ORDER  BY 1;
