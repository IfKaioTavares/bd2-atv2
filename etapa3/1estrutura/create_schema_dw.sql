-- schema
CREATE SCHEMA IF NOT EXISTS dw;

-- dimensões
CREATE TABLE dw.dim_date (
  date_id       date PRIMARY KEY,
  dia           int,
  mes           int,
  ano           int,
  trimestre     int
);

CREATE TABLE dw.dim_brand (
  brand_id      int PRIMARY KEY,
  nome_marca    varchar(50)
);

CREATE TABLE dw.dim_category (
  category_id   int PRIMARY KEY,
  nome_categoria varchar(50),
  parent_id     int
);

CREATE TABLE dw.dim_product (
  product_id    int PRIMARY KEY,
  nome_produto  varchar(50),
  brand_id      int,
  category_id   int
);

CREATE TABLE dw.dim_customer (
  customer_id       int PRIMARY KEY,
  public_id         uuid,
  nome              varchar(50),
  last_name         varchar(100),
  email             varchar(50),
  role              varchar(3),
  subscription_plan varchar(15)
);

CREATE TABLE dw.dim_payment_method (
  payment_method_id int PRIMARY KEY,
  nome              varchar(50),
  descricao         varchar(50)
);

CREATE TABLE dw.dim_coupon (
  coupon_id         int PRIMARY KEY,
  code              varchar(20),
  discount_pct      numeric(5,2),
  start_date        timestamptz,
  end_date          timestamptz
);

-- fato
CREATE TABLE dw.fact_sales (
  fact_id           serial PRIMARY KEY,
  order_id          int,
  product_id        int,
  date_id           date,
  customer_id       int,
  payment_method_id int,
  coupon_id         int,
  qty               int,
  unit_price        numeric(10,2),
  discount_pct      numeric(5,2),
  total_price       numeric(10,2)
);
