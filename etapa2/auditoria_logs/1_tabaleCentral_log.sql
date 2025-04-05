-- 1. Tabela central de logs
CREATE TABLE audit_log (
    id           BIGSERIAL PRIMARY KEY,
    schema_name  TEXT,
    table_name   TEXT,
    op           CHAR(1),               -- I/U/D
    changed_by   TEXT,                  -- current_user
    pk           JSONB,                 -- chaves primárias
    old_data     JSONB,
    new_data     JSONB,
    changed_at   TIMESTAMPTZ DEFAULT now()
);