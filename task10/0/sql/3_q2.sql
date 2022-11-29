-- Select from t_books data about book with title 'Oracle Core' and 
-- get expected execution plan for this query (in Oracle: SET AUTOTRACE 
-- ON – SET AUTOTRACE OFF; in postgresql: EXPLAIN). Please, explain the result.

EXPLAIN SELECT * FROM t_books WHERE title = 'Oracle Core';

--                         QUERY PLAN                         
-- -----------------------------------------------------------
--  Seq Scan on t_books  (cost=0.00..4075.97 rows=3 width=63)
--    Filter: ((title)::text = 'Oracle Core'::text)
-- (2 rows)
