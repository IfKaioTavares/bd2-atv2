CREATE OR REPLACE PROCEDURE proc_update_delivery_logistics(
    p_order_id INT,
    p_status VARCHAR,
    p_tracking_number VARCHAR DEFAULT NULL,
    p_estimated_date DATE DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE delivery_logistics
    SET status = p_status,
        tracking_number = COALESCE(p_tracking_number, tracking_number),
        estimated_delivery_date = COALESCE(p_estimated_date, estimated_delivery_date),
        updated_at = CURRENT_TIMESTAMP
    WHERE order_id = p_order_id
      AND deleted = false;

    IF NOT FOUND THEN
        RAISE NOTICE 'Nenhum registro encontrado para order_id %', p_order_id;
    END IF;
END;
$$;
