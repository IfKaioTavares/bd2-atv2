-- Criar a função do trigger
CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza o total_price somando o novo item ao valor total da ordem
    UPDATE orders
    SET total_price = total_price + (NEW.quantity * NEW.unit_price),
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.order_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o trigger
CREATE TRIGGER trg_update_order_total
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_order_total();
