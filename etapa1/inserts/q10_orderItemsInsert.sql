-- Inserindo 20.000 registros na tabela order_items
INSERT INTO public.order_items (order_id, product_id, quantity, unit_price)
SELECT 
    -- Seleciona um ID aleatório da tabela orders
    (SELECT id FROM public.orders ORDER BY random() LIMIT 1) AS order_id,

    -- Seleciona um ID aleatório da tabela products
    (SELECT id FROM public.products ORDER BY random() LIMIT 1) AS product_id,

    -- Gera um valor aleatório para a quantidade, entre 1 e 1000
    FLOOR(random() * 1000 + 1)::integer AS quantity,

    -- Obtém o preço do produto correspondente ao ID selecionado
    (SELECT price FROM public.products WHERE id = product_id) AS unit_price

-- Gera 20.000 linhas para inserção usando generate_series
FROM generate_series(1, 20000);
