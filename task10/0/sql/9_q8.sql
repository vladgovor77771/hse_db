-- Select from t_books data about active books and get expected 
-- execution plan for this query. Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE is_active = 'Y';

--                                       QUERY PLAN                                       
-- ---------------------------------------------------------------------------------------
--  Bitmap Heap Scan on t_books  (cost=935.88..3961.36 rows=83559 width=62)
--    Recheck Cond: ((is_active)::text = 'Y'::text)
--    ->  Bitmap Index Scan on t_books_active_idx  (cost=0.00..914.99 rows=83559 width=0)
--          Index Cond: ((is_active)::text = 'Y'::text)