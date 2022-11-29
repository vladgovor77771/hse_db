-- Select from t_books data about book with title 'Oracle Core' 
-- and get expected execution plan for this query. Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE title = 'Oracle Core';

--                                    QUERY PLAN                                   
-- --------------------------------------------------------------------------------
--  Bitmap Heap Scan on t_books  (cost=4.44..16.13 rows=3 width=62)
--    Recheck Cond: ((title)::text = 'Oracle Core'::text)
--    ->  Bitmap Index Scan on t_books_title_idx  (cost=0.00..4.44 rows=3 width=0)
--          Index Cond: ((title)::text = 'Oracle Core'::text)

-- Вместо Seq Scan наблюдаем Bitmap Heap Scan

-- https://stackoverflow.com/questions/6592626/what-is-a-bitmap-heap-scan-in-a-query-plan
--   In short, it's a bit like a seq scan. The difference is that, 
--   rather than visiting every disk page, a bitmap index scan ANDs 
--   and ORs applicable indexes together, and only visits the disk 
--   pages that it needs to.