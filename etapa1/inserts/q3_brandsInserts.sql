INSERT INTO public.brands (name)
SELECT 'Marca ' || i
FROM generate_series(1, 500) AS i;