CREATE OR REPLACE VIEW v_entregas_detalhadas AS
SELECT o.id               AS order_id,
       o.status           AS status_pedido,
       dl.status          AS status_entrega,
       dl.tracking_number,
       dl.estimated_delivery_date,
       o.created_at       AS pedido_em
FROM   orders o
JOIN   delivery_logistics dl ON dl.order_id = o.id
WHERE  o.deleted = false
  AND  dl.deleted = false;