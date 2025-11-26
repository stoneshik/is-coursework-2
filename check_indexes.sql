-- Пошаговое тестирование индексов - сначала все без индексов, потом все с индексами

-- Отключаем индексы для первой части тестов
SET enable_indexscan = off;
SET enable_bitmapscan = off;

-- 1. user_email_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM users WHERE user_email = 'user_50000@example.com';

-- 2. user_login_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM users WHERE user_login = 'user_75000';

-- 3. order_type_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM orders WHERE order_type = 'print';

-- 4. order_status_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM orders WHERE order_status = 'completed';

-- 5. vending_point_schedule_day_week_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM vending_point_schedules WHERE vending_point_schedule_day_week = 'monday';

-- 6. vending_point_unusual_schedule_date_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM vending_point_unusual_schedules WHERE vending_point_unusual_schedule_date = current_date - interval '10 days';

-- 7. function_variant_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM function_variants WHERE function_variant = 'color_print';

-- 8. machine_supplies_datetime_index_btree
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM machine_supplies WHERE machine_supplies_datetime BETWEEN now() - interval '30 days' AND now();

-- 9. machine_condition_datetime_index_btree
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM machine_conditions WHERE machine_condition_datetime BETWEEN now() - interval '7 days' AND now();

-- Включаем индексы для второй части тестов
SET enable_indexscan = on;
SET enable_bitmapscan = on;

-- 1. user_email_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM users WHERE user_email = 'user_50000@example.com';

-- 2. user_login_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM users WHERE user_login = 'user_75000';

-- 3. order_type_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM orders WHERE order_type = 'print';

-- 4. order_status_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM orders WHERE order_status = 'completed';

-- 5. vending_point_schedule_day_week_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM vending_point_schedules WHERE vending_point_schedule_day_week = 'monday';

-- 6. vending_point_unusual_schedule_date_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM vending_point_unusual_schedules WHERE vending_point_unusual_schedule_date = current_date - interval '10 days';

-- 7. function_variant_index_hash
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM function_variants WHERE function_variant = 'color_print';

-- 8. machine_supplies_datetime_index_btree
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM machine_supplies WHERE machine_supplies_datetime BETWEEN now() - interval '30 days' AND now();

-- 9. machine_condition_datetime_index_btree
EXPLAIN (ANALYZE, BUFFERS)
SELECT COUNT(*) FROM machine_conditions WHERE machine_condition_datetime BETWEEN now() - interval '7 days' AND now();
