-- FUNCTION: public.product_exists(integer)

-- DROP FUNCTION IF EXISTS public.product_exists(integer);

CREATE OR REPLACE FUNCTION public.product_exists(
	p_id integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM products WHERE id = p_id) INTO exists;
    RETURN exists;
END;
$BODY$;

ALTER FUNCTION public.product_exists(integer)
    OWNER TO postgres;
