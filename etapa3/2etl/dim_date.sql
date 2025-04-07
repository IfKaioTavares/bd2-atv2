INSERT INTO dw.dim_date (full_date, dia, mes, ano, trimestre)
SELECT d,
       EXTRACT(DAY FROM d)::int,
       EXTRACT(MONTH FROM d)::int,
       EXTRACT(YEAR FROM d)::int,
       EXTRACT(QUARTER FROM d)::int
FROM generate_series('2020-01-01'::date, '2030-12-31'::date, INTERVAL '1 day') AS gs(d)
ON CONFLICT (full_date) DO NOTHING;
