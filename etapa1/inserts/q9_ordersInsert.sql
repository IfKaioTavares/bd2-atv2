-- Inserir 15000 ordens de compra com valores aleatórios
INSERT INTO public.orders (user_id, address_id, payment_method_id, total_price, coupon_id, discount_id, status, created_at, updated_at, deleted)
SELECT
    u.id AS user_id,
    a.id AS address_id,
    (FLOOR(RANDOM() * 4) + 1) AS payment_method_id, -- Métodos de pagamento aleatórios (1 a 4)
    ROUND((RANDOM() * 500 + 50)::numeric, 2) AS total_price, -- Valor total entre 50 e 550 com casting correto
    (CASE WHEN RANDOM() < 0.8 THEN FLOOR(RANDOM() * 500) + 1 ELSE NULL END) AS coupon_id, -- 80% de chance de ter cupom
    (CASE WHEN RANDOM() < 0.8 THEN FLOOR(RANDOM() * 5000) + 1 ELSE NULL END) AS discount_id, -- 80% de chance de ter desconto
    CASE FLOOR(RANDOM() * 10 + 1) -- Garante um valor de 1 a 10
        WHEN 1 THEN 'Aguardando pagamento'
        WHEN 2 THEN 'Pagamento realizado'
        WHEN 3 THEN 'Aguardando envio'
        WHEN 4 THEN 'A caminho (enviado)'
        WHEN 5 THEN 'Pedido entregue'
        WHEN 6 THEN 'Aguardando retirada'
        WHEN 7 THEN 'Pedido cancelado'
        WHEN 8 THEN 'Pedido em rascunho'
        WHEN 9 THEN 'Pedido concluído'
        ELSE 'Pedido processado'
    END AS status,
    CURRENT_TIMESTAMP AS created_at,
    CURRENT_TIMESTAMP AS updated_at,
    FALSE AS deleted
FROM users u
JOIN addresses a ON a.user_id = u.id
ORDER BY RANDOM()
LIMIT 15000;