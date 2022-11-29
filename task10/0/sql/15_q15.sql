-- Run the query from step 15 with expected execution plan. Please, explain the result.
-- step 13???

EXPLAIN SELECT * FROM t_books WHERE LOWER(title) LIKE 'relational%';
--                          QUERY PLAN                          
-- -------------------------------------------------------------
--  Seq Scan on t_books  (cost=0.00..4494.97 rows=838 width=64)
--    Filter: (lower((title)::text) ~~ 'relational%'::text)

EXPLAIN SELECT * FROM t_books WHERE UPPER(title) LIKE 'RELATIONAL%';
--                          QUERY PLAN                          
-- -------------------------------------------------------------
--  Seq Scan on t_books  (cost=0.00..4494.97 rows=838 width=64)
--    Filter: (upper((title)::text) ~~ 'relational%'::text)

-- Индексы не используются.

EXPLAIN SELECT * FROM t_books WHERE UPPER(SUBSTRING(title, 1, 10)) = 'RELATIONAL';

--                                    QUERY PLAN                                    
-- ---------------------------------------------------------------------------------
--  Gather  (cost=1000.00..4790.07 rows=838 width=64)
--    Workers Planned: 1
--    ->  Parallel Seq Scan on t_books  (cost=0.00..3706.27 rows=493 width=64)
--          Filter: (upper("substring"((title)::text, 1, 10)) = 'RELATIONAL'::text)

-- Использование SUBSTRING тоже не работает.