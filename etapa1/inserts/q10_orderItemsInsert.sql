INSERT INTO public.order_items (order_id, product_id, quantity, unit_price)
SELECT 
    (floor(random() * (SELECT MAX(id) FROM public.orders)) + 1)::int AS order_id,  -- Seleciona um pedido aleatório
    (floor(random() * 10000) + 1)::int AS product_id,  -- Seleciona um produto aleatório entre 1 e 10.000
    (floor(random() * 2000) + 1)::int AS quantity,  -- Quantidade aleatória entre 1 e 2000
    (SELECT price FROM public.products WHERE id = product_id) AS unit_price  -- Obtém o preço do produto
FROM generate_series(1, 15000);
