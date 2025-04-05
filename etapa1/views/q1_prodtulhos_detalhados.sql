CREATE OR REPLACE VIEW v_products_detalhados AS
SELECT p.id,
       p.name              AS produto,
       b.name              AS marca,
       c.name              AS categoria,
       p.price,
       p.stock_quantity,
       p.created_at
FROM   products p
JOIN   brands   b ON b.id = p.brand_id
LEFT  JOIN product_categories pc ON pc.product_id = p.id AND pc.deleted = false
LEFT  JOIN categories c ON c.id = pc.category_id;
