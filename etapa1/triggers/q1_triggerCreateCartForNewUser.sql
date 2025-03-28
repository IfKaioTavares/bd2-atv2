-- Criar a função que será chamada pela trigger
CREATE OR REPLACE FUNCTION create_cart_for_new_user()
RETURNS TRIGGER AS $$
BEGIN
    -- Insere um novo carrinho para o usuário recém-criado
    INSERT INTO public.carts (user_id) 
    VALUES (NEW.id);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar a trigger que chama a função após a inserção de um novo usuário
CREATE TRIGGER after_user_insert_create_cart
AFTER INSERT ON public.users
FOR EACH ROW
EXECUTE FUNCTION create_cart_for_new_user();