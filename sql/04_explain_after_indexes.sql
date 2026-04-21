\timing on
\echo '=== AFTER INDEXES ==='

SET max_parallel_workers_per_gather = 0;
SET work_mem = '32MB';
ANALYZE;

-- ============================================
-- TODO:
-- Скопируйте сюда ТО ЖЕ множество запросов из 02_explain_before.sql
-- и выполните EXPLAIN (ANALYZE, BUFFERS) повторно.
-- ============================================

\echo '--- Q1 ---'
-- TODO: EXPLAIN (ANALYZE, BUFFERS) ...
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, status, total_amount, created_at
FROM orders
WHERE user_id = (SELECT id FROM users ORDER BY id LIMIT 1) AND total_amount > 1500
ORDER BY created_at DESC
LIMIT 10;

\echo '--- Q2 ---'
-- TODO: EXPLAIN (ANALYZE, BUFFERS) ...
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, total_amount, created_at
FROM orders
WHERE status = 'paid'
  AND created_at >= '2024-12-01'
  AND created_at < '2024-12-08';

\echo '--- Q3 ---'
-- TODO: EXPLAIN (ANALYZE, BUFFERS) ...
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, SUM(oi.price * oi.quantity) AS total_spent
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.user_id = (SELECT id FROM users ORDER BY id OFFSET 5 LIMIT 1)
GROUP BY o.id
ORDER BY total_spent DESC
LIMIT 10;
-- (Опционально) Q4
-- TODO
