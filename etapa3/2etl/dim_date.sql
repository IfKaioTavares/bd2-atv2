INSERT INTO dw.dim_date (date_id, dia, mes, ano, trimestre)
SELECT d::date,
       EXTRACT(DAY FROM d),
       EXTRACT(MONTH FROM d),
       EXTRACT(YEAR FROM d),
       EXTRACT(QUARTER FROM d)
FROM generate_series(
       '2020-01-01'::date,
       '2030-12-31'::date,
       INTERVAL '1 day'
) AS d
ON CONFLICT (date_id) DO NOTHING;
