\timing on
\echo '=== APPLY INDEXES ==='

-- ============================================
-- TODO: Создайте индексы на основе ваших EXPLAIN ANALYZE
-- ============================================

-- Индекс 1
CREATE INDEX idx_orders_user_created ON orders USING BTREE (user_id, created_at DESC);

-- Индекс 2
CREATE INDEX idx_orders_status_date ON orders USING BTREE (status, created_at);

-- Индекс 3
CREATE INDEX idx_order_items_order_id ON order_items USING BTREE (order_id);

ANALYZE;
