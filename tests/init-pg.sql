CREATE TABLE IF NOT EXISTS users (
    id      BIGSERIAL PRIMARY KEY,
    name    TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS organisations (
    id      BIGSERIAL PRIMARY KEY,
    name    TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
    id      BIGSERIAL PRIMARY KEY,
    name    TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS items (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    category_id BIGINT NOT NULL REFERENCES categories(id),
    price       BIGINT NOT NULL DEFAULT 0,
    stock       BIGINT NOT NULL DEFAULT 0,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id       BIGSERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    price    BIGINT NOT NULL DEFAULT 0,
    stock    BIGINT NOT NULL DEFAULT 0,
    category TEXT NOT NULL DEFAULT ''
);

INSERT INTO users (id, name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'Diana'),
    (5, 'Eve')
ON CONFLICT (id) DO NOTHING;

INSERT INTO organisations (id, name) VALUES
    (1, 'Org Alpha'),
    (2, 'Org Beta'),
    (3, 'Org Gamma')
ON CONFLICT (id) DO NOTHING;

INSERT INTO categories (id, name) VALUES
    (1, 'Electronics'),
    (2, 'Books'),
    (3, 'Clothing')
ON CONFLICT (id) DO NOTHING;

INSERT INTO items (id, name, category_id, price, stock, created_at) VALUES
    (1,  'Laptop',      1, 150000, 10, '2025-01-15 10:00:00'),
    (2,  'Mouse',       1,   2500, 200, '2025-02-10 12:00:00'),
    (3,  'Keyboard',    1,   8000, 150, '2025-03-05 09:30:00'),
    (4,  'Rust Book',   2,   4500, 300, '2025-04-20 14:00:00'),
    (5,  'T-Shirt',     3,   2000, 500, '2025-05-01 08:00:00'),
    (6,  'Headphones',  1,  12000, 75,  '2025-05-10 16:00:00'),
    (7,  'Monitor',     1,  35000, 30,  '2025-06-01 11:00:00')
ON CONFLICT (id) DO NOTHING;

INSERT INTO products (id, name, price, stock, category) VALUES
    (1, 'Smartphone',   40000,  50, 'Electronics'),
    (2, 'Tablet',       80000,  30, 'Electronics'),
    (3, 'Notebook',       500, 500, 'Stationery'),
    (4, 'Desk Lamp',    3500, 100, 'Furniture'),
    (5, 'Backpack',     6000,  80, 'Accessories'),
    (6, 'USB Cable',    1000,  0,  'Electronics'),
    (7, 'Hard Drive',  12000,  20, 'Electronics')
ON CONFLICT (id) DO NOTHING;

SELECT setval('users_id_seq', COALESCE((SELECT MAX(id) FROM users), 1));
SELECT setval('organisations_id_seq', COALESCE((SELECT MAX(id) FROM organisations), 1));
SELECT setval('categories_id_seq', COALESCE((SELECT MAX(id) FROM categories), 1));
SELECT setval('items_id_seq', COALESCE((SELECT MAX(id) FROM items), 1));
SELECT setval('products_id_seq', COALESCE((SELECT MAX(id) FROM products), 1));
