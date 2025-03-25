INSERT INTO public.carts (user_id)
SELECT i FROM generate_series(1, 10001) AS i;
