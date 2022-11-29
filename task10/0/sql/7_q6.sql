-- Select from t_books data about book with title 'Oracle Core' 
-- and get expected execution plan for this query. Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE title = 'Oracle Core';

--                                    QUERY PLAN                                   
-- --------------------------------------------------------------------------------
--  Bitmap Heap Scan on t_books  (cost=4.44..16.13 rows=3 width=62)
--    Recheck Cond: ((title)::text = 'Oracle Core'::text)
--    ->  Bitmap Index Scan on t_books_title_idx  (cost=0.00..4.44 rows=3 width=0)
--          Index Cond: ((title)::text = 'Oracle Core'::text)