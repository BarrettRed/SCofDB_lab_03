\timing on
\echo '=== BEFORE OPTIMIZATION ==='

-- Рекомендуемые настройки для сравнимых замеров
SET max_parallel_workers_per_gather = 0;
SET work_mem = '32MB';
ANALYZE;

-- ============================================
-- TODO: Добавьте не менее 3 запросов
-- Для каждого обязательно: EXPLAIN (ANALYZE, BUFFERS)
-- ============================================

\echo '--- Q1: Фильтрация + сортировка (пример класса запроса) ---'
-- TODO: Подставьте свой запрос
-- Пример класса:
-- EXPLAIN (ANALYZE, BUFFERS)
-- SELECT ...
-- FROM orders
-- WHERE ...
-- ORDER BY created_at DESC
-- LIMIT ...;
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, status, total_amount, created_at
FROM orders
WHERE user_id = (SELECT id FROM users ORDER BY id LIMIT 1)
ORDER BY created_at DESC
LIMIT 10;

\echo '--- Q2: Фильтрация по статусу + диапазону дат ---'
-- TODO: Подставьте свой запрос
-- EXPLAIN (ANALYZE, BUFFERS)
-- SELECT ...
-- FROM orders
-- WHERE status = 'paid'
--   AND created_at >= ...
--   AND created_at < ...;
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, user_id, total_amount, created_at
FROM orders
WHERE status = 'paid'
  AND created_at >= '2024-12-01'
  AND created_at < '2024-12-08';

\echo '--- Q3: JOIN + GROUP BY ---'
-- TODO: Подставьте свой запрос
-- EXPLAIN (ANALYZE, BUFFERS)
-- SELECT ...
-- FROM orders o
-- JOIN order_items oi ON oi.order_id = o.id
-- WHERE ...
-- GROUP BY ...
-- ORDER BY ...
-- LIMIT ...;
EXPLAIN (ANALYZE, BUFFERS)
SELECT o.id, SUM(oi.price * oi.quantity) AS total_spent
FROM orders o
JOIN order_items oi ON oi.order_id = o.id
WHERE o.user_id = (SELECT id FROM users ORDER BY id OFFSET 5 LIMIT 1)
GROUP BY o.id
ORDER BY total_spent DESC
LIMIT 10;


-- (Опционально) Q4: полный агрегат по периоду, который сложно ускорить индексами
