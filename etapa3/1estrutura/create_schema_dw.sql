-- Remove o schema (e todos os objetos nele) se existir
DROP SCHEMA IF EXISTS dw CASCADE;

-- Cria o schema
CREATE SCHEMA IF NOT EXISTS dw;

-- Dimensão Data com surrogate key
DROP TABLE IF EXISTS dw.dim_date;
CREATE TABLE dw.dim_date (
    date_key   SERIAL PRIMARY KEY,
    full_date  DATE NOT NULL UNIQUE,
    dia        INT NOT NULL,
    mes        INT NOT NULL,
    ano        INT NOT NULL,
    trimestre  INT NOT NULL
);

-- Table Triggers
create trigger trigger_update_timestamp_dim_date before
delete
   or
update
   on
   dw.dim_date for each row execute function update_timestamp();

-- Dimensão Marca
DROP TABLE IF EXISTS dw.dim_brand;
CREATE TABLE dw.dim_brand (
    brand_key  SERIAL PRIMARY KEY,
    nome_marca VARCHAR(50) NOT NULL
);

-- Dimensão Categoria com auto-relacionamento
DROP TABLE IF EXISTS dw.dim_category;
CREATE TABLE dw.dim_category (
    category_key   SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL,
    parent_key     INT,
    FOREIGN KEY (parent_key) REFERENCES dw.dim_category(category_key)
);

-- Dimensão Produto
DROP TABLE IF EXISTS dw.dim_product;
CREATE TABLE dw.dim_product (
    product_key   SERIAL PRIMARY KEY,
    nome_produto  VARCHAR(50) NOT NULL,
    brand_key     INT NOT NULL,
    category_key  INT NOT NULL,
    FOREIGN KEY (brand_key) REFERENCES dw.dim_brand(brand_key),
    FOREIGN KEY (category_key) REFERENCES dw.dim_category(category_key)
);

-- Dimensão Cliente
DROP TABLE IF EXISTS dw.dim_customer;
CREATE TABLE dw.dim_customer (
    customer_key     SERIAL PRIMARY KEY,
    public_id        UUID NOT NULL,
    nome             VARCHAR(50) NOT NULL,
    last_name        VARCHAR(100) NOT NULL,
    email            VARCHAR(50) NOT NULL,
    role             VARCHAR(3),
    subscription_plan VARCHAR(15)
);

-- Dimensão Método de Pagamento
DROP TABLE IF EXISTS dw.dim_payment_method;
CREATE TABLE dw.dim_payment_method (
    payment_method_key SERIAL PRIMARY KEY,
    nome               VARCHAR(50) NOT NULL,
    descricao          VARCHAR(50)
);

-- Dimensão Cupom
DROP TABLE IF EXISTS dw.dim_coupon;
CREATE TABLE dw.dim_coupon (
    coupon_key   SERIAL PRIMARY KEY,
    code         VARCHAR(20) NOT NULL,
    discount_pct NUMERIC(5,2),
    start_date   TIMESTAMPTZ,
    end_date     TIMESTAMPTZ
);

-- Tabela Fato de Vendas
DROP TABLE IF EXISTS dw.fact_sales;
CREATE TABLE dw.fact_sales (
    fact_key           SERIAL PRIMARY KEY,
    order_id           INT NOT NULL,
    product_key        INT NOT NULL,
    date_key           INT NOT NULL,
    customer_key       INT NOT NULL,
    payment_method_key INT NOT NULL,
    coupon_key         INT,
    qty                INT NOT NULL,
    unit_price         NUMERIC(10,2) NOT NULL,
    discount_pct       NUMERIC(5,2),
    total_price        NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (product_key)        REFERENCES dw.dim_product(product_key),
    FOREIGN KEY (date_key)           REFERENCES dw.dim_date(date_key),
    FOREIGN KEY (customer_key)       REFERENCES dw.dim_customer(customer_key),
    FOREIGN KEY (payment_method_key) REFERENCES dw.dim_payment_method(payment_method_key),
    FOREIGN KEY (coupon_key)         REFERENCES dw.dim_coupon(coupon_key)
);
